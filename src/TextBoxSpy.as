package  {
	import flash.display.MovieClip;
	import test.Spy;

	public class TextBoxSpy extends TextBox {
		var spy:Spy = new Spy(this);
		
		public function TextBoxSpy() {
			super(new MovieClip());
		}
		
		public function getSpy():Spy {
			return spy;
		}
		
		override public function whenPlayAgainClickedExecute(func:Function):void {
			spy.log(whenPlayAgainClickedExecute, [func]);
		}
	}
}