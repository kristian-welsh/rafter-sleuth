package src.test {
	import lib.test.AssignedTestSuite;
	import src.keyboard.KeyboardControlsTest;

	public class SuiteKeyboardControls extends AssignedTestSuite {
		public function SuiteKeyboardControls() {
			super(KeyboardControlsTest);
			addTest("initial_values_are_correct");
			addTest("can_set_the_can_attack_variable");
			addTest("pressing_left_arrow_makes_leftKeyDown_true");
			addTest("pressing_right_arrow_makes_rightKeyDown_true");
			addTest("pressing_then_releasing_left_arrow_makes_leftKeyDown_false");
			addTest("pressing_then_releasing_right_arrow_makes_rightKeyDown_false");
			addTest("pressing_shift_calls_attack_on_responder");
			addTest("releasing_shift_makes_canAttack_true");
			addTest("releasing_space_calls_jump_on_responder");
			addTest("releasing_enter_calls_checkForText_on_responder");
			addTest("releasing_m_calls_viewMap_on_responder");
			addTest("pressing_or_releasing_any_other_key_does_nothing");
		}
	}
}