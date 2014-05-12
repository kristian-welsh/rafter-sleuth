package keyboard {
	import test.FunctionCallLogger;
	public class FakeKeyboardResponder extends FunctionCallLogger implements KeyboardResponder {
		public function jump():void {
			log(jump);
		}
		
		public function checkForText():void {
			log(checkForText);
		}
		
		public function viewMap():void {
			log(viewMap);
		}
		
		public function attack():void {
			log(attack);
		}
	}
}