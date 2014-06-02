package src.missions.text_panes {
	import src.level.ILevelManager;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	
	public class Pane14 implements TextPane {
		private var textBox:TextBox;
		private var player:PlayerData;
		
		public function Pane14(textBox:TextBox, player:PlayerData) {
			this.textBox = textBox;
			this.player = player;
		}
		
		public function show():void {
			textBox.hide();
			player.canMove = true;
			player.canJump = true;
			player.canAttack = true;
		}
	}
}