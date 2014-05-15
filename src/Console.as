package  {
	import flash.display.*;
	import flash.text.*;

	public class Console {
		var graphics:Sprite = new Sprite();
		var text:TextField = new TextField();
		
		public function Console(container:DisplayObjectContainer) {
			drawWindow();
			container.addChild(graphics);
			text.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function drawWindow():void {
			graphics.graphics.beginFill(0xAAAAAA);
			graphics.graphics.drawRect(0, 0, 200, 500);
			graphics.addChild(text);
		}
		
		public function log(message:Object):void {
			text.appendText(message.toString() + "\n");
		}
	}
}