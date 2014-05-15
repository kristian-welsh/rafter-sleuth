package keyboard {
	import test.Spy;
	
	public class KeyboardResponderSpy implements KeyboardResponder {
		var _spy:Spy = new Spy();
		
		public function jump():void {
			_spy.log(jump);
		}
		
		public function checkForText():void {
			_spy.log(checkForText);
		}
		
		public function viewMap():void {
			_spy.log(viewMap);
		}
		
		public function attack():void {
			_spy.log(attack);
		}
		
		public function get spy():Spy {
			return _spy;
		}
	}
}