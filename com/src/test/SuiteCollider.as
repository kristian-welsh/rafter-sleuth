package src.test {
	import lib.test.AssignedTestSuite;
	import src.ColliderTest;


	public class SuiteCollider extends AssignedTestSuite {
		public function SuiteCollider() {
			super(ColliderTest)
			addTest("collideV_no_platforms")
			addTest("collideV_platform_about_to_touch_player")
			addTest("collideV_miss_too_far_left")
			addTest("collideV_scrape_too_far_left")
			addTest("collideV_miss_too_far_right")
			addTest("collideV_scrape_too_far_right")
			addTest("collideV_player_too_far_away_verticaly")
			addTest("collideV_platform_just_above_player")
		}
	}
}