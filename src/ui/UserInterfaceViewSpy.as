package ui {
	import test.Spy;
	
	public class UserInterfaceViewSpy implements UIView {
		private var _spy:Spy;
		
		public function get spy():Spy {
			return _spy;
		}
		
		public function UserInterfaceViewSpy() {
			_spy = new Spy(this);
		}
		
		public function show():void {
			_spy.log(show);
		}
		
		public function hide():void {
			_spy.log(hide);
		}
		
		public function showQuestIcon():void {
			_spy.log(showQuestIcon);
		}
		
		public function hideQuestIcon():void {
			_spy.log(hideQuestIcon);
		}
		
		public function get questIconVisible():Boolean {
			return true;
		}
		
		public function showItemIcon():void {
			_spy.log(showItemIcon);
		}
		
		public function hideItemIcon():void {
			_spy.log(hideItemIcon);
		}
		
		public function showClockHands():void {
			_spy.log(showClockHands);
		}
		
		public function hideClockHands():void {
			_spy.log(hideClockHands);
		}
		
		private var _secondHandRotation:Number = 0;
		
		public function setSecondHandRotation(value:Number):void {
			_secondHandRotation = value
			_spy.log(setSecondHandRotation, [value]);
		}
		
		public function addSecondHandRotation(value:Number):void {
			_spy.log(addSecondHandRotation, [value]);
		}
		
		public function get secondHandRotation():Number {
			return _secondHandRotation;
		}
		
		private var _minuteHandRotation:Number = 0;
		
		public function setMinuteHandRotation(value:Number):void {
			_minuteHandRotation = value
			_spy.log(setMinuteHandRotation, [value]);
		}
		
		public function addMinuteHandRotation(value:Number):void {
			_spy.log(addMinuteHandRotation, [value]);
		}
		
		public function get minuteHandRotation():Number {
			return _minuteHandRotation;
		}
		
		public function setScore(score:int):void {
			_spy.log(setScore, [score]);
		}
		
		public function setLives(life:int):void {
			_spy.log(setLives, [life]);
		}
	}
}