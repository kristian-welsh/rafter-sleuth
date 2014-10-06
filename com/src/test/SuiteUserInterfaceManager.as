package src.test {
	import lib.test.AssignedTestSuite;
	import src.ui.UserInterfaceManagerTest;

	public class SuiteUserInterfaceManager extends AssignedTestSuite {
		public function SuiteUserInterfaceManager() {
			super(UserInterfaceManagerTest);
			addTest("initialize");
			addTest("startMission");
			addTest("reset");
			addTest("showQuestIcon");
			addTest("hideQuestIcon");
			addTest("isQuestIconVisible");
			addTest("showInterface");
			addTest("hideInterface");
			addTest("showItemIcon");
			addTest("hideItemIcon");
			addTest("tickSecondHand");
			addTest("tickMinuteHand");
			addTest("clockFinished");
			addTest("increaseScore");
			addTest("increaseLives");
		}
	}
}