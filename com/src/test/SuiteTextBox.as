package src.test {
	import lib.test.AssignedTestSuite;
	import src.textbox.TextBoxTest;
	public class SuiteTextBox extends AssignedTestSuite {
		public function SuiteTextBox() {
			super(TextBoxTest);
			addTest("visible_returns_whether_view_is_visible");
			addTest("show_makes_view_visible");
			addTest("hide_makes_view_invisible");
			addTest("currentTextPane_returns_1");
			addTest("get_box_does_not_throw_error");
			addTest("displayTextPane_calls_gotoAndStop_on_view");
		}
	}
}