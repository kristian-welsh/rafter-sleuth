package src.test {
	import lib.test.AssignedTestSuite;
	import src.missions.MissionManagerTest;

	public class SuiteMissionManager extends AssignedTestSuite {
		public function SuiteMissionManager() {
			super(MissionManagerTest);
			addTest("testPane1");
			addTest("testPane2");
			addTest("testPane3");
			addTest("testPane4");
			addTest("testTutorialPane");
			addTest("testPane11");
			addTest("testPane12");
			addTest("testPane13");
			addTest("testPane14");
			addTest("testPane15");
			addTest("testPane16");
			addTest("testPane17");
		}
	}
}