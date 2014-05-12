package test {
	import asunit.framework.TestSuite;
	import keyboard.KeyboardControlsTest;
	
	public class KeyboardControlsTestSuite extends TestSuite {
		public function KeyboardControlsTestSuite() {
			addTest(new KeyboardControlsTest("initial_values_are_correct"));
			addTest(new KeyboardControlsTest("can_set_the_can_attack_variable"));
			addTest(new KeyboardControlsTest("pressing_left_arrow_makes_leftKeyDown_true"));
			addTest(new KeyboardControlsTest("pressing_right_arrow_makes_rightKeyDown_true"));
			addTest(new KeyboardControlsTest("pressing_then_releasing_left_arrow_makes_leftKeyDown_false"));
			addTest(new KeyboardControlsTest("pressing_then_releasing_right_arrow_makes_rightKeyDown_false"));
			addTest(new KeyboardControlsTest("pressing_shift_calls_attack_on_responder"));
			addTest(new KeyboardControlsTest("releasing_shift_makes_canAttack_true"));
			addTest(new KeyboardControlsTest("releasing_space_calls_jump_on_responder"));
			addTest(new KeyboardControlsTest("releasing_enter_calls_checkForText_on_responder"));
			addTest(new KeyboardControlsTest("releasing_m_calls_viewMap_on_responder"));
		}
	}
}