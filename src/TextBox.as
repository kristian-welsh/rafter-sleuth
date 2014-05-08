package  {
	import flash.display.MovieClip;

	public class TextBox {
		private var view:MovieClip;
		
		public function TextBox(view:MovieClip) {
			this.view = view;
		}
		
		public function displayTextPane(textPaneNumber:uint):void {
			view.gotoAndStop(textPaneNumber);
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
		
		public function get currentTextPane():int {
			return view.currentFrame;
		}
		
		public function get box():MovieClip {
			return view.box;
		}
	}
}