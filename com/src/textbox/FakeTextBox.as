package src.textbox {
	import flash.display.MovieClip;

	public class FakeTextBox extends TextBox {
		public function FakeTextBox() {
			super(new MovieClip(), function():void{})
		}
		override public function whenPlayAgainClickedRestartGame():void {

		}
	}
}