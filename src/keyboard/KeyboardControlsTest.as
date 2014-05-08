package keyboard {
	import asunit.framework.TestCase;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class KeyboardControlsTest extends TestCase {
		private var responder:KeyboardResponder;
		private var controls:KeyboardControls;
		private var dispatcher:EventDispatcher;
		
		public function KeyboardControlsTest(testMethod:String):void {
			super(testMethod);
		}
		
		override protected function setUp():void {
			responder = new FakeKeyboardResponder();
			controls = new KeyboardControls(responder);
			dispatcher = new EventDispatcher();
			controls.startListening(dispatcher);
		}
		
		public function initial_values_are_correct():void {
			assertTrue(controls.can_attack)
			assertTrue(!controls.leftKeyDown)
			assertTrue(!controls.rightKeyDown)
		}
		
		private function pressKey(keyCode:uint):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, keyCode)
			dispatcher.dispatchEvent(event);
		}
	}
}