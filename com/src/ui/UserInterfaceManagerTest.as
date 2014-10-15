package src.ui {
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	import lib.ReflectionTestSuiteBuilder;
	import lib.test.SuiteProvider;

	public class UserInterfaceManagerTest extends TestCase implements SuiteProvider {
		private var view:UserInterfaceViewSpy;
		private var userInterface:UserInterfaceManager;

		public function getSuite():TestSuite {
			var suite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			suite.addTests([
				initialize,
				startMission,
				reset,
				showQuestIcon,
				hideQuestIcon,
				isQuestIconVisible,
				showInterface,
				hideInterface,
				showItemIcon,
				hideItemIcon,
				tickSecondHand,
				tickMinuteHand,
				clockFinished,
				increaseScore,
				increaseLives]);
			return suite.getSuite()
		}

		public function UserInterfaceManagerTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			view = new UserInterfaceViewSpy()
			userInterface = new UserInterfaceManager(view);
		}

		public function initialize():void {
			userInterface.initialize();
			view.getSpy().assertLogged(view.hideItemIcon);
			view.getSpy().assertLogged(view.hideQuestIcon);
			view.getSpy().assertLogged(view.setMinuteHandRotation, [21]);
			view.getSpy().assertLogged(view.setSecondHandRotation, [21]);
			view.getSpy().assertLogged(view.setLives, [6]);
		}

		public function startMission():void {
			userInterface.startMission();
			view.getSpy().assertLogged(view.showItemIcon);
			view.getSpy().assertLogged(view.hideQuestIcon);
			view.getSpy().assertLogged(view.showClockHands);
			view.getSpy().assertLogged(view.setMinuteHandRotation, [21]);
			view.getSpy().assertLogged(view.setSecondHandRotation, [21]);
		}

		public function reset():void {
			userInterface.reset();
			view.getSpy().assertLogged(view.hideItemIcon);
			view.getSpy().assertLogged(view.hideQuestIcon);
			view.getSpy().assertLogged(view.hideClockHands);
			view.getSpy().assertLogged(view.setMinuteHandRotation, [21]);
			view.getSpy().assertLogged(view.setSecondHandRotation, [21]);
			view.getSpy().assertLogged(view.setScore, [0]);
			view.getSpy().assertLogged(view.setLives, [6]);
		}

		public function showQuestIcon():void {
			userInterface.showQuestIcon();
			view.getSpy().assertLogged(view.showQuestIcon);
		}

		public function hideQuestIcon():void {
			userInterface.hideQuestIcon();
			view.getSpy().assertLogged(view.hideQuestIcon);
		}

		public function isQuestIconVisible():void {
			assertTrue(userInterface.isQuestIconVisible());
		}

		public function showInterface():void {
			userInterface.showInterface()
			view.getSpy().assertLogged(view.show);
		}

		public function hideInterface():void {
			userInterface.hideInterface()
			view.getSpy().assertLogged(view.hide);
		}

		public function showItemIcon():void {
			userInterface.showItemIcon()
			view.getSpy().assertLogged(view.showItemIcon);
		}

		public function hideItemIcon():void {
			userInterface.hideItemIcon()
			view.getSpy().assertLogged(view.hideItemIcon);
		}

		public function tickSecondHand():void {
			userInterface.tickSecondHand()
			view.getSpy().assertLogged(view.addSecondHandRotation, [6]);
		}

		public function tickMinuteHand():void {
			userInterface.tickMinuteHand()
			view.getSpy().assertLogged(view.addMinuteHandRotation, [0.5]);
		}

		public function clockFinished():void {
			assertClockFinishedTrue(1000, 1000);
			assertClockFinishedFalse(1000, 21);
			assertClockFinishedFalse(1000, 0);
			assertClockFinishedFalse(111, 1000);
			assertClockFinishedFalse(0, 1000);
		}

		public function increaseScore():void {
			userInterface.increaseScore();
			view.getSpy().assertLogged(view.setScore, [1]);
		}

		public function increaseLives():void {
			userInterface.increaseLives();
			view.getSpy().assertLogged(view.setLives, [7]);
		}

		private function assertClockFinishedTrue(minutes:Number, seconds:Number):void {
			view.setSecondHandRotation(seconds);
			view.setMinuteHandRotation(minutes);
			assertTrue(userInterface.clockFinished());
		}

		private function assertClockFinishedFalse(minutes:Number, seconds:Number):void {
			view.setSecondHandRotation(seconds);
			view.setMinuteHandRotation(minutes);
			assertFalse(userInterface.clockFinished());
		}
	}
}