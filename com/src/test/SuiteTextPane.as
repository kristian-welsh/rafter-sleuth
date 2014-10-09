package src.test {
	import lib.test.AssignedTestSuite;
	import src.missions.text_panes.TextPaneTest;


	public class SuiteTextPane extends AssignedTestSuite {
		public function SuiteTextPane() {
			super(TextPaneTest);
			addTest("throws_correct_error_on_show")
		}
	}
}