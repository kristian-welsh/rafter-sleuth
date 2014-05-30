package src {
	import flash.events.MouseEvent;
	import src.level.ILevelManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	import src.ui.UIManager;
	
	public class MissionManager {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var level:ILevelManager;
		private var userInterface:UIManager;
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
		
		public function MissionManager(textBox:TextBox, player:PlayerData, level:ILevelManager, userInterface:UIManager, winGame:Function) {
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
				default:
					throw new Error("Unexpected case in switch statement of MissionManager::checkForText");
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
					tutorialPane(textBox.currentTextPane);
					break;
				case 11:
					pane11();
					break;
				case 12:
					pane12();
					break;
				case 13:
					pane13();
					break;
				case 14:
					pane14();
					break;
				case 15:
					endGame();
					break;
				case 16:
					textBox.displayTextPane(17);
					break;
				case 17:
					endGame();
					break;
			}
		}
		
		private function pane1():void {
			tutorialPane(1);
			_canAdvanceText = false;
			
			player.canMove = true;
			player.canJump = false;
			player.canAttack = false;
		}
		
		private function pane2():void {
			if (_canAdvanceText) {
				tutorialPane(2);
				_canAdvanceText = false;
				
				player.canMove = false;
				player.canJump = true;
				player.canAttack = false;
			}
		}
		
		private function pane3():void {
			if (_canAdvanceText) {
				tutorialPane(3);
				_canAdvanceText = false;
				
				player.canMove = false;
				player.canJump = false;
				player.canAttack = true;
			}
		}
		
		private function pane4():void {
			if (_canAdvanceText) {
				tutorialPane(4);
				
				player.canMove = false;
				player.canJump = false;
				player.canAttack = false;
			}
		}
		
		private function tutorialPane(paneNumber:uint):void {
			textBox.displayTextPane(paneNumber + 1);
			_tutorialProgress = paneNumber + 1;
		}
		
		private function pane11():void {
			textBox.displayTextPane(12)
			_tutorialProgress = 13;
			textBox.hide();
			
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
			level.officerRunAway();
			level.playMissionRunners();
		}
		
		private function pane12():void {
			textBox.displayTextPane(13);
			_currentMission = 1;
			textBox.hide();
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
			userInterface.startMission();
		}
		
		private function pane13():void {
			textBox.displayTextPane(14);
			textBox.whenPlayAgainClickedExecute(winGame);
			level.playMissionRunners();
		}
		
		private function pane14():void {
			textBox.hide();
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
		}
		
		private function endGame():void {
			// not yet implemented
		}
	}
}