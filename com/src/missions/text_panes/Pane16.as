package src.missions.text_panes {
	import src.missions.text_panes.TextPane;
	import src.textbox.TextBox;
	

	public class Pane16 implements TextPane {
		private var textBox:TextBox;
		
		public function Pane16(textBox:TextBox) {
			this.textBox = textBox;
		}
		
		public function show():void {
			textBox.displayTextPane(17);
		}
	}
}