package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane2 extends TutorialPane {

		public function Pane2(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager, 2);
		}

		override public function show():void {
			super.show();

			manager.disableTextAdvancement()
			manager.disablePlayerMovement()
			manager.disablePlayerAttack()
			manager.enablePlayerJump()
		}
	}
}