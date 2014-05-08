package keyboard {

	public class FakeKeyboardResponder implements KeyboardResponder {
		private var _functionLogger:Vector.<String> = new Vector.<String>()
		
		public function jump():void {
			functionLogger.push("jump");
		}
		
		public function checkForText():void {
			functionLogger.push("checkForText");
		}
		
		public function viewMap():void {
			functionLogger.push("viewMap");
		}
		
		public function attack():void {
			functionLogger.push("attack");
		}
		
		public function get functionLogger():Vector.<String> {
			return _functionLogger;
		}
	}
}