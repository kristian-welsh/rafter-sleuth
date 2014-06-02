package src.test {
	import lib.test.AssignedTestSuite;
	import src.missions.MissionManagerTest;
	
	public class SuiteMissionManager extends AssignedTestSuite {
		public function SuiteMissionManager() {
			super(MissionManagerTest);
			test("testPane1");
			test("testPane2");
			test("testPane3");
			test("testPane4");
			test("testTutorialPane");
			test("testPane11");
			test("testPane12");
			test("testPane13");
			test("testPane14");
			test("testPane15");
			test("testPane16");
			test("testPane17");
		}
	}
}