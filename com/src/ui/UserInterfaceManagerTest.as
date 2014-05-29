package src.ui {
	import asunit.framework.TestCase;
	
	public class UserInterfaceManagerTest extends TestCase {
		private var view:UserInterfaceViewSpy;
		private var userInterface:UserInterfaceManager;
		
		public function UserInterfaceManagerTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			view = new UserInterfaceViewSpy()
			userInterface = new UserInterfaceManager(view);
		}
		
		public function initialize():void {
			userInterface.initialize();
			view.spy.assertCalled(view.hideItemIcon);
			view.spy.assertCalled(view.hideQuestIcon);
			view.spy.assertCalledWithArguments(view.setMinuteHandRotation, [21]);
			view.spy.assertCalledWithArguments(view.setSecondHandRotation, [21]);
			view.spy.assertCalledWithArguments(view.setLives, [6]);
		}
		
		public function startMission():void {
			userInterface.startMission();
			view.spy.assertCalled(view.showItemIcon);
			view.spy.assertCalled(view.hideQuestIcon);
			view.spy.assertCalled(view.showClockHands);
			view.spy.assertCalledWithArguments(view.setMinuteHandRotation, [21]);
			view.spy.assertCalledWithArguments(view.setSecondHandRotation, [21]);
		}
		
		public function reset():void {
			userInterface.reset();
			view.spy.assertCalled(view.hideItemIcon);
			view.spy.assertCalled(view.hideQuestIcon);
			view.spy.assertCalled(view.hideClockHands);
			view.spy.assertCalledWithArguments(view.setMinuteHandRotation, [21]);
			view.spy.assertCalledWithArguments(view.setSecondHandRotation, [21]);
			view.spy.assertCalledWithArguments(view.setScore, [0]);
			view.spy.assertCalledWithArguments(view.setLives, [6]);
		}
		
		public function showQuestIcon():void {
			userInterface.showQuestIcon();
			view.spy.assertCalled(view.showQuestIcon);
		}
		
		public function hideQuestIcon():void {
			userInterface.hideQuestIcon();
			view.spy.assertCalled(view.hideQuestIcon);
		}
		
		public function isQuestIconVisible():void {
			assertTrue(userInterface.isQuestIconVisible());
		}
		
		public function showInterface():void {
			userInterface.showInterface()
			view.spy.assertCalled(view.show);
		}
		
		public function hideInterface():void {
			userInterface.hideInterface()
			view.spy.assertCalled(view.hide);
		}
		
		public function showItemIcon():void {
			userInterface.showItemIcon()
			view.spy.assertCalled(view.showItemIcon);
		}
		
		public function hideItemIcon():void {
			userInterface.hideItemIcon()
			view.spy.assertCalled(view.hideItemIcon);
		}
		
		public function tickSecondHand():void {
			userInterface.tickSecondHand()
			view.spy.assertCalledWithArguments(view.addSecondHandRotation, [6]);
		}
		
		public function tickMinuteHand():void {
			userInterface.tickMinuteHand()
			view.spy.assertCalledWithArguments(view.addMinuteHandRotation, [0.5]);
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
			view.spy.assertCalledWithArguments(view.setScore, [1]);
		}
		
		public function increaseLives():void {
			userInterface.increaseLives();
			view.spy.assertCalledWithArguments(view.setLives, [7]);
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