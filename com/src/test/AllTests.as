package src.test {
	import asunit.framework.TestSuite;
	import lib.test.AssignedTestSuite;
	import src.keyboard.KeyboardControlsTest;
	import src.missions.MissionManagerTest;
	import src.ui.UserInterfaceManagerTest;

	public class AllTests extends TestSuite {
		public function AllTests() {
			addSuite(new SuiteUserInterfaceManager());
			addSuite(new SuiteKeyboardControls());
			addSuite(new SuiteMissionManager());
			addSuite(new SuiteTextBox());
			addSuite(new SuiteTextPane())
		}

		private function addSuite(assignedSuite:AssignedTestSuite):void {
			addTest(assignedSuite.getSuite());
		}
	}
}