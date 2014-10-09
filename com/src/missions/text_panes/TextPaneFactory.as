package src.missions.text_panes {
	import src.level.ILevelManager;
	import src.missions.MissionManager;
	import src.textbox.TextBox;

	public class TextPaneFactory {
		private var textBox:TextBox
		private var level:ILevelManager
		private var manager:MissionManager

		public function TextPaneFactory(textBox:TextBox, level:ILevelManager, manager:MissionManager) {
			this.level = level
			this.textBox = textBox
			this.manager = manager
		}

		public function createTextPane(currentPane:uint):ITextPane {
			switch (currentPane) {
				default:
					throw new Error("Unexpected case in switch statement of TextPaneFactory::createTextPane")
				case 1:
					return new Pane1(textBox, manager)
				case 2:
					return new Pane2(textBox, manager)
				case 3:
					return new Pane3(textBox, manager)
				case 4:
					return new Pane4(textBox, manager)
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
				case 10:
					return new TutorialPane(textBox, manager, textBox.currentTextPane)
				case 11:
					return new Pane11(textBox, manager)
				case 12:
					return new Pane12(textBox, manager)
				case 13:
					return new Pane13(textBox, manager)
				case 14:
					return new Pane14(textBox, manager)
				case 15:
					return new EndGamePane(textBox, manager)
				case 16:
					return new Pane16(textBox, manager)
				case 17:
					return new EndGamePane(textBox, manager)
			}
		}
	}
}