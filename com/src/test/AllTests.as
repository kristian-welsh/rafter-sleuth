package src.test {
	import asunit.framework.TestSuite;
	import lib.test.SuiteProvider;
	import src.HorizontalColliderTest;
	import src.keyboard.KeyboardControlsTest;
	import src.missions.MissionManagerTest;
	import src.missions.text_panes.TextPaneTest;
	import src.textbox.TextBoxTest;
	import src.ui.UserInterfaceManagerTest;
	import src.VerticalColliderTest;

	public class AllTests extends TestSuite {
		public function AllTests() {
			addTestClass(new UserInterfaceManagerTest())
			addTestClass(new KeyboardControlsTest())
			addTestClass(new MissionManagerTest())
			addTestClass(new TextBoxTest())
			addTestClass(new TextPaneTest())
			addTestClass(new VerticalColliderTest())
			addTestClass(new HorizontalColliderTest())
		}

		private function addTestClass(tests:SuiteProvider):void {
			addTest(tests.getSuite());
		}
	}
}