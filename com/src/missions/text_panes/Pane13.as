package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class Pane13 extends TextPane{

		public function Pane13(textBox:TextBox, manager:MissionManager) {
			super(textBox, manager)
		}

		override public function show():void {
			textBox.displayTextPane(14);
			manager.endMission();
		}
	}
}