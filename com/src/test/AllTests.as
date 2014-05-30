package src.test {
	import asunit.framework.TestSuite;
	import src.keyboard.KeyboardControlsTest;
	import src.MissionManagerTest;
	import src.ui.UserInterfaceManagerTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new SuiteKeyboardControls());
			addTest(new SuiteTextBox());
			addTest(new SuiteUserInterfaceManager());
			addTest(new MissionManagerTest("testPane1"));
			addTest(new MissionManagerTest("testPane2"));
			addTest(new MissionManagerTest("testPane3"));
			addTest(new MissionManagerTest("testPane4"));
			addTest(new MissionManagerTest("testTutorialPane"));
			addTest(new MissionManagerTest("testPane11"));
			addTest(new MissionManagerTest("testPane12"));
			addTest(new MissionManagerTest("testPane13"));
			addTest(new MissionManagerTest("testPane14"));
			addTest(new MissionManagerTest("testPane15"));
			addTest(new MissionManagerTest("testPane16"));
			addTest(new MissionManagerTest("testPane17"));
		}
	}
}