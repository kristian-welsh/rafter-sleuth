package keyboard {
	import asunit.framework.TestCase;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class KeyboardControlsTest extends TestCase {
		private var responder:FakeKeyboardResponder;
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
			assertTrue(controls.canAttack)
			assertTrue(!controls.leftKeyDown)
			assertTrue(!controls.rightKeyDown)
		}
		
		public function can_set_the_can_attack_variable():void {
			controls.canAttack = false;
			assertFalse(controls.canAttack);
			controls.canAttack = true;
			assertTrue(controls.canAttack);
		}
		
		public function pressing_left_arrow_makes_leftKeyDown_true():void {
			pressKey(Keycode.LEFT_ARROW);
			assertTrue(controls.leftKeyDown);
		}
		
		public function pressing_right_arrow_makes_rightKeyDown_true():void {
			pressKey(Keycode.RIGHT_ARROW);
			assertTrue(controls.rightKeyDown);
		}
		
		public function pressing_then_releasing_left_arrow_makes_leftKeyDown_false():void {
			pressKey(Keycode.LEFT_ARROW);
			releaseKey(Keycode.LEFT_ARROW);
			assertFalse(controls.leftKeyDown);
		}
		
		public function pressing_then_releasing_right_arrow_makes_rightKeyDown_false():void {
			pressKey(Keycode.RIGHT_ARROW);
			releaseKey(Keycode.RIGHT_ARROW);
			assertFalse(controls.rightKeyDown);
		}
		
		public function pressing_shift_calls_attack_on_responder():void {
			pressKey(Keycode.SHIFT);
			responder.assertCalled(responder.attack);
		}
		
		public function releasing_shift_makes_canAttack_true():void {
			controls.canAttack = false;
			releaseKey(Keycode.SHIFT);
			assertTrue(controls.canAttack);
		}
		
		public function releasing_space_calls_jump_on_responder():void {
			releaseKey(Keycode.SPACEBAR);
			responder.assertCalled(responder.jump);
		}
		
		public function releasing_enter_calls_checkForText_on_responder():void {
			releaseKey(Keycode.ENTER);
			responder.assertCalled(responder.checkForText);
		}
		
		public function releasing_m_calls_viewMap_on_responder():void {
			releaseKey(Keycode.M);
			responder.assertCalled(responder.viewMap);
		}
		
		private function pressKey(keyCode:uint):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, keyCode)
			dispatcher.dispatchEvent(event);
		}
		
		private function releaseKey(keyCode:uint):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, keyCode)
			dispatcher.dispatchEvent(event);
		}
	}
}