package src.test {
	import asunit.framework.TestSuite;
	import src.keyboard.KeyboardControlsTest;
	import src.missions.MissionManagerTest;
	import src.ui.UserInterfaceManagerTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new SuiteKeyboardControls());
			addTest(new SuiteTextBox());
			addTest(new SuiteUserInterfaceManager());
			addTest(new SuiteMissionManager());
		}
	}
}