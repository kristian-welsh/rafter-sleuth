package test {
	import asunit.textui.TestRunner;
	import flash.display.Sprite;
	import flash.events.Event;

	public class TestingHarness extends Sprite {
		private var testRunner:TestRunner = new TestRunner();
		
		public function TestingHarness() {
			super();
			addChild(testRunner);
			testRunner.start(AllTests, null, true);
		}
	}
}