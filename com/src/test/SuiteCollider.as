package src.test {
	import lib.test.AssignedTestSuite;
	import src.ColliderTest;


	public class SuiteCollider extends AssignedTestSuite {
		public function SuiteCollider() {
			super(ColliderTest)
			addTest("collideV_no_platforms")
			addTest("collideV_platform_about_to_touch_player")
		}
	}
}