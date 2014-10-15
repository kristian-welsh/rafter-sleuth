package src.test {
	import asunit.framework.TestSuite;
	import lib.test.AssignedTestSuite;
	import lib.test.SuiteProvider;
	import src.ColliderTest;
	import src.keyboard.KeyboardControlsTest;
	import src.missions.MissionManagerTest;
	import src.ui.UserInterfaceManagerTest;

	public class AllTests extends TestSuite {
		public function AllTests() {
			addTests(new UserInterfaceManagerTest())
			addTests(new KeyboardControlsTest())
			addTests(new MissionManagerTest())
			addSuite(new SuiteTextBox())
			addSuite(new SuiteTextPane())
			addTests(new ColliderTest())
		}

		private function addSuite(assignedSuite:AssignedTestSuite):void {
			addTest(assignedSuite.getSuite());
		}

		private function addTests(tests:SuiteProvider):void {
			addTest(tests.getSuite());
		}
	}
}