package  {
	import flash.display.MovieClip;

	public class TextBox {
		private var view:MovieClip;
		private var textPaneNumber:uint = 1;
		
		public function TextBox(view:MovieClip) {
			this.view = view;
		}
		
		public function displayTextPane(textPaneNumber:uint):void {
			this.textPaneNumber = textPaneNumber;
			view.gotoAndStop(textPaneNumber);
		}
		
		public function get currentTextPane():int {
			return textPaneNumber;
		}
		
		public function get box():MovieClip {
			return view.box;
		}
		
		public function get visible():Boolean {
			return view.visible;
		}
		
		public function show():void {
			view.visible = true;
		}
		
		public function hide():void {
			view.visible = false;
		}
	}
}