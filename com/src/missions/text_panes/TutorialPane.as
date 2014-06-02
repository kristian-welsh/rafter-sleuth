package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	
	public class TutorialPane implements TextPane {
		private var textBox:TextBox;
		private var manager:MissionManager;
		private var paneNumber:uint;
		
		public function TutorialPane(textBox:TextBox, manager:MissionManager, paneNumber:uint) {
			this.textBox = textBox;
			this.manager = manager;
			this.paneNumber = paneNumber;
		}
		
		public function show():void {
			textBox.displayTextPane(paneNumber + 1);
			manager.tutorialProgress = paneNumber + 1;
		}
	}
}