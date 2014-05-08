package  {
	import flash.display.MovieClip;

	public class TextBoxManager {
		private var textBox:MovieClip;
		
		public function TextBoxManager(textBox:MovieClip) {
			this.textBox = textBox;
		}
		
		public function displayTextPane(textPaneNumber:uint):void {
			textBox.gotoAndStop(textPaneNumber);
		}
		
		public function get visible():Boolean {
			return textBox.visible;
		}
		
		public function show():void {
			textBox.visible = true;
		}
		
		public function hide():void {
			textBox.visible = false;
		}
		
		public function get currentTextPane():int {
			return textBox.currentFrame;
		}
		
		public function get box():MovieClip {
			return textBox.box;
		}
	}
}