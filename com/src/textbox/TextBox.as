package src.textbox {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class TextBox {
		public static const WIN_PANE:uint = 14

		private var view:MovieClip
		private var gameRestartFunction:Function;

		private var textPaneNumber:uint = 1

		public function TextBox(view:MovieClip, gameWinFunction:Function) {
			this.view = view
			this.gameRestartFunction = gameWinFunction;
		}

		public function displayTextPane(textPaneNumber:uint):void {
			this.textPaneNumber = textPaneNumber
			view.gotoAndStop(textPaneNumber)
			if (textPaneNumber == 14)
				whenPlayAgainClickedRestartGame();
		}

		public function whenPlayAgainClickedRestartGame():void {
			view.box.PlayAgain.addEventListener(MouseEvent.CLICK, gameRestartFunction)
		}

		public function get currentTextPane():int {
			return textPaneNumber
		}

		public function get box():MovieClip {
			return view.box
		}

		public function get visible():Boolean {
			return view.visible
		}

		public function show():void {
			view.visible = true
		}

		public function hide():void {
			view.visible = false
		}
	}
}