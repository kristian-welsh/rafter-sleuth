package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane11 extends TextPane {

		public function Pane11(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager)
		}

		override public function show():void {
			textBox.hide();
			textBox.displayTextPane(12)
			manager.endTutorial();

			manager.enablePlayerAttack()
			manager.enablePlayerJump()
			manager.enablePlayerMovement()
		}
	}
}