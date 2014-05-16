package test {
	import ui.UserInterfaceManagerTest;

	public class SuiteUserInterfaceManager extends AssignedTestSuite {
		public function SuiteUserInterfaceManager() {
			super(UserInterfaceManagerTest);
			test("initialize");
			test("displayScore");
			test("displayLife");
			test("startMission");
			test("reset");
			test("showQuestIcon");
			test("hideQuestIcon");
			test("isQuestIconVisible");
			test("showInterface");
			test("hideInterface");
			test("showItemIcon");
			test("hideItemIcon");
			test("tickSecondHand");
			test("tickMinuteHand");
			test("clockFinished");
		}
	}
}