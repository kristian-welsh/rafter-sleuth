package ui {
	import test.Spy;
	public class UIManagerFake implements UIManager {
		private var spy:Spy = new Spy(this);
		
		public function getSpy():Spy {
			return spy;
		}
		
		public function initialize():void {
			spy.log(initialize);
		}
		
		public function startMission():void {
			spy.log(startMission);
		}
		
		public function reset():void {
			spy.log(reset);
		}
		
		public function increaseScore():void {
			spy.log(increaseScore);
		}
		
		public function get life():uint {
			return 0;
		}
		
		public function increaseLives():void {
			spy.log(increaseLives);
		}
		
		public function decreaseLives():void {
			spy.log(decreaseLives);
		}
		
		public function showQuestIcon():void {
			spy.log(showQuestIcon);
		}
		
		public function hideQuestIcon():void {
			spy.log(hideQuestIcon);
		}
		
		public function isQuestIconVisible():Boolean {
			return false;
		}
		
		public function showInterface():void {
			spy.log(showInterface);
		}
		
		public function hideInterface():void {
			spy.log(hideInterface);
		}
		
		public function showItemIcon():void {
			spy.log(showItemIcon);
		}
		
		public function hideItemIcon():void {
			spy.log(hideItemIcon);
		}
		
		public function tickSecondHand():void {
			spy.log(tickSecondHand);
		}
		
		public function tickMinuteHand():void {
			spy.log(tickMinuteHand);
		}
		
		public function clockFinished():Boolean {
			return false;
		}
	}
}