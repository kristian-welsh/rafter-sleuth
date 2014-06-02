package src.missions.text_panes {
	import src.level.ILevelManager;
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;

	public class Pane11 implements TextPane {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var level:ILevelManager;
		private var manager:MissionManager;
		
		public function Pane11(textBox:TextBox, player:PlayerData, level:ILevelManager, manager:MissionManager) {
			this.textBox = textBox;
			this.player = player;
			this.level = level;
			this.manager = manager;
		}
		
		public function show():void {
			textBox.hide();
			textBox.displayTextPane(12)
			manager.tutorialProgress = 12;
			
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
			level.officerRunAway();
			level.playMissionRunners();
		}
	}
}