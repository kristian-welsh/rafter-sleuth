package src.test {
	import lib.test.AssignedTestSuite;
	import src.keyboard.KeyboardControlsTest;
	
	public class SuiteKeyboardControls extends AssignedTestSuite {
		public function SuiteKeyboardControls() {
			super(KeyboardControlsTest);
			test("initial_values_are_correct");
			test("can_set_the_can_attack_variable");
			test("pressing_left_arrow_makes_leftKeyDown_true");
			test("pressing_right_arrow_makes_rightKeyDown_true");
			test("pressing_then_releasing_left_arrow_makes_leftKeyDown_false");
			test("pressing_then_releasing_right_arrow_makes_rightKeyDown_false");
			test("pressing_shift_calls_attack_on_responder");
			test("releasing_shift_makes_canAttack_true");
			test("releasing_space_calls_jump_on_responder");
			test("releasing_enter_calls_checkForText_on_responder");
			test("releasing_m_calls_viewMap_on_responder");
			test("pressing_or_releasing_any_other_key_does_nothing");
		}
	}
}