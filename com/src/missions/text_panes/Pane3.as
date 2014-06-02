package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;

	public class Pane3 extends TutorialPane implements TextPane {
		private var textBox:TextBox;
		private var player:PlayerData;
		private var manager:MissionManager;
		
		public function Pane3(textBox:TextBox, player:PlayerData, manager:MissionManager) {
			this.textBox = textBox;
			this.player = player;
			this.manager = manager;
			super(textBox, manager, 3);
		}
		
		override public function show():void {
			if (manager.canAdvanceText) {
				super.show();
				manager.canAdvanceText = false;
				
				player.canMove = false;
				player.canJump = false;
				player.canAttack = true;
			}
		}
	}
}