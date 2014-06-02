package src.missions {
	import src.level.ILevelManager;
	import src.missions.text_panes.*;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	import src.ui.UIManager;
	
	public class MissionManager implements IMissionManager {
		private var textBox:TextBox;
		private var factory:TextPaneFactory;
		
		private var _canAdvanceText:Boolean = true;
		private var _currentMission:uint = 0;
		private var _tutorialProgress:uint = 1;
		
		public function MissionManager(textBox:TextBox, player:PlayerData, level:ILevelManager, userInterface:UIManager, winGame:Function) {
			this.textBox = textBox;
			factory = new TextPaneFactory(textBox, player, level, userInterface, winGame, this)
		}
		
		public function checkForText():void {
			var pane:TextPane = factory.createTextPane(textBox.currentTextPane)
			if (textBox.visible) // if statement is untested
				pane.show();
		}
		
		// added for tests, not used in system
		public function get canAdvanceText():Boolean {
			return _canAdvanceText;
		}
		
		public function set canAdvanceText(value:Boolean):void {
			_canAdvanceText = value;
		}
		
		public function get currentMission():uint {
			return _currentMission;
		}
		
		public function set currentMission(value:uint):void {
			_currentMission = value;
		}
		
		public function get tutorialProgress():uint {
			return _tutorialProgress;
		}
		
		public function set tutorialProgress(value:uint):void {
			_tutorialProgress = value;
		}
	}
}