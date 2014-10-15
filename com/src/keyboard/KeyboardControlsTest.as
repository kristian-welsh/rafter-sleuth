package src.keyboard {
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import lib.ReflectionTestSuiteBuilder;
	import lib.test.SuiteProvider;
	import src.missions.MissionManagerSpy;

	public class KeyboardControlsTest extends TestCase implements SuiteProvider {
		private var responder:KeyboardResponderSpy;
		private var controls:KeyboardControls;
		private var dispatcher:EventDispatcher;
		private var missionManager:MissionManagerSpy;

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTest(initial_values_are_correct);
			testSuite.addTest(can_set_the_can_attack_variable);
			testSuite.addTest(pressing_left_arrow_makes_leftKeyDown_true);
			testSuite.addTest(pressing_right_arrow_makes_rightKeyDown_true);
			testSuite.addTest(pressing_then_releasing_left_arrow_makes_leftKeyDown_false);
			testSuite.addTest(pressing_then_releasing_right_arrow_makes_rightKeyDown_false);
			testSuite.addTest(pressing_shift_calls_attack_on_responder);
			testSuite.addTest(releasing_shift_makes_canAttack_true);
			testSuite.addTest(releasing_space_calls_jump_on_responder);
			testSuite.addTest(releasing_enter_calls_checkForText_on_responder);
			testSuite.addTest(releasing_m_calls_viewMap_on_responder);
			testSuite.addTest(pressing_or_releasing_any_other_key_does_nothing);
			return testSuite.getSuite()
		}

		public function KeyboardControlsTest(testMethod:String = null):void {
			super(testMethod);
		}

		override protected function setUp():void {
			responder = new KeyboardResponderSpy();
			missionManager = new MissionManagerSpy();
			controls = new KeyboardControls(responder, missionManager);
			dispatcher = new EventDispatcher();
			controls.startListening(dispatcher);
		}

		public function initial_values_are_correct():void {
			assertInitialValues();
		}

		private function assertInitialValues():void {
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
			responder.getSpy().assertLogged(responder.attack);
		}

		public function releasing_shift_makes_canAttack_true():void {
			controls.canAttack = false;
			releaseKey(Keycode.SHIFT);
			assertTrue(controls.canAttack);
		}

		public function releasing_space_calls_jump_on_responder():void {
			releaseKey(Keycode.SPACEBAR);
			responder.getSpy().assertLogged(responder.jump);
		}

		public function releasing_enter_calls_checkForText_on_responder():void {
			releaseKey(Keycode.ENTER);
			missionManager.getSpy().assertLogged(missionManager.checkForText);
		}

		public function releasing_m_calls_viewMap_on_responder():void {
			releaseKey(Keycode.M);
			responder.getSpy().assertLogged(responder.viewMap);
		}

		public function pressing_or_releasing_any_other_key_does_nothing():void {
			pressKey(555);
			assertInitialValues();
			releaseKey(555);
			assertInitialValues();
			responder.getSpy().assertNoLogs();
		}

		private function pressKey(keyCode:uint):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN)
			event.keyCode = keyCode
			dispatcher.dispatchEvent(event);
		}

		private function releaseKey(keyCode:uint):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_UP)
			event.keyCode = keyCode
			dispatcher.dispatchEvent(event);
		}
	}
}