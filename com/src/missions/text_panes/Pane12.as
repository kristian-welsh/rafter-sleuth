package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane12 extends TextPane{

		public function Pane12(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager)
		}

		override public function show():void {
			textBox.hide();
			textBox.displayTextPane(13);
			manager.startMission();

			manager.enablePlayerAttack()
			manager.enablePlayerJump()
			manager.enablePlayerMovement()
		}
	}
}