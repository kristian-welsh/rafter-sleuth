package src.missions.text_panes {
	import src.level.ILevelManager;
	import src.textbox.TextBox;
	
	public class Pane13 implements TextPane {
		private var textBox:TextBox;
		private var level:ILevelManager;
		private var winGameFunction:Function;
		
		public function Pane13(textBox:TextBox, level:ILevelManager, winGameFunction:Function) {
			this.textBox = textBox;
			this.level = level;
			this.winGameFunction = winGameFunction;
		}
		
		public function show():void {
			textBox.displayTextPane(14);
			textBox.whenPlayAgainClickedExecute(winGameFunction);
			level.playMissionRunners();
		}
	}
}