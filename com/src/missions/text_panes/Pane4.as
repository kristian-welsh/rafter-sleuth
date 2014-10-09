package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane4 extends TutorialPane {

		public function Pane4(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager, 4);
		}

		override public function show():void {
			super.show();

			manager.disablePlayerAttack()
			manager.disablePlayerJump()
			manager.disablePlayerMovement()
		}
	}
}