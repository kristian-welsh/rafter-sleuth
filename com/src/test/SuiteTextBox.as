package src.test {
	import lib.test.AssignedTestSuite;
	import src.textbox.TextBoxTest;
	public class SuiteTextBox extends AssignedTestSuite {
		public function SuiteTextBox() {
			super(TextBoxTest);
			test("visible_returns_whether_view_is_visible");
			test("show_makes_view_visible");
			test("hide_makes_view_invisible");
			test("currentTextPane_returns_1");
			test("get_box_does_not_throw_error");
			test("displayTextPane_calls_gotoAndStop_on_view");
		}
	}
}