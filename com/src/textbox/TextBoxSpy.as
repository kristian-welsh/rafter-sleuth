package src.textbox {
	import flash.display.MovieClip;
	import lib.test.Spy;

	public class TextBoxSpy extends TextBox {
		var spy:Spy = new Spy(this);

		public function TextBoxSpy() {
			super(new MovieClip());
		}

		public function getSpy():Spy {
			return spy;
		}
	}
}