package src {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.utils.*;
	import lib.*;
	import src.keyboard.*;
	import src.level.*;
	import src.player.*;
	import src.textbox.*;
	import src.ui.*;
	
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
		private var missionManager:MissionManager;
		
		private var collectedItem:Boolean = false;
		
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
			missionManager = new MissionManager(textBox, player, level, userInterface, gameWin);
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
			if (missionManager.tutorialProgress == 3) {
				missionManager.canAdvanceText = true;
				checkForText();
			}
		}
		
		private function playerMove(event:Event):void {
			player.updateInvincibility();
			moveLeftAndRight();
			fall();
			collider.collideV()
			collideStamps();
			collideTea();
			if (!player.invincible)
				collideGhosts();
			player.checkAttackStatus();
			checkMissionDialougeCollision();
			collideMissionObjects();
			if (missionManager.currentMission == 1) {
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
				if (keys.leftKeyDown || keys.rightKeyDown) {
					if (missionManager.tutorialProgress == 2) {
						missionManager.canAdvanceText = true;
						checkForText();
					}
				}
			}
			if (playerShouldBeIdle()) {
				player.displayIdle();
			}
		}
		
		private function playerShouldBeIdle():Boolean {
			return ((!keys.leftKeyDown && !keys.rightKeyDown) || (keys.leftKeyDown && keys.rightKeyDown)) && player.grounded
		}
		
		// TODO: move to player
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
		
		// TODO: standardize the tea in the fla to be the same as the stamps and ghosts to increase duplication.
		private function collideTea():void {
			var teaCup:MovieClip = level.view.teaCup;
			if (player.view.hitBox.hitTestObject(teaCup)) {
				Util.orphanDisplayObject(teaCup);
				userInterface.increaseLives();
			}
		}
		
		private function collideGhosts():void {
			var ghost:MovieClip;
			for (var i:uint = 0; i < level.view.ghosts.numChildren; i++) {
				ghost = level.view.ghosts.getChildAt(i) as MovieClip;
				if (player.view.hitBox.hitTestObject(ghost)) {
					hurtPlayer();
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
				if (missionManager.tutorialProgress == 4) {
					missionManager.canAdvanceText = true;
					checkForText();
				}
			}
		}
		
		public function checkForText():void {
			missionManager.checkForText();
		}
		
		public function gameWin(MouseEvent):void {
			resetGame();
			restartGameFunction();
		}
		
		private function resetGame():void {
			level.resetLevels();
			missionManager.currentMission = 0
			collectedItem = false
			textBox.displayTextPane(12);
			textBox.hide()
			userInterface.reset();
			clockManager.stop();
			player.reset();
			player.view.removeEventListener(Event.ENTER_FRAME, playerMove);
		}
		
		private function questAlert():void {
			userInterface.showQuestIcon();
			soundManager.playQuestSound();
		}
		
		private function checkMissionDialougeCollision():void {
			if (level.currentLevel != 1)
				return;
			if (level.view.missionRunners.currentFrame == missionManager.currentMission * 180 + 102) {
				if (!userInterface.isQuestIconVisible()) {
					questAlert()
				}
			}
			if (player.view.hitBox.hitTestObject(level.view.lostAndFound.hitBox)) {
				if (!collectedItem) {
					if (level.view.missionRunners.currentFrame == missionManager.currentMission * 180 + 102) {
						switchToText()
						if (!userInterface.isQuestIconVisible()) {
							questAlert()
						}
					}
				} else {
					if (textBox.currentTextPane == 13) {
						switchToText()
						if (level.view.missionRunners.currentFrame != 105) {
							soundManager.playCompleteSound();
						}
						level.view.missionRunners.gotoAndStop(105);
					}
				}
			}
		}
		
		private function switchToText():void {
			player.displayIdle();
			textBox.show();
			player.freeze();
			missionManager.canAdvanceText = true;
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
				if (missionManager.tutorialProgress == 12) {
					level.view.officer.gotoAndStop(31);
				}
				if (missionManager.currentMission == 1) {
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