package test {
	import asunit.framework.TestSuite;
	import keyboard.KeyboardControlsTest;
	import ui.UserInterfaceManagerTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new SuiteKeyboardControls());
			addTest(new SuiteTextBox());
			addTest(new SuiteUserInterfaceManager());
			addTest(new MissionManagerTest("testPane1"));
			addTest(new MissionManagerTest("testPane2"));
			addTest(new MissionManagerTest("testPane3"));
			addTest(new MissionManagerTest("testPane4"));
			addTest(new MissionManagerTest("testtutorialPane"));
			addTest(new MissionManagerTest("testPane11"));
			addTest(new MissionManagerTest("testPane12"));
			addTest(new MissionManagerTest("testPane13"));
		}
	}
}