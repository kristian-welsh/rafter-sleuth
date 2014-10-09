package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane1 extends TutorialPane {

		public function Pane1(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager, 1);
		}

		override public function show():void {
			super.show()

			manager.disableTextAdvancement()
			manager.enablePlayerMovement()
			manager.disablePlayerJump()
			manager.disablePlayerAttack()
		}
	}
}