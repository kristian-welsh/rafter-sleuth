package  {
	import flash.display.*;
	import flash.text.*;

	public class Console {
		static public var INSTANCE:Console;
		
		private var graphics:Sprite = new Sprite();
		private var text:TextField = new TextField();
		
		static public function createInstance(container:DisplayObjectContainer):void {
			INSTANCE = new Console(container);
		}
		
		// TODO: Align text to bottom of box.
		public function Console(container:DisplayObjectContainer) {
			drawWindow();
			container.addChild(graphics);
			hide();
			text.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function drawWindow():void {
			graphics.graphics.beginFill(0xAAAAAA);
			graphics.graphics.drawRect(0, 0, 200, 500);
			graphics.addChild(text);
		}
		
		public function show():void {
			graphics.visible = true;
		}
		
		public function hide():void {
			graphics.visible = false;
		}
		
		public function log(message:Object):void {
			text.appendText(message.toString() + "\n");
		}
	}
}