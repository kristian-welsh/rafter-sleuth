package test {

	public class TextBoxTestSuite extends AssignedTestSuite {
		public function TextBoxTestSuite() {
			super(TextBoxTest);
			test("visible_returns_whether_view_is_visible");
			test("show_makes_view_visible");
			test("hide_makes_view_invisible");
			test("currentTextPane_returns_0");
			test("get_box_does_not_throw_error");
			test("displayTextPane_calls_gotoAndStop_on_view");
		}
	}
}