package keyboard {
	import test.Spy;
	
	public class KeyboardResponderSpy extends Spy implements KeyboardResponder {
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