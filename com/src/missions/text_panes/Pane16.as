package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane16 extends TextPane{
		public function Pane16(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager)
		}

		override public function show():void {
			textBox.displayTextPane(17);
		}
	}
}