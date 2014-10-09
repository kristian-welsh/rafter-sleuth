package src.missions.text_panes {
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class TutorialPane extends TextPane{
		private var paneNumber:uint;

		public function TutorialPane(textBox:TextBox, manager:MissionManager, paneNumber:uint) {
			super(textBox, manager)
			this.paneNumber = paneNumber;
		}

		override public function show():void {
			textBox.displayTextPane(paneNumber + 1);
			manager.incrementTutorialSection();
		}
	}
}