package {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.display.Sprite;
	
	public class Main extends Sprite {
		static private const IMPULSE_SIZE:Number = 20;
		static private const PLAYER_RADIUS:int = 45;
		static private const ATTACK_RADIUS:int = 175;
		static private const LEFT_ARROW_KEYCODE:Number = 37;
		
		private var userInterface:MovieClip;
		private var player:MovieClip;
		private var level:MovieClip;
		private var textBox:MovieClip;
		private var restartGameFunction:Function;
		// cannot use stage.gotoAndPlay(1) for some reason, so pass in a function from the timeline that does that
		
		private var lastDir:String = "right";
		private var savedX:Number;
		private var savedY:Number;
		private var leftKeyDown:Boolean = false;
		private var rightKeyDown:Boolean = false;
		private var spaceKeyDown:Boolean = false;
		private var shiftKeyDown:Boolean = false;
		private var grounded:Boolean = false;
		private var invincible:Boolean = false;
		private var attacking:Boolean = false;
		private var can_attack:Boolean = true;
		private var canAdvanceText:Boolean = true;
		private var canMove:Boolean = false;
		private var canJump:Boolean = false;
		private var canAttack:Boolean = false;
		private var collectedItem:Boolean = false;
		private var mainSpeed:Number = 15;
		private var jumpSpeed:Number = 0;
		private var gravity:Number = 1.5;
		private var j:int;
		private var score:int = 0;
		private var life:int = 6;
		private var mission:int = 0
		private var tutorial:int = 1;
		private var curLevel:int = 1;
		private var missionSoundsChannel:SoundChannel = new SoundChannel();
		private var questSound:Sound = new Bell_alert();
		private var completeSound:Sound = new Mission_complete();
		private var tocker:Timer = new Timer(1000);
		
		public function Main(ui:MovieClip, player:MovieClip, level:MovieClip, textDisplay:MovieClip, restartGameFunction:Function) {
			this.player = player;
			this.userInterface = ui;
			this.level = level;
			this.textBox = textDisplay;
			this.restartGameFunction = restartGameFunction;
			super();
		}
		
		public function startGame():void {
			assert(stage != null, "Main needs to be added to the stage before calling startGame on it")
			initializeUserInterface();
			addlisteners();
		}
		
		private function assert(condition:Boolean, message:String):void {
			if (!condition)
				throw new Error(message);
		}
		
		private function initializeUserInterface():void {
			userInterface.teaPot.gotoAndStop(life + 1);
			userInterface.questIcon.visible = false;
			userInterface.itemIcon.visible = false;
			userInterface.pocketWatch.second_hand.rotation = 21
			userInterface.pocketWatch.minute_hand.rotation = 21
			//private var fadeToBlack:MovieClip = fade_to_black as MovieClip;
			//removeChild(fadeToBlack);
		}
		
		private function addlisteners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeyUp);
			player.addEventListener(Event.ENTER_FRAME, playerMove);
			tocker.addEventListener(TimerEvent.TIMER, clock);
		}
		
		private function checkKeyDown(event:KeyboardEvent):void {
			if (event.keyCode == LEFT_ARROW_KEYCODE) {
				leftKeyDown = true;
			}
			if (event.keyCode == 39) {
				rightKeyDown = true;
			}
			if (event.keyCode == 16) {
				attack();
				shiftKeyDown = true;
			}
		}
		
		private function checkKeyUp(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftKeyDown = false;
			}
			if (event.keyCode == 39) {
				rightKeyDown = false;
			}
			if (event.keyCode == 32 && shouldJump()) {
				jump();
			}
			if (event.keyCode == 13) {
				checkForText();
			}
			if (event.keyCode == 16) {
				shiftKeyDown = false;
				can_attack = true;
			}
			
			if (event.keyCode == 77) {
				viewMap();
			}
		}
		
		private function shouldJump():Boolean {
			return grounded && (!attacking) && canJump;
		}
		
		private function jump():void {
			grounded = false;
			jumpSpeed = 35;
			if (tutorial == 3) {
				canAdvanceText = true;
				checkForText();
			}
		}
		
		private function playerMove(event:Event):void {
			moveLeftAndRight();
			fall();
			collideV();
			collectStamps();
			collectTea();
			collideGhosts();
			checkAttackStatus();
			checkMissionDialougeCollision();
			collideMissionObjects();
			if (mission == 1) {
				tocker.start();
			}
		/*
		   if(stage.contains(fadeToBlack)) {
		   if(fadeToBlack.currentFrame==18) {
		   resetGame();
		   removeChild(fadeToBlack);
		   }
		 }*/
		}
		
		private function checkAttackStatus() {
			if (attacking && lastDir == "right" && player.person.currentFrame != 7) {
				player.attackHitBox.x = 0;
				player.person.gotoAndStop("attackR");
				player.person.attackRight.play();
			}
			if (attacking && lastDir == "left" && player.person.currentFrame != 8) {
				player.attackHitBox.x = -200;
				player.person.gotoAndStop("attackL");
				player.person.attackLeft.play();
			}
			if (grounded && attacking) {
				if (player.person.currentFrame == 7 && player.person.attackRight.currentFrame == 12) {
					attacking = false;
					player.person.attackRight.stop();
				}
				if (player.person.currentFrame == 8 && player.person.attackLeft.currentFrame == 12) {
					attacking = false;
					player.person.attackLeft.stop();
				}
			}
		}
		
		private function moveLeftAndRight() {
			if (canMove) {
				if (leftKeyDown && !attacking && !rightKeyDown) {
					if (!collideH()) {
						if (player.person.currentFrame != 4 && grounded) {
							player.person.gotoAndStop("walkL");
						}
						level.x += mainSpeed;
					}
					lastDir = "left";
					if (tutorial == 2) {
						canAdvanceText = true;
						checkForText();
					}
				}
				if (rightKeyDown && !attacking && !leftKeyDown) {
					if (!collideH()) {
						if (player.person.currentFrame != 3 && grounded) {
							player.person.gotoAndStop("walkR");
						}
						level.x -= mainSpeed;
					}
					lastDir = "right";
					if (tutorial == 2) {
						canAdvanceText = true;
						checkForText();
					}
				}
			}
			if (((!leftKeyDown && !rightKeyDown) || (leftKeyDown && rightKeyDown)) && grounded && !attacking) {
				if (lastDir == "right" && player.person.currentFrame != 1) {
					player.person.gotoAndStop("idleR");
				}
				if (lastDir == "left" && player.person.currentFrame != 2) {
					player.person.gotoAndStop("idleL");
				}
			}
		}
		
		private function fall() {
			if (!grounded) {
				if (lastDir == "right" && player.person.currentFrame != 5) {
					player.person.gotoAndStop("jumpR");
				}
				if (lastDir == "left" && player.person.currentFrame != 6) {
					player.person.gotoAndStop("jumpL");
				}
				if (jumpSpeed - gravity < -IMPULSE_SIZE) {
					jumpSpeed = -IMPULSE_SIZE;
				}
				jumpSpeed -= gravity;
				level.y += jumpSpeed;
			}
		}
		
		private function collideV() {
			for (var i:uint = 0; i < level.h_plats.numChildren; i++) {
				if (player.x - PLAYER_RADIUS < level.h_plats.getChildAt(i).x + level.h_plats.x + level.x + 100) {
					if (player.x + PLAYER_RADIUS > level.h_plats.getChildAt(i).x + level.h_plats.x + level.x) {
						if (player.y < level.h_plats.getChildAt(i).y + level.h_plats.y + level.y) {
							if (player.y - jumpSpeed > level.h_plats.getChildAt(i).y + level.h_plats.y + level.y) {
								level.y = player.y - level.h_plats.y - level.h_plats.getChildAt(i).y + 1;
								grounded = true;
								break;
							}
						}
					}
				}
			}
			if (i == level.h_plats.numChildren) {
				collidesArchNemesis();
			}
		}
		
		private function collidesArchNemesis() {
			grounded = false;
			if (lastDir == "right" && player.currentFrame != 5) {
				player.person.gotoAndStop("jumpR");
			}
			if (lastDir == "left" && player.currentFrame != 6) {
				player.person.gotoAndStop("jumpL");
			}
		}
		
		private function collideH():Boolean {
			var returnValue:Boolean;
			for (var i:uint = 0; i < level.edge_plats.numChildren; i++) {
				if (player.y > level.edge_plats.getChildAt(i).y + level.edge_plats.y + level.y) {
					if (player.y - player.height < level.edge_plats.getChildAt(i).y + level.edge_plats.y + level.y + 100) {
						if (leftKeyDown) {
							if (player.x - PLAYER_RADIUS > level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x + 100) {
								if (player.x - PLAYER_RADIUS - mainSpeed < level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x + 100) {
									player.x = level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x + 100 + PLAYER_RADIUS + 1;
									returnValue = true;
									if (player.person.currentFrame != 1) {
										player.person.gotoAndStop("idleL");
									}
									break;
								}
							}
						}
						if (rightKeyDown) {
							if (player.x + PLAYER_RADIUS < level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x) {
								if (player.x + PLAYER_RADIUS + mainSpeed > level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x) {
									player.x = level.edge_plats.getChildAt(i).x + level.edge_plats.x + level.x - PLAYER_RADIUS - 1;
									returnValue = true;
									if (player.person.currentFrame != 2) {
										player.person.gotoAndStop("idleR");
									}
									break;
								}
							}
						}
					}
				}
			}
			if (i == level.edge_plats.numChildren) {
				returnValue = false;
			}
			return returnValue
		}
		
		private function collectStamps() {
			var stamp:MovieClip;
			for (var i:uint = 0; i < level.stamps.numChildren; i++) {
				stamp = level.stamps.getChildAt(i) as MovieClip;
				if (player.hitBox.hitTestObject(stamp)) {
					level.stamps.removeChild(stamp);
					score++;
					userInterface.score_text.text = score.toString();
				}
			}
		}
		
		private function collectTea() {
			if (player.hitBox.hitTestObject(level.teaCup)) {
				level.removeChild(level.teaCup);
				life++
				userInterface.teaPot.gotoAndStop(life + 1);
			}
		}
		
		private function collideGhosts() {
			if (player.invincibility.currentFrame == 1) {
				invincible = false;
			}
			if (!invincible) {
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.ghosts.numChildren; i++) {
					ghost = level.ghosts.getChildAt(i) as MovieClip;
					if (player.hitBox.hitTestObject(ghost)) {
						life--;
						userInterface.teaPot.gotoAndStop(life + 1);
						if (life == 0) {
							textBox.gotoAndStop(16);
							canMove = false
							canJump = false
							canAttack = false
							textBox.visible = true;
						} else {
							invincible = true;
							if (textBox.visible == false) {
								player.invincibility.play();
							}
						}
					}
				}
			}
		}
		
		private function attack() {
			if (!attacking && grounded && can_attack && canAttack) {
				can_attack = false;
				attacking = true;
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.ghosts.numChildren; i++) {
					ghost = level.ghosts.getChildAt(i) as MovieClip;
					if (ghost.hitTestObject(player.attackHitBox)) {
						level.ghosts.removeChild(ghost);
					}
				}
				if (tutorial == 4) {
					canAdvanceText = true;
					checkForText();
				}
			}
		}
		
		private function checkForText() {
			if (textBox.visible == true) {
				switch (textBox.currentFrame) {
					
					case 1:
						textBox.gotoAndStop(2);
						tutorial = 2;
						canMove = true;
						canAdvanceText = false;
						break;
					case 2:
						if (canAdvanceText) {
							textBox.gotoAndStop(3);
							tutorial = 3;
							canAdvanceText = false;
							canJump = true;
							canMove = false;
						}
						break;
					case 3:
						if (canAdvanceText) {
							textBox.gotoAndStop(4);
							tutorial = 4;
							canAdvanceText = false;
							canJump = false;
							canAttack = true;
						}
						break;
					case 4:
						if (canAdvanceText) {
							textBox.gotoAndStop(5);
							tutorial = 5;
							canAttack = false;
						}
						break;
					case 5:
						textBox.gotoAndStop(6);
						tutorial = 6;
						break;
					case 6:
						textBox.gotoAndStop(7);
						tutorial = 7;
						break;
					case 7:
						textBox.gotoAndStop(8);
						tutorial = 8;
						break;
					case 8:
						textBox.gotoAndStop(9);
						tutorial = 9;
						break;
					case 9:
						textBox.gotoAndStop(10);
						tutorial = 10;
						break;
					case 10:
						textBox.gotoAndStop(11);
						tutorial = 11;
						break;
					case 11:
						textBox.gotoAndStop(12)
						textBox.visible = false;
						canJump = true;
						canAttack = true;
						canMove = true;
						tutorial = 13;
						level.officer.gotoAndPlay(7);
						level.missionRunners.play();
						break;
					case 12:
						textBox.visible = false;
						canMove = true;
						canJump = true;
						canAttack = true;
						userInterface.itemIcon.visible = true;
						textBox.gotoAndStop(13);
						userInterface.questIcon.visible = false
						mission = 1
						userInterface.pocketWatch.minute_hand_target.visible = true;
						userInterface.pocketWatch.second_hand_target.visible = true;
						userInterface.pocketWatch.second_hand_target.rotation = 21
						userInterface.pocketWatch.minute_hand_target.rotation = 111
						break;
					case 13:
						level.missionRunners.play();
						textBox.gotoAndStop(14);
						textBox.box.PlayAgain.addEventListener(MouseEvent.CLICK, gameWin);
						break;
					case 14:
						textBox.visible = false
						canMove = true;
						canJump = true;
						canAttack = true;
						break;
					case 15:
						fadeOut();
						break;
					case 16:
						textBox.gotoAndStop(17);
						break;
					case 17:
						fadeOut();
						break;
				}
			}
		}
		
		// fade_to_black didn't word when i resurected the project
		// I will probably re-write the functionality from scratch later
		private function fadeOut() {
		/*
		   addChild(fadeToBlack);
		   fadeToBlack.x=0;
		   fadeToBlack.y=0;
		 fadeToBlack.play();*/
		}
		
		private function gameWin(MouseEvent) {
			resetGame()
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, checkKeyUp);
			player.removeEventListener(Event.ENTER_FRAME, playerMove);
			tocker.removeEventListener(TimerEvent.TIMER, clock);
			restartGameFunction();
		}
		
		private function resetGame() {
			for (j = 5; j > 0; j--) {
				resetLevels(j)
			}
			level.x = 319.6
			level.y = -1355
			textBox.gotoAndStop(12);
			mission = 0
			textBox.visible = false
			canMove = true;
			canJump = true;
			canAttack = true;
			level.officer.gotoAndStop(31)
			userInterface.itemIcon.visible = false
			collectedItem = false
			level.officer.gotoAndPlay(7);
			level.missionRunners.gotoAndPlay(2);
			userInterface.pocketWatch.second_hand.rotation = 21
			userInterface.pocketWatch.minute_hand.rotation = 21
			tocker.stop();
			score = 0;
			userInterface.score_text.text = 0;
			userInterface.pocketWatch.minute_hand_target.visible = false;
			userInterface.pocketWatch.second_hand_target.visible = false;
			life = 6
			userInterface.teaPot.gotoAndStop(life + 1);
			invincible = false;
			player.invincibility.gotoAndStop(1)
		}
		
		private function resetLevels(L:int) {
			level.gotoAndStop(L);
			if (L != 1) {
				resetMissionObjects();
			}
			resetStamps();
			resetGhosts();
			level.teaCup.visible = false;
			curLevel = L
		}
		
		private function resetMissionObjects():void {
			for (var i:uint = 0; i < level.mission_objects.numChildren; i++) {
				level.mission_objects.getChildAt(i).visible = false;
			}
		}
		
		private function resetStamps():void {
			for (var i:uint = 0; i < level.stamps.numChildren; i++) {
				level.stamps.getChildAt(i).visible = true
			}
		}
		
		private function resetGhosts():void {
			for (var i:uint = 0; i < level.ghosts.numChildren; i++) {
				level.ghosts.getChildAt(i).visible = true
			}
		}
		
		private function questAlert() {
			userInterface.questIcon.visible = true;
			missionSoundsChannel = questSound.play();
		}
		
		private function checkMissionDialougeCollision() {
			if (curLevel == 1) {
				if (level.missionRunners.currentFrame == mission * 180 + 102) {
					if (userInterface.questIcon.visible == false) {
						questAlert()
					}
				}
				if (player.hitBox.hitTestObject(level.lostAndFound.hitBox)) {
					if (!collectedItem) {
						if (level.missionRunners.currentFrame == mission * 180 + 102) {
							if (userInterface.questIcon.visible == false) {
								questAlert()
							}
							switchToText()
						}
					} else {
						if (textBox.currentFrame == 13) {
							switchToText()
							if (level.missionRunners.currentFrame != 105) {
								missionSoundsChannel = completeSound.play();
							}
							level.missionRunners.gotoAndStop(105)
						}
					}
				}
			}
		}
		
		private function switchToText() {
			if (lastDir == "right") {
				player.person.gotoAndStop("idleR");
			}
			if (lastDir == "left") {
				player.person.gotoAndStop("idleL");
			}
			textBox.visible = true;
			canMove = false;
			canJump = false;
			canAttack = false;
			canAdvanceText = true;
		}
		
		private function viewMap() {
			if (level.currentFrame < 17) {
				player.removeEventListener(Event.ENTER_FRAME, playerMove);
				level.gotoAndStop(18);
				savedX = level.x
				savedY = level.y
				level.x = 0
				level.y = 0
				userInterface.visible = false;
				player.visible = false;
				level.map1.train_station_btn.addEventListener(MouseEvent.CLICK, gotoTrainStation);
				level.map1.north_wing_btn.addEventListener(MouseEvent.CLICK, gotoNorthWing);
				level.map1.east_wing_btn.addEventListener(MouseEvent.CLICK, gotoEastWing);
				level.map1.south_wing_btn.addEventListener(MouseEvent.CLICK, gotoSouthWing);
				level.map1.west_wing_btn.addEventListener(MouseEvent.CLICK, gotoWestWing);
			} else {
				goToLevel(curLevel)
			}
		}
		
		private function gotoTrainStation(event:MouseEvent) {
			goToLevel(1)
		}
		
		private function gotoNorthWing(event:MouseEvent) {
			goToLevel(2)
		}
		
		private function gotoEastWing(event:MouseEvent) {
			goToLevel(3)
		}
		
		private function gotoSouthWing(event:MouseEvent) {
			goToLevel(4)
		}
		
		private function gotoWestWing(event:MouseEvent) {
			goToLevel(5)
		}
		
		private function goToLevel(L:int) {
			level.gotoAndStop(L);
			player.addEventListener(Event.ENTER_FRAME, playerMove);
			if (curLevel != L) {
				curLevel = L
				level.x = 319.6
				level.y = -1358
			} else {
				level.x = savedX
				level.y = savedY
			}
			if (curLevel != 1) {
				for (var i:uint = 0; i < level.mission_objects.numChildren; i++) {
					level.mission_objects.getChildAt(i).visible = false;
				}
				if (curLevel == 5) {
					level.mission_objects.object_1.visible = true;
				}
			} else {
				if (tutorial == 13) {
					level.officer.gotoAndStop(31);
				}
				if (mission == 1) {
					level.missionRunners.gotoAndStop(104);
				}
			}
			userInterface.visible = true
			player.visible = true
		}
		
		private function collideMissionObjects() {
			if (curLevel == 5 && level.mission_objects.object_1.visible) {
				if (player.hitBox.hitTestObject(level.mission_objects.object_1)) {
					collectMissionObject();
				}
			}
		}
		
		private function collectMissionObject():void {
			level.mission_objects.object_1.visible = false;
			userInterface.itemIcon.visible = false;
			collectedItem = true;
		}
		
		private function clock(TimerEvent) {
			if (userInterface.pocketWatch.second_hand.rotation == 21 && userInterface.pocketWatch.minute_hand.rotation == 111) {
				if (textBox.currentFrame < 14) {
					textBox.visible = true
					canMove = false
					canJump = false
					canAttack = false
					userInterface.itemIcon.visible = false
					textBox.gotoAndStop(15);
					userInterface.questIcon.visible = false
				}
			}
			if (textBox.visible == false) {
				userInterface.pocketWatch.second_hand.rotation += 6; //Second hand
				userInterface.pocketWatch.minute_hand.rotation += 0.5; //Minute hand
			}
		}
	}
}