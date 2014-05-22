package {
	import flash.events.MouseEvent;
	import ui.UserInterfaceManager;
	
	public class MissionManager {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var level:LevelManager;
		private var userInterface:UserInterfaceManager;
		private var winGame:Function;
		
		private var _canAdvanceText:Boolean = true;
		private var _currentMission:int = 0;
		private var _tutorialProgress:int = 1; // is never 12 for some reason
		
		public function set canAdvanceText(value:Boolean):void {
			_canAdvanceText = value;
		}
		
		// added for tests, not used in system
		public function get canAdvanceText():Boolean {
			return _canAdvanceText;
		}
		
		public function get currentMission():int {
			return _currentMission;
		}
		
		public function set currentMission(value:int):void {
			_currentMission = value;
		}
		
		public function get tutorialProgress():int {
			return _tutorialProgress;
		}
		
		public function MissionManager(textBox:TextBox, player:PlayerData, level:LevelManager, userInterface:UserInterfaceManager, winGame:Function) {
			this.level = level;
			this.player = player;
			this.textBox = textBox;
			this.userInterface = userInterface;
			this.winGame = winGame;
		}
		
		public function checkForText():void {
			if (!textBox.visible)
				return;
			switch (textBox.currentTextPane) {
				case 1:
					pane1();
					break;
				case 2:
					pane2();
					break;
				case 3:
					pane3();
					break;
				case 4:
					pane4();
					break;
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
				case 10:
					normalPane(textBox.currentTextPane);
					break;
				case 11:
					textBox.displayTextPane(12)
					_tutorialProgress = 13;
					textBox.hide();
					player.canJump = true;
					player.canAttack = true;
					player.canMove = true;
					level.view.officer.gotoAndPlay(7); // extract funciton on level
					level.view.missionRunners.play();
					break;
				case 12:
					textBox.displayTextPane(13);
					_currentMission = 1
					textBox.hide();
					player.canMove = true;
					player.canJump = true;
					player.canAttack = true;
					userInterface.startMission();
					break;
				case 13:
					level.view.missionRunners.play();
					textBox.displayTextPane(14);
					textBox.box.PlayAgain.addEventListener(MouseEvent.CLICK, winGame);
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
		
		private function pane1():void {
			textBox.displayTextPane(2);
			_tutorialProgress = 2;
			_canAdvanceText = false;
			player.canMove = true;
		}
		
		private function pane2():void {
			if (_canAdvanceText) {
				textBox.displayTextPane(3);
				_tutorialProgress = 3;
				_canAdvanceText = false;
				player.canJump = true;
				player.canMove = false;
			}
		}
		
		private function pane3():void {
			if (_canAdvanceText) {
				textBox.displayTextPane(4);
				_tutorialProgress = 4;
				_canAdvanceText = false;
				player.canJump = false;
				player.canAttack = true;
			}
		}
		
		private function pane4():void {
			if (_canAdvanceText) {
				textBox.displayTextPane(5);
				_tutorialProgress = 5;
				player.canAttack = false;
			}
		}
		
		private function normalPane(paneNumber:uint):void {
			textBox.displayTextPane(paneNumber + 1);
			_tutorialProgress = paneNumber + 1;
		}
	}
}