package test {
	import asunit.framework.TestSuite;
	import keyboard.KeyboardControlsTest;
	import ui.UserInterfaceManagerTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new SuiteKeyboardControls());
			addTest(new SuiteTextBox());
			addTest(new SuiteUserInterfaceManager());
		}
	}
}