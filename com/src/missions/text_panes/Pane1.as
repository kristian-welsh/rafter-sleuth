package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;

	public class Pane1 extends TutorialPane implements TextPane {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var manager:MissionManager;
		
		public function Pane1(textBox:TextBox, player:PlayerData, manager:MissionManager) {
			this.textBox = textBox;
			this.player = player;
			this.manager = manager;
			super(textBox, manager, 1);
		}
		
		override public function show():void {
			super.show();
			manager.canAdvanceText = false;
			
			player.canMove = true;
			player.canJump = false;
			player.canAttack = false;
		}
	}
}