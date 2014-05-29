package  {
	import flash.display.MovieClip;
	import test.Spy;

	public class TextBoxSpy extends TextBox {
		var spy:Spy = new Spy(this);
		
		public function TextBoxSpy(view:MovieClip) {
			super(view);
		}
		
		override public function displayTextPane(textPaneNumber:uint):void {
			spy.log(displayTextPane, [textPaneNumber]);
			super.displayTextPane(textPaneNumber);
		}
		
		override public function show():void {
			spy.log(show);
			super.show();
		}
		
		override public function hide():void {
			spy.log(hide);
			super.hide();
		}
		
		public function getSpy():Spy {
			return spy;
		}
	}
}