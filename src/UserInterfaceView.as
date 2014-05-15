package  {
	import flash.display.MovieClip;
	
	public class UserInterfaceView {
		private var _graphics:MovieClip;
		
		public function UserInterfaceView(graphics:MovieClip) {
			_graphics = graphics;
		}
		
		public function setSecondHandRotation(number:Number):void {
			_graphics.pocketWatch.second_hand.rotation = number;
		}
		
		public function addSecondHandRotation(number:Number):void {
			_graphics.pocketWatch.second_hand.rotation += number;
		}
		
		public function setMinuteHandRotation(number:Number):void {
			_graphics.pocketWatch.minute_hand.rotation = number;
		}
		
		public function addMinuteHandRotation(number:Number):void {
			_graphics.pocketWatch.minute_hand.rotation += number;
		}
		
		public function setScore(score:int):void {
			_graphics.score_text.text = score.toString();
		}
		
		public function SetLives(life:int):void {
			_graphics.teaPot.gotoAndStop(life + 1);
		}
		
		public function showItemIcon():void {
			_graphics.itemIcon.visible = true;
		}
		
		public function hideItemIcon():void {
			_graphics.itemIcon.visible = false;
		}
		
		public function hideQuestIcon():void {
			_graphics.questIcon.visible = false;
		}
		
		public function showClockHands():void {
			_graphics.pocketWatch.minute_hand_target.visible = true;
			_graphics.pocketWatch.second_hand_target.visible = true;
		}
		
		public function hideClockHands():void {
			_graphics.pocketWatch.minute_hand_target.visible = false;
			_graphics.pocketWatch.second_hand_target.visible = false;
		}
		
		public function showQuestIcon():void {
			_graphics.questIcon.visible = true;
		}
		
		public function show():void {
			_graphics.visible = true;
		}
		
		public function hide():void {
			_graphics.visible = false;
		}
		
		public function get questIconVisible():Boolean {
			return _graphics.questIcon.visible;
		}
		
		public function get secondHandRotation():Number {
			return _graphics.pocketWatch.second_hand.rotation;
		}
		
		public function get minuteHandRotation():Number {
			return _graphics.pocketWatch.minute_hand.rotation;
		}
	}
}