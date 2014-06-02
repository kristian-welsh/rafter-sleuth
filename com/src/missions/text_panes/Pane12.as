package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	import src.ui.UIManager;
	
	public class Pane12 implements TextPane {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var userInterface:UIManager;
		private var manager:MissionManager;
		
		public function Pane12(textBox:TextBox, player:PlayerData, userInterface:UIManager, manager:MissionManager) {
			this.textBox = textBox;
			this.player = player;
			this.userInterface = userInterface;
			this.manager = manager;
		}
		
		public function show():void {
			textBox.displayTextPane(13);
			manager.currentMission = 1;
			textBox.hide();
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
			userInterface.startMission();
		}
	}
}