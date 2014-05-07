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
		private const IMPULSE_SIZE:Number = 20;
		private const PLAYER_RADIUS:int = 45;
		private const ATTACK_RADIUS:int = 175;
		
		private var UI:MovieClip;
		private var Player:MovieClip;
		private var Level:MovieClip;
		private var textBox:MovieClip;
		private var restartGameFunction:Function; // cannot use stage.gotoAndPlay(1) for some reason, so pass in a function from the timeline that does that
		
		private var leftKeyDown:Boolean = false;
		private var rightKeyDown:Boolean = false;
		private var spaceKeyDown:Boolean = false;
		private var shiftKeyDown:Boolean = false;
		private var mainSpeed:Number = 15;
		private var i:int;
		private var j:int;
		private var grounded:Boolean = false;
		private var jumpSpeed:Number = 0;
		private var gravity:Number = 1.5;
		private var lastDir:String = "right";
		private var score:int = 0;
		private var life:int = 6;
		private var invincible:Boolean = false;
		private var attacking:Boolean = false;
		private var mission:int = 0
		private var tutorial:int = 1;
		private var can_attack:Boolean = true;
		private var canAdvanceText:Boolean = true;
		private var canMove:Boolean = false;
		private var canJump:Boolean = false;
		private var canAttack:Boolean = false;
		private var missionSoundsChannel:SoundChannel = new SoundChannel();
		private var questSound:Sound = new Bell_alert();
		private var completeSound:Sound = new Mission_complete();
		private var curLevel:int = 1;
		private var collectedItem:Boolean = false;
		private var savedX:Number;
		private var savedY:Number;
		private var tocker:Timer = new Timer(1000);
		
		public function Main(ui:MovieClip, player:MovieClip, level:MovieClip, textDisplay:MovieClip, restartGameFunction:Function) {
			this.Player = player;
			this.UI = ui;
			this.Level = level;
			this.textBox = textDisplay;
			this.restartGameFunction = restartGameFunction;
			super();
		}
		
		public function startGame():void {
			assert(stage != null, "Main needs to be added to the stage before calling startGame on it")
			UI.teaPot.gotoAndStop(life + 1);
			UI.questIcon.visible = false;
			UI.itemIcon.visible = false;
			UI.pocketWatch.second_hand.rotation = 21
			UI.pocketWatch.minute_hand.rotation = 21
			//private var fadeToBlack:MovieClip = fade_to_black as MovieClip;
			//removeChild(fadeToBlack);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeyUp);
			Player.addEventListener(Event.ENTER_FRAME, playerMove);
			tocker.addEventListener(TimerEvent.TIMER, clock);
		}
		
		private function assert(condition:Boolean, message:String):void {
			if (!condition)
				throw new Error(message);
		}
		
		private function checkKeyDown(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
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
			if (event.keyCode == 32) {
				if (grounded && !attacking && canJump) {
					grounded = false;
					jumpSpeed = 35;
					if (tutorial == 3) {
						canAdvanceText = true;
						checkForText();
					}
				}
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
			if (attacking && lastDir == "right" && Player.person.currentFrame != 7) {
				Player.attackHitBox.x = 0;
				Player.person.gotoAndStop("attackR");
				Player.person.attackRight.play();
			}
			if (attacking && lastDir == "left" && Player.person.currentFrame != 8) {
				Player.attackHitBox.x = -200;
				Player.person.gotoAndStop("attackL");
				Player.person.attackLeft.play();
			}
			if (grounded && attacking) {
				if (Player.person.currentFrame == 7 && Player.person.attackRight.currentFrame == 12) {
					attacking = false;
					Player.person.attackRight.stop();
				}
				if (Player.person.currentFrame == 8 && Player.person.attackLeft.currentFrame == 12) {
					attacking = false;
					Player.person.attackLeft.stop();
				}
			}
		}
		
		private function moveLeftAndRight() {
			if (canMove) {
				if (leftKeyDown && !attacking && !rightKeyDown) {
					if (!collideH()) {
						if (Player.person.currentFrame != 4 && grounded) {
							Player.person.gotoAndStop("walkL");
						}
						Level.x += mainSpeed;
					}
					lastDir = "left";
					if (tutorial == 2) {
						canAdvanceText = true;
						checkForText();
					}
				}
				if (rightKeyDown && !attacking && !leftKeyDown) {
					if (!collideH()) {
						if (Player.person.currentFrame != 3 && grounded) {
							Player.person.gotoAndStop("walkR");
						}
						Level.x -= mainSpeed;
					}
					lastDir = "right";
					if (tutorial == 2) {
						canAdvanceText = true;
						checkForText();
					}
				}
			}
			if (((!leftKeyDown && !rightKeyDown) || (leftKeyDown && rightKeyDown)) && grounded && !attacking) {
				if (lastDir == "right" && Player.person.currentFrame != 1) {
					Player.person.gotoAndStop("idleR");
				}
				if (lastDir == "left" && Player.person.currentFrame != 2) {
					Player.person.gotoAndStop("idleL");
				}
			}
		}
		
		private function fall() {
			if (!grounded) {
				if (lastDir == "right" && Player.person.currentFrame != 5) {
					Player.person.gotoAndStop("jumpR");
				}
				if (lastDir == "left" && Player.person.currentFrame != 6) {
					Player.person.gotoAndStop("jumpL");
				}
				if (jumpSpeed - gravity < -IMPULSE_SIZE) {
					jumpSpeed = -IMPULSE_SIZE;
				}
				jumpSpeed -= gravity;
				Level.y += jumpSpeed;
			}
		}
		
		private function collideV() {
			for (i = 0; i < Level.h_plats.numChildren; i++) {
				if (Player.x - PLAYER_RADIUS < Level.h_plats.getChildAt(i).x + Level.h_plats.x + Level.x + 100) {
					if (Player.x + PLAYER_RADIUS > Level.h_plats.getChildAt(i).x + Level.h_plats.x + Level.x) {
						if (Player.y < Level.h_plats.getChildAt(i).y + Level.h_plats.y + Level.y) {
							if (Player.y - jumpSpeed > Level.h_plats.getChildAt(i).y + Level.h_plats.y + Level.y) {
								Level.y = Player.y - Level.h_plats.y - Level.h_plats.getChildAt(i).y + 1;
								grounded = true;
								break;
							}
						}
					}
				}
			}
			if (i == Level.h_plats.numChildren) {
				collidesArchNemesis();
			}
		}
		
		private function collidesArchNemesis() {
			grounded = false;
			if (lastDir == "right" && Player.currentFrame != 5) {
				Player.person.gotoAndStop("jumpR");
			}
			if (lastDir == "left" && Player.currentFrame != 6) {
				Player.person.gotoAndStop("jumpL");
			}
		}
		
		private function collideH():Boolean {
			var returnValue:Boolean;
			for (i = 0; i < Level.edge_plats.numChildren; i++) {
				if (Player.y > Level.edge_plats.getChildAt(i).y + Level.edge_plats.y + Level.y) {
					if (Player.y - Player.height < Level.edge_plats.getChildAt(i).y + Level.edge_plats.y + Level.y + 100) {
						if (leftKeyDown) {
							if (Player.x - PLAYER_RADIUS > Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x + 100) {
								if (Player.x - PLAYER_RADIUS - mainSpeed < Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x + 100) {
									Player.x = Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x + 100 + PLAYER_RADIUS + 1;
									returnValue = true;
									if (Player.person.currentFrame != 1) {
										Player.person.gotoAndStop("idleL");
									}
									break;
								}
							}
						}
						if (rightKeyDown) {
							if (Player.x + PLAYER_RADIUS < Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x) {
								if (Player.x + PLAYER_RADIUS + mainSpeed > Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x) {
									Player.x = Level.edge_plats.getChildAt(i).x + Level.edge_plats.x + Level.x - PLAYER_RADIUS - 1;
									returnValue = true;
									if (Player.person.currentFrame != 2) {
										Player.person.gotoAndStop("idleR");
									}
									break;
								}
							}
						}
					}
				}
			}
			if (i == Level.edge_plats.numChildren) {
				returnValue = false;
			}
			return returnValue
		}
		
		private function collectStamps() {
			var stamp:MovieClip;
			for (i = 0; i < Level.stamps.numChildren; i++) {
				stamp = Level.stamps.getChildAt(i) as MovieClip;
				if (Player.hitBox.hitTestObject(stamp)) {
					Level.stamps.removeChild(stamp);
					score++;
					UI.score_text.text = score.toString();
				}
			}
		}
		
		private function collectTea() {
			if (Player.hitBox.hitTestObject(Level.teaCup)) {
				Level.removeChild(Level.teaCup);
				life++
				UI.teaPot.gotoAndStop(life + 1);
			}
		}
		
		private function collideGhosts() {
			if (Player.invincibility.currentFrame == 1) {
				invincible = false;
			}
			if (!invincible) {
				var ghost:MovieClip;
				for (i = 0; i < Level.ghosts.numChildren; i++) {
					ghost = Level.ghosts.getChildAt(i) as MovieClip;
					if (Player.hitBox.hitTestObject(ghost)) {
						life--;
						UI.teaPot.gotoAndStop(life + 1);
						if (life == 0) {
							textBox.gotoAndStop(16);
							canMove = false
							canJump = false
							canAttack = false
							textBox.visible = true;
						} else {
							invincible = true;
							if (textBox.visible == false) {
								Player.invincibility.play();
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
				for (i = 0; i < Level.ghosts.numChildren; i++) {
					ghost = Level.ghosts.getChildAt(i) as MovieClip;
					if (ghost.hitTestObject(Player.attackHitBox)) {
						Level.ghosts.removeChild(ghost);
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
						Level.officer.gotoAndPlay(7);
						Level.missionRunners.play();
						break;
					case 12:
						textBox.visible = false;
						canMove = true;
						canJump = true;
						canAttack = true;
						UI.itemIcon.visible = true;
						textBox.gotoAndStop(13);
						UI.questIcon.visible = false
						mission = 1
						UI.pocketWatch.minute_hand_target.visible = true;
						UI.pocketWatch.second_hand_target.visible = true;
						UI.pocketWatch.second_hand_target.rotation = 21
						UI.pocketWatch.minute_hand_target.rotation = 111
						break;
					case 13:
						Level.missionRunners.play();
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
			Player.removeEventListener(Event.ENTER_FRAME, playerMove);
			tocker.removeEventListener(TimerEvent.TIMER, clock);
			//container.gotoAndPlay(1);
			restartGameFunction();
		}
		
		private function resetGame() {
			for (j = 5; j > 0; j--) {
				resetLevels(j)
			}
			Level.x = 319.6
			Level.y = -1355
			textBox.gotoAndStop(12);
			mission = 0
			textBox.visible = false
			canMove = true;
			canJump = true;
			canAttack = true;
			Level.officer.gotoAndStop(31)
			UI.itemIcon.visible = false
			collectedItem = false
			Level.officer.gotoAndPlay(7);
			Level.missionRunners.gotoAndPlay(2);
			UI.pocketWatch.second_hand.rotation = 21
			UI.pocketWatch.minute_hand.rotation = 21
			tocker.stop();
			score = 0;
			UI.score_text.text = 0;
			UI.pocketWatch.minute_hand_target.visible = false;
			UI.pocketWatch.second_hand_target.visible = false;
			life = 6
			UI.teaPot.gotoAndStop(life + 1);
			invincible = false;
			Player.invincibility.gotoAndStop(1)
		}
		
		private function resetLevels(L:int) {
			Level.gotoAndStop(L);
			if (L != 1) {
				for (i = 0; i < Level.mission_objects.numChildren; i++) {
					Level.mission_objects.getChildAt(i).visible = false;
				}
			}
			for (i = 0; i < Level.stamps.numChildren; i++) {
				Level.stamps.getChildAt(i).visible = true
			}
			for (i = 0; i < Level.ghosts.numChildren; i++) {
				Level.ghosts.getChildAt(i).visible = true
			}
			Level.teaCup.visible = false;
			curLevel = L
		}
		
		private function questAlert() {
			UI.questIcon.visible = true;
			missionSoundsChannel = questSound.play();
		}
		
		private function checkMissionDialougeCollision() {
			if (curLevel == 1) {
				if (Level.missionRunners.currentFrame == mission * 180 + 102) {
					if (UI.questIcon.visible == false) {
						questAlert()
					}
				}
				if (Player.hitBox.hitTestObject(Level.lostAndFound.hitBox)) {
					if (!collectedItem) {
						if (Level.missionRunners.currentFrame == mission * 180 + 102) {
							if (UI.questIcon.visible == false) {
								questAlert()
							}
							switchToText()
						}
					} else {
						if (textBox.currentFrame == 13) {
							switchToText()
							if (Level.missionRunners.currentFrame != 105) {
								missionSoundsChannel = completeSound.play();
							}
							Level.missionRunners.gotoAndStop(105)
						}
					}
				}
			}
		}
		
		private function switchToText() {
			if (lastDir == "right") {
				Player.person.gotoAndStop("idleR");
			}
			if (lastDir == "left") {
				Player.person.gotoAndStop("idleL");
			}
			textBox.visible = true;
			canMove = false;
			canJump = false;
			canAttack = false;
			canAdvanceText = true;
		}
		
		private function viewMap() {
			if (Level.currentFrame < 17) {
				Player.removeEventListener(Event.ENTER_FRAME, playerMove);
				Level.gotoAndStop(18);
				savedX = Level.x
				savedY = Level.y
				Level.x = 0
				Level.y = 0
				UI.visible = false;
				Player.visible = false;
				Level.map1.train_station_btn.addEventListener(MouseEvent.CLICK, gotoTrainStation);
				Level.map1.north_wing_btn.addEventListener(MouseEvent.CLICK, gotoNorthWing);
				Level.map1.east_wing_btn.addEventListener(MouseEvent.CLICK, gotoEastWing);
				Level.map1.south_wing_btn.addEventListener(MouseEvent.CLICK, gotoSouthWing);
				Level.map1.west_wing_btn.addEventListener(MouseEvent.CLICK, gotoWestWing);
			} else {
				gotoThisLevel(curLevel)
			}
		}
		
		private function gotoTrainStation(MouseEvent) {
			gotoThisLevel(1)
		}
		
		private function gotoNorthWing(MouseEvent) {
			gotoThisLevel(2)
		}
		
		private function gotoEastWing(MouseEvent) {
			gotoThisLevel(3)
		}
		
		private function gotoSouthWing(MouseEvent) {
			gotoThisLevel(4)
		}
		
		private function gotoWestWing(MouseEvent) {
			gotoThisLevel(5)
		}
		
		private function gotoThisLevel(L:int) {
			Level.gotoAndStop(L);
			Player.addEventListener(Event.ENTER_FRAME, playerMove);
			if (curLevel != L) {
				curLevel = L
				Level.x = 319.6
				Level.y = -1358
			} else {
				Level.x = savedX
				Level.y = savedY
			}
			if (curLevel != 1) {
				for (i = 0; i < Level.mission_objects.numChildren; i++) {
					Level.mission_objects.getChildAt(i).visible = false;
				}
				if (curLevel == 5) {
					Level.mission_objects.object_1.visible = true;
				}
			} else {
				if (tutorial == 13) {
					Level.officer.gotoAndStop(31);
				}
				if (mission == 1) {
					Level.missionRunners.gotoAndStop(104);
				}
			}
			UI.visible = true
			Player.visible = true
		}
		
		private function collideMissionObjects() {
			if (curLevel != 1) {
				if (curLevel == 5) {
					if (Level.mission_objects.object_1.visible) {
						if (Player.hitBox.hitTestObject(Level.mission_objects.object_1)) {
							Level.mission_objects.object_1.visible = false;
							UI.itemIcon.visible = false;
							collectedItem = true;
						}
					}
				}
			}
		}
		
		private function clock(TimerEvent) {
			if (UI.pocketWatch.second_hand.rotation == 21 && UI.pocketWatch.minute_hand.rotation == 111) {
				if (textBox.currentFrame < 14) {
					textBox.visible = true
					canMove = false
					canJump = false
					canAttack = false
					UI.itemIcon.visible = false
					textBox.gotoAndStop(15);
					UI.questIcon.visible = false
				}
			}
			if (textBox.visible == false) {
				UI.pocketWatch.second_hand.rotation += 6; //Second hand
				UI.pocketWatch.minute_hand.rotation += 0.5; //Minute hand
			}
		}
	}
}