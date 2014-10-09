package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane3 extends TutorialPane {

		public function Pane3(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager, 3);
		}

		override public function show():void {
			super.show();

			manager.disableTextAdvancement()
			manager.disablePlayerMovement()
			manager.disablePlayerJump()
			manager.enablePlayerAttack()
		}
	}
}