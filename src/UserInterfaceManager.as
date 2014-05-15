package  {
	import flash.display.MovieClip;

	public class UserInterfaceManager {
		private var _graphics:MovieClip;
		private var _view:UserInterfaceView;
		
		public function UserInterfaceManager(graphics:MovieClip, view:UserInterfaceView) {
			_graphics = graphics;
			_view = view;
		}
		
		public function initialize():void {
			_view.hideItemIcon();
			_view.hideQuestIcon();
			_view.setMinuteHandRotation(21);
			_view.setSecondHandRotation(21);
		}
		
		public function displayScore(score:int):void {
			_view.setScore(score);
		}
		
		public function displayLife(life:int):void {
			_view.SetLives(life);
		}
		
		public function startMission():void {
			_view.showItemIcon();
			_view.hideQuestIcon();
			_view.showClockHands();
			_view.setMinuteHandRotation(21);
			_view.setSecondHandRotation(21);
		}
		
		public function reset():void {
			_view.hideItemIcon();
			_view.hideQuestIcon();
			_view.hideClockHands();
			_view.setMinuteHandRotation(21);
			_view.setSecondHandRotation(21);
		}
		
		public function showQuestIcon():void {
			_view.showQuestIcon();
		}
		
		public function hideQuestIcon():void {
			_view.hideQuestIcon();
		}
		
		public function isQuestIconVisible():Boolean {
			return _view.questIconVisible;
		}
		
		public function showInterface():void {
			_view.show();
		}
		
		public function hideInterface():void {
			_view.hide();
		}
		
		public function showItemIcon():void {
			_view.showItemIcon();
		}
		
		public function hideItemIcon():void {
			_view.hideItemIcon();
		}
		
		public function tickSecondHand():void {
			_view.addSecondHandRotation(6);
		}
		
		public function tickMinuteHand():void {
			_view.addMinuteHandRotation(0.5);
		}
		
		public function get graphics():MovieClip {
			return _graphics;
		}
	}
}