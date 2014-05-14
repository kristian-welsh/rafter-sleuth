package {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import keyboard.*;
	
	// BUG: if you use the map before themission giver gets to the stand, the mission giver never shows up
	// BUG: you need to click the screen again after using the map to be able to control your character again
	// BUG: if you use the map in mid-air you fall out of the level
	public class Main extends Sprite implements KeyboardResponder {
		static private const IMPULSE_SIZE:Number = 20;
		static private const PLAYER_RADIUS:int = 45;
		static private const ATTACK_RADIUS:int = 175;
		
		private var userInterface:MovieClip;
		private var player:MovieClip;
		private var level:MovieClip;
		private var restartGameFunction:Function;
		// cannot use stage.gotoAndPlay(1) for some reason, so pass in a function from the timeline that does that
		private var textBox:TextBox;
		private var keys:KeyboardControls;
		
		private var lastDir:String = "right";
		private var savedX:Number;
		private var savedY:Number;
		private var grounded:Boolean = false;
		private var invincible:Boolean = false;
		private var attacking:Boolean = false;
		
		// combine variable and KeyboardControls::can_attack
		private var canAttack:Boolean = false;
		
		private var canMove:Boolean = false;
		private var canJump:Boolean = false;
		private var canAdvanceText:Boolean = true;
		private var collectedItem:Boolean = false;
		private var mainSpeed:Number = 15;
		private var jumpSpeed:Number = 0;
		private var gravity:Number = 1.5;
		private var j:int;
		private var score:int = 0;
		private var life:int = 6;
		private var currentMission:int = 0
		private var tutorialProgress:int = 1;
		private var currentLevel:int = 1;
		private var missionSoundsChannel:SoundChannel = new SoundChannel();
		private var questSound:Sound = new Bell_alert();
		private var completeSound:Sound = new Mission_complete();
		private var tocker:Timer = new Timer(1000);
		
		public function Main(ui:MovieClip, player:MovieClip, level:MovieClip, textDisplay:MovieClip, restartGameFunction:Function):void {
			this.player = player;
			this.userInterface = ui;
			this.level = level;
			this.restartGameFunction = restartGameFunction;
			textBox = new TextBox(textDisplay);
			keys = new KeyboardControls(this);
			super();
		}
		
		public function startGame():void {
			assert(stage != null, "Main needs to be added to the stage before calling startGame on it")
			initializeUserInterface();
			addlisteners();
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
			keys.startListening(stage);
			player.addEventListener(Event.ENTER_FRAME, playerMove);
			tocker.addEventListener(TimerEvent.TIMER, clock);
		}
		
		private function shouldJump():Boolean {
			return grounded && (!attacking) && canJump;
		}
		
		public function jump():void {
			if (shouldJump()) {
				grounded = false;
				jumpSpeed = 35;
				if (tutorialProgress == 3) {
					canAdvanceText = true;
					checkForText();
				}
			}
		}
		
		private function playerMove(event:Event):void {
			moveLeftAndRight();
			fall();
			collideV();
			collideStamps();
			collideTea();
			collideGhosts();
			checkAttackStatus();
			checkMissionDialougeCollision();
			collideMissionObjects();
			if (currentMission == 1) {
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
		
		private function checkAttackStatus():void {
			if (!attacking)
				return;
			if (playerIsFacing("right") && player.person.currentFrame != 7) {
				player.attackHitBox.x = 0;
				player.person.gotoAndStop("attackR");
				player.person.attackRight.play();
			}
			if (playerIsFacing("left") && player.person.currentFrame != 8) {
				player.attackHitBox.x = -200;
				player.person.gotoAndStop("attackL");
				player.person.attackLeft.play();
			}
			if (grounded) {
				if (playerHasFinishedAttackingRight()) {
					attacking = false;
					player.person.attackRight.stop();
				}
				if (playerHasFinishedAttackingLeft()) {
					attacking = false;
					player.person.attackLeft.stop();
				}
			}
		}
		
		private function playerIsFacing(direction:String):Boolean {
			return lastDir == direction;
		}
		
		private function playerHasFinishedAttackingRight():Boolean {
			return player.person.currentFrame == 7 && player.person.attackRight.currentFrame == 12;
		}
		
		private function playerHasFinishedAttackingLeft():Boolean {
			return player.person.currentFrame == 8 && player.person.attackLeft.currentFrame == 12;
		}
		
		private function moveLeftAndRight():void {
			if (attacking)
				return;
			if (canMove) {
				if (keys.leftKeyDown && !keys.rightKeyDown) {
					if (!collideH()) {
						if (player.person.currentFrame != 4 && grounded) {
							player.person.gotoAndStop("walkL");
						}
						level.x += mainSpeed;
					}
					lastDir = "left";
				}
				if (keys.rightKeyDown && !keys.leftKeyDown) {
					if (!collideH()) {
						if (player.person.currentFrame != 3 && grounded) {
							player.person.gotoAndStop("walkR");
						}
						level.x -= mainSpeed;
					}
					lastDir = "right";
				}
				if ((keys.leftKeyDown || keys.rightKeyDown) && tutorialProgress == 2) {
					canAdvanceText = true;
					checkForText();
				}
			}
			if (playerShouldBeIdle()) {
				if (playerIsFacing("right") && player.person.currentFrame != 1) {
					player.person.gotoAndStop("idleR");
				}
				if (playerIsFacing("left") && player.person.currentFrame != 2) {
					player.person.gotoAndStop("idleL");
				}
			}
		}
		
		private function playerShouldBeIdle():Boolean {
			return ((!keys.leftKeyDown && !keys.rightKeyDown) || (keys.leftKeyDown && keys.rightKeyDown)) && grounded
		}
		
		private function fall():void {
			if (grounded)
				return;
			if (playerIsFacing("right") && player.person.currentFrame != 5) {
				player.person.gotoAndStop("jumpR");
			}
			if (playerIsFacing("left") && player.person.currentFrame != 6) {
				player.person.gotoAndStop("jumpL");
			}
			if (jumpSpeed - gravity < -IMPULSE_SIZE) {
				jumpSpeed = -IMPULSE_SIZE;
			}
			jumpSpeed -= gravity;
			level.y += jumpSpeed;
		}
		
		private function collideV():void {
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
				keepFalling();
			}
		}
		
		private function keepFalling():void {
			grounded = false;
			if (playerIsFacing("right") && player.currentFrame != 5) {
				player.person.gotoAndStop("jumpR");
			}
			if (playerIsFacing("left") && player.currentFrame != 6) {
				player.person.gotoAndStop("jumpL");
			}
		}
		
		private function collideH():Boolean {
			var returnValue:Boolean;
			for (var i:uint = 0; i < level.edge_plats.numChildren; i++) {
				if (player.y > level.edge_plats.getChildAt(i).y + level.edge_plats.y + level.y) {
					if (player.y - player.height < level.edge_plats.getChildAt(i).y + level.edge_plats.y + level.y + 100) {
						if (keys.leftKeyDown) {
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
						if (keys.rightKeyDown) {
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
		
		private function collideStamps():void {
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
		
		private function collideTea():void {
			if (player.hitBox.hitTestObject(level.teaCup)) {
				level.removeChild(level.teaCup);
				life++
				userInterface.teaPot.gotoAndStop(life + 1);
			}
		}
		
		private function collideGhosts():void {
			if (player.invincibility.currentFrame == 1) {
				invincible = false;
			}
			if (!invincible) {
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.ghosts.numChildren; i++) {
					ghost = level.ghosts.getChildAt(i) as MovieClip;
					if (player.hitBox.hitTestObject(ghost)) {
						hurtPlayer();
					}
				}
			}
		}
		
		private function hurtPlayer():void {
			life--;
			userInterface.teaPot.gotoAndStop(life + 1);
			if (life == 0) {
				killPlayer();
			} else {
				invincible = true;
				if (!textBox.visible) {
					player.invincibility.play();
				}
			}
		}
		
		private function killPlayer():void {
			freezePlayer();
			textBox.displayTextPane(16);
			textBox.show();
		}
		
		private function freezePlayer():void {
			canMove = false;
			canJump = false;
			canAttack = false;
		}
		
		public function attack():void {
			if (!attacking && grounded && keys.canAttack && canAttack) {
				keys.canAttack = false;
				attacking = true;
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.ghosts.numChildren; i++) {
					ghost = level.ghosts.getChildAt(i) as MovieClip;
					if (ghost.hitTestObject(player.attackHitBox)) {
						level.ghosts.removeChild(ghost);
					}
				}
				if (tutorialProgress == 4) {
					canAdvanceText = true;
					checkForText();
				}
			}
		}
		
		public function checkForText():void {
			if (!textBox.visible)
				return;
			switch (textBox.currentTextPane) {
				case 1:
					textBox.displayTextPane(2);
					tutorialProgress = 2;
					canMove = true;
					canAdvanceText = false;
					break;
				case 2:
					if (canAdvanceText) {
						textBox.displayTextPane(3);
						tutorialProgress = 3;
						canAdvanceText = false;
						canJump = true;
						canMove = false;
					}
					break;
				case 3:
					if (canAdvanceText) {
						textBox.displayTextPane(4);
						tutorialProgress = 4;
						canAdvanceText = false;
						canJump = false;
						canAttack = true;
					}
					break;
				case 4:
					if (canAdvanceText) {
						textBox.displayTextPane(5);
						tutorialProgress = 5;
						canAttack = false;
					}
					break;
				case 5:
					textBox.displayTextPane(6);
					tutorialProgress = 6;
					break;
				case 6:
					textBox.displayTextPane(7);
					tutorialProgress = 7;
					break;
				case 7:
					textBox.displayTextPane(8);
					tutorialProgress = 8;
					break;
				case 8:
					textBox.displayTextPane(9);
					tutorialProgress = 9;
					break;
				case 9:
					textBox.displayTextPane(10);
					tutorialProgress = 10;
					break;
				case 10:
					textBox.displayTextPane(11);
					tutorialProgress = 11;
					break;
				case 11:
					textBox.displayTextPane(12)
					textBox.hide();
					canJump = true;
					canAttack = true;
					canMove = true;
					tutorialProgress = 13;
					level.officer.gotoAndPlay(7);
					level.missionRunners.play();
					break;
				case 12:
					textBox.hide();
					canMove = true;
					canJump = true;
					canAttack = true;
					userInterface.itemIcon.visible = true;
					textBox.displayTextPane(13);
					userInterface.questIcon.visible = false
					currentMission = 1
					userInterface.pocketWatch.minute_hand_target.visible = true;
					userInterface.pocketWatch.second_hand_target.visible = true;
					userInterface.pocketWatch.second_hand_target.rotation = 21
					userInterface.pocketWatch.minute_hand_target.rotation = 111
					break;
				case 13:
					level.missionRunners.play();
					textBox.displayTextPane(14);
					textBox.box.PlayAgain.addEventListener(MouseEvent.CLICK, gameWin);
					break;
				case 14:
					textBox.hide()
					canMove = true;
					canJump = true;
					canAttack = true;
					break;
				case 15:
					fadeOut();
					break;
				case 16:
					textBox.displayTextPane(17);
					break;
				case 17:
					fadeOut();
					break;
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
			resetGame();
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
			textBox.displayTextPane(12);
			currentMission = 0
			textBox.hide()
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
			currentLevel = L
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
			if (currentLevel == 1) {
				if (level.missionRunners.currentFrame == currentMission * 180 + 102) {
					if (userInterface.questIcon.visible == false) {
						questAlert()
					}
				}
				if (player.hitBox.hitTestObject(level.lostAndFound.hitBox)) {
					if (!collectedItem) {
						if (level.missionRunners.currentFrame == currentMission * 180 + 102) {
							if (userInterface.questIcon.visible == false) {
								questAlert()
							}
							switchToText()
						}
					} else {
						if (textBox.currentTextPane == 13) {
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
			if (playerIsFacing("right")) {
				player.person.gotoAndStop("idleR");
			}
			if (playerIsFacing("left")) {
				player.person.gotoAndStop("idleL");
			}
			textBox.show();
			freezePlayer();
			canAdvanceText = true;
		}
		
		public function viewMap():void {
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
				goToLevel(currentLevel)
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
		
		private function goToLevel(levelNumber:int) {
			level.gotoAndStop(levelNumber);
			player.addEventListener(Event.ENTER_FRAME, playerMove);
			if (currentLevel != levelNumber) {
				currentLevel = levelNumber
				level.x = 319.6
				level.y = -1358
			} else {
				level.x = savedX
				level.y = savedY
			}
			if (currentLevel != 1) {
				for (var i:uint = 0; i < level.mission_objects.numChildren; i++) {
					level.mission_objects.getChildAt(i).visible = false;
				}
				if (currentLevel == 5) {
					level.mission_objects.object_1.visible = true;
				}
			} else {
				if (tutorialProgress == 13) {
					level.officer.gotoAndStop(31);
				}
				if (currentMission == 1) {
					level.missionRunners.gotoAndStop(104);
				}
			}
			userInterface.visible = true
			player.visible = true
		}
		
		private function collideMissionObjects():void {
			if (currentLevel == 5 && level.mission_objects.object_1.visible) {
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
		
		private function clock(event:TimerEvent):void {
			if (userInterface.pocketWatch.second_hand.rotation == 21 && userInterface.pocketWatch.minute_hand.rotation == 111) {
				if (textBox.currentTextPane < 14) {
					textBox.show();
					freezePlayer();
					userInterface.itemIcon.visible = false;
					textBox.displayTextPane(15);
					userInterface.questIcon.visible = false;
				}
			}
			if (textBox.visible == false) {
				userInterface.pocketWatch.second_hand.rotation += 6; //Second hand
				userInterface.pocketWatch.minute_hand.rotation += 0.5; //Minute hand
			}
		}
	}
}