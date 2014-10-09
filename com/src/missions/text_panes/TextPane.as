package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class TextPane implements ITextPane {
		public static const METHOD_NOT_OVERRIDEN_ERROR:Error = new Error("This method must be overriden in a subclass")

		protected var manager:MissionManager;
		protected var textBox:TextBox;

		public function TextPane(textBox:TextBox, manager:MissionManager) {
			this.manager = manager
			this.textBox = textBox
		}

		public function show():void {
			throw METHOD_NOT_OVERRIDEN_ERROR
		}
	}
}