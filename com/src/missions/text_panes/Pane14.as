package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane14 extends TextPane{

		public function Pane14(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager)
		}

		override public function show():void {
			textBox.hide();
			manager.enablePlayerAttack()
			manager.enablePlayerJump()
			manager.enablePlayerMovement()
		}
	}
}