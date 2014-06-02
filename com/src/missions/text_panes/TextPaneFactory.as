package src.missions.text_panes {
	import src.level.ILevelManager;
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	import src.ui.UIManager;
	
	public class TextPaneFactory {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var level:ILevelManager;
		private var userInterface:UIManager;
		private var winGame:Function;
		private var manager:MissionManager;
		
		public function TextPaneFactory(textBox:TextBox, player:PlayerData, level:ILevelManager, userInterface:UIManager, winGame:Function, manager:MissionManager) {
			this.winGame = winGame;
			this.userInterface = userInterface;
			this.level = level;
			this.player = player;
			this.textBox = textBox;
			this.manager = manager;
		}
		
		public function createTextPane(currentPane:uint):TextPane {
			switch (currentPane) {
				default:
					throw new Error("Unexpected case in switch statement of MissionManager::checkForText");
				case 1:
					return new Pane1(textBox, player, manager);
				case 2:
					return new Pane2(textBox, player, manager);
				case 3:
					return new Pane3(textBox, player, manager);
				case 4:
					return new Pane4(textBox, player, manager);
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
				case 10:
					return new TutorialPane(textBox, manager, textBox.currentTextPane);
				case 11:
					return new Pane11(textBox, player, level, manager);
				case 12:
					return new Pane12(textBox, player, userInterface, manager);
				case 13:
					return new Pane13(textBox, level, winGame);
				case 14:
					return new Pane14(textBox, player);
				case 15:
					return new EndGamePane();
				case 16:
					return new Pane16(textBox);
				case 17:
					return new EndGamePane();
			}
		}
	}
}