package  {
	import flash.display.MovieClip;

	public class UserInterfaceManager {
		private var _view:MovieClip;
		
		public function UserInterfaceManager(view:MovieClip) {
			_view = view;
		}
		
		public function initialize():void {
			hideItemIcon();
			hideQuestIcon();
			view.pocketWatch.second_hand.rotation = 21;
			view.pocketWatch.minute_hand.rotation = 21;
		}
		
		public function displayScore(score:int):void {
			view.score_text.text = score.toString();
		}
		
		public function displayLife(life:int):void {
			view.teaPot.gotoAndStop(life + 1);
		}
		
		public function startMission():void {
			view.itemIcon.visible = true;
			view.questIcon.visible = false;
			view.pocketWatch.minute_hand_target.visible = true;
			view.pocketWatch.second_hand_target.visible = true;
			view.pocketWatch.minute_hand_target.rotation = 111;
			view.pocketWatch.second_hand_target.rotation = 21;
		}
		
		public function reset():void {
			view.itemIcon.visible = false;
			view.questIcon.visible = false;
			view.pocketWatch.minute_hand_target.visible = false;
			view.pocketWatch.second_hand_target.visible = false;
			view.pocketWatch.minute_hand.rotation = 21
			view.pocketWatch.second_hand.rotation = 21
		}
		
		public function showQuestIcon():void {
			view.questIcon.visible = true;
		}
		
		public function hideQuestIcon():void {
			view.questIcon.visible = false;
		}
		
		public function isQuestIconVisible():Boolean {
			return view.questIcon.visible;
		}
		
		public function showInterface():void {
			view.visible = true;
		}
		
		public function hideInterface():void {
			view.visible = false;
		}
		
		public function showItemIcon():void {
			view.itemIcon.visible = true;
		}
		
		public function hideItemIcon():void {
			view.itemIcon.visible = false;
		}
		
		public function tickSecondHand():void {
			view.pocketWatch.second_hand.rotation += 6;
		}
		
		public function tickMinuteHand():void {
			view.pocketWatch.minute_hand.rotation += 0.5;
		}
		
		public function get view():MovieClip {
			return _view;
		}
	}
}