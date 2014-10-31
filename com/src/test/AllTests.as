package src.test {
	import asunit.framework.TestSuite;
	import lib.test.SuiteProvider;
	import src.collision.HorizontalColliderTest;
	import src.keyboard.KeyboardControlsTest;
	import src.missions.MissionManagerTest;
	import src.missions.text_panes.TextPaneTest;
	import src.textbox.TextBoxTest;
	import src.ui.UserInterfaceManagerTest;
	import src.collision.VerticalColliderTest;

	public class AllTests extends TestSuite {
		public function AllTests() {
			includeTestsFrom(new UserInterfaceManagerTest())
			includeTestsFrom(new KeyboardControlsTest())
			includeTestsFrom(new MissionManagerTest())
			includeTestsFrom(new TextBoxTest())
			includeTestsFrom(new TextPaneTest())
			includeTestsFrom(new VerticalColliderTest())
			includeTestsFrom(new HorizontalColliderTest())
		}

		private function includeTestsFrom(tests:SuiteProvider):void {
			addTest(tests.getSuite());
		}
	}
}