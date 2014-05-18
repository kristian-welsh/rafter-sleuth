package {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.utils.*;
	import keyboard.*;
	import ui.*;
	
	// BUG: if you use the map before the mission giver gets to the stand, the mission giver never shows up
	// BUG: you need to click the screen again after using the map to be able to control your character again
	// BUG: if you use the map in mid-air you fall out of the level
	public class Main extends Sprite implements KeyboardResponder {
		static private const IMPULSE_SIZE:Number = 20;
		static private const ATTACK_RADIUS:int = 175;
		
		// cannot use stage.gotoAndPlay(1), so pass in a function from the timeline that does that
		private var restartGameFunction:Function;
		
		private var textBox:TextBox;
		private var keys:KeyboardControls;
		private var player:PlayerManager;
		private var level:LevelManager;
		private var userInterface:UserInterfaceManager;
		private var collider:Collider;
		private var soundManager:SoundManager;
		private var clockManager:ClockManager
		
		private var canAdvanceText:Boolean = true;
		private var collectedItem:Boolean = false;
		private var currentMission:int = 0;
		private var tutorialProgress:int = 1;
		
		public function Main(userInterfaceGraphics:MovieClip, playerView:MovieClip, levelView:MovieClip, textDisplay:MovieClip, restartGameFunction:Function):void {
			this.restartGameFunction = restartGameFunction;
			textBox = new TextBox(textDisplay);
			keys = new KeyboardControls(this);
			soundManager = new SoundManager();
			userInterface = new UserInterfaceManager(new UserInterfaceView(userInterfaceGraphics));
			player = new PlayerManager(playerView);
			level = new LevelManager(levelView);
			collider = new Collider(player, level);
			clockManager = new ClockManager(userInterface, textBox, player);
			super();
		}
		
		public function startGame():void {
			assert(stage != null, "Main needs to be added to the stage before calling startGame on it")
			Console.createInstance(stage);
			userInterface.initialize();
			addlisteners();
		}
		
		private function addlisteners():void {
			keys.startListening(stage);
			player.view.addEventListener(Event.ENTER_FRAME, playerMove);
		}
		
		public function jump():void {
			if (!player.shouldJump())
				return;
			player.jump();
			if (tutorialProgress == 3) {
				canAdvanceText = true;
				checkForText();
			}
		}
		
		private function playerMove(event:Event):void {
			moveLeftAndRight();
			fall();
			collider.collideV()
			collideStamps();
			collideTea();
			collideGhosts();
			player.checkAttackStatus();
			checkMissionDialougeCollision();
			collideMissionObjects();
			if (currentMission == 1) {
				clockManager.start();
			}
		}
		
		private function moveLeftAndRight():void {
			if (player.attacking)
				return;
			if (player.canMove) {
				if (keys.leftKeyDown && !keys.rightKeyDown) {
					if (!collider.collideH()) {
						if (player.grounded)
							player.displayWalkLeft();
						level.view.x += player.walkSpeed;
					}
					player.setLastDireciton("left");
				}
				if (!keys.leftKeyDown && keys.rightKeyDown) {
					if (!collider.collideH()) {
						if (player.grounded)
							player.displayWalkRight();
						level.view.x -= player.walkSpeed;
					}
					player.setLastDireciton("right");
				}
				if ((keys.leftKeyDown || keys.rightKeyDown) && tutorialProgress == 2) {
					canAdvanceText = true;
					checkForText();
				}
			}
			if (playerShouldBeIdle()) {
				player.displayIdle();
			}
		}
		
		private function playerShouldBeIdle():Boolean {
			return ((!keys.leftKeyDown && !keys.rightKeyDown) || (keys.leftKeyDown && keys.rightKeyDown)) && player.grounded
		}
		
		private function fall():void {
			if (player.grounded)
				return;
			player.displayFalling();
			if (player.jumpSpeed - player.gravity < -IMPULSE_SIZE) {
				player.jumpSpeed = -IMPULSE_SIZE;
			}
			player.jumpSpeed -= player.gravity;
			level.view.y += player.jumpSpeed;
		}
		
		private function collideStamps():void {
			var stamp:MovieClip;
			for (var i:uint = 0; i < level.view.stamps.numChildren; i++) {
				stamp = level.view.stamps.getChildAt(i) as MovieClip;
				if (player.view.hitBox.hitTestObject(stamp)) {
					Util.orphanDisplayObject(stamp);
					userInterface.increaseScore();
				}
			}
		}
		
		private function collideTea():void {
			var teaCup:MovieClip = level.view.teaCup;
			if (player.view.hitBox.hitTestObject(teaCup)) {
				Util.orphanDisplayObject(teaCup);
				userInterface.increaseLives();
			}
		}
		
		private function collideGhosts():void {
			player.updateInvincibility();
			if (!player.invincible) {
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.view.ghosts.numChildren; i++) {
					ghost = level.view.ghosts.getChildAt(i) as MovieClip;
					if (player.view.hitBox.hitTestObject(ghost)) {
						hurtPlayer();
					}
				}
			}
		}
		
		private function hurtPlayer():void {
			userInterface.decreaseLives();
			if (userInterface.life == 0) {
				killPlayer();
			} else {
				player.invincible = true;
				if (!textBox.visible) {
					player.view.invincibility.play();
				}
			}
		}
		
		private function killPlayer():void {
			player.freeze();
			textBox.displayTextPane(16);
			textBox.show();
		}
		
		public function attack():void {
			if (player.grounded && !player.attacking && player.canAttack && keys.canAttack) {
				keys.canAttack = false;
				player.attacking = true;
				var ghost:MovieClip;
				for (var i:uint = 0; i < level.view.ghosts.numChildren; i++) {
					ghost = level.view.ghosts.getChildAt(i) as MovieClip;
					if (ghost.hitTestObject(player.view.attackHitBox)) {
						Util.orphanDisplayObject(ghost);
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
					player.canMove = true;
					canAdvanceText = false;
					break;
				case 2:
					if (canAdvanceText) {
						textBox.displayTextPane(3);
						tutorialProgress = 3;
						canAdvanceText = false;
						player.canJump = true;
						player.canMove = false;
					}
					break;
				case 3:
					if (canAdvanceText) {
						textBox.displayTextPane(4);
						tutorialProgress = 4;
						canAdvanceText = false;
						player.canJump = false;
						player.canAttack = true;
					}
					break;
				case 4:
					if (canAdvanceText) {
						textBox.displayTextPane(5);
						tutorialProgress = 5;
						player.canAttack = false;
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
					player.canJump = true;
					player.canAttack = true;
					player.canMove = true;
					tutorialProgress = 13;
					level.view.officer.gotoAndPlay(7);
					level.view.missionRunners.play();
					break;
				case 12:
					textBox.hide();
					player.canMove = true;
					player.canJump = true;
					player.canAttack = true;
					textBox.displayTextPane(13);
					userInterface.startMission();
					currentMission = 1
					break;
				case 13:
					level.view.missionRunners.play();
					textBox.displayTextPane(14);
					textBox.box.PlayAgain.addEventListener(MouseEvent.CLICK, gameWin);
					break;
				case 14:
					textBox.hide()
					player.canMove = true;
					player.canJump = true;
					player.canAttack = true;
					break;
				case 15:
					// end game
					break;
				case 16:
					textBox.displayTextPane(17);
					break;
				case 17:
					// end game
					break;
			}
		}
		
		private function gameWin(MouseEvent):void {
			resetGame();
			restartGameFunction();
		}
		
		private function resetGame():void {
			for (var j:int = 5; j > 0; j--) {
				resetLevel(j)
			}
			collectedItem = false
			currentMission = 0
			textBox.displayTextPane(12);
			textBox.hide()
			level.reset();
			userInterface.reset();
			clockManager.stop();
			player.reset();
			player.view.removeEventListener(Event.ENTER_FRAME, playerMove);
		}
		
		private function resetLevel(levelNumber:int):void {
			level.enterLevel(levelNumber);
			if (levelNumber != 1) {
				level.resetMissionObjects();
			}
			level.resetStamps();
			level.resetGhosts();
			level.currentLevel = levelNumber;
		}
		
		private function questAlert():void {
			userInterface.showQuestIcon();
			soundManager.playQuestSound();
		}
		
		private function checkMissionDialougeCollision():void {
			if (level.currentLevel != 1)
				return;
			if (level.view.missionRunners.currentFrame == currentMission * 180 + 102) {
				if (!userInterface.isQuestIconVisible()) {
					questAlert()
				}
			}
			if (player.view.hitBox.hitTestObject(level.view.lostAndFound.hitBox)) {
				if (!collectedItem) {
					if (level.view.missionRunners.currentFrame == currentMission * 180 + 102) {
						if (!userInterface.isQuestIconVisible()) {
							questAlert()
						}
						switchToText()
					}
				} else {
					if (textBox.currentTextPane == 13) {
						switchToText()
						if (level.view.missionRunners.currentFrame != 105) {
							soundManager.playCompleteSound();
						}
						level.view.missionRunners.gotoAndStop(105)
					}
				}
			}
		}
		
		private function switchToText():void {
			player.displayIdle();
			textBox.show();
			player.freeze();
			canAdvanceText = true;
		}
		
		public function viewMap():void {
			if (level.view.currentFrame < 17) {
				player.view.removeEventListener(Event.ENTER_FRAME, playerMove);
				player.view.visible = false;
				userInterface.hideInterface();
				level.displayMap();
				level.view.map1.train_station_btn.addEventListener(MouseEvent.CLICK, function(e:Event) {
						goToLevel(1);
					});
				level.view.map1.north_wing_btn.addEventListener(MouseEvent.CLICK, function(e:Event) {
						goToLevel(2);
					});
				level.view.map1.east_wing_btn.addEventListener(MouseEvent.CLICK, function(e:Event) {
						goToLevel(3);
					});
				level.view.map1.south_wing_btn.addEventListener(MouseEvent.CLICK, function(e:Event) {
						goToLevel(4);
					});
				level.view.map1.west_wing_btn.addEventListener(MouseEvent.CLICK, function(e:Event) {
						goToLevel(5);
					});
			} else {
				goToLevel(level.currentLevel)
			}
		}
		
		private function goToLevel(levelNumber:int):void {
			player.view.addEventListener(Event.ENTER_FRAME, playerMove);
			level.goToLevel(levelNumber);
			if (level.currentLevel == 1) {
				if (tutorialProgress == 13) {
					level.view.officer.gotoAndStop(31);
				}
				if (currentMission == 1) {
					level.view.missionRunners.gotoAndStop(104);
				}
			}
			userInterface.showInterface();
			player.view.visible = true
		}
		
		private function collideMissionObjects():void {
			if (level.currentLevel == 5 && level.view.mission_objects.object_1.visible) {
				if (player.view.hitBox.hitTestObject(level.view.mission_objects.object_1)) {
					collectMissionObject();
				}
			}
		}
		
		private function collectMissionObject():void {
			level.view.mission_objects.object_1.visible = false;
			userInterface.hideItemIcon();
			collectedItem = true;
		}
		
		private function clock(event:TimerEvent):void {
			clockManager.clock(event);
		}
	}
}