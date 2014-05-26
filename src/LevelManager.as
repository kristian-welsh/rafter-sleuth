package {
	import flash.display.MovieClip;
	
	public class LevelManager implements ILevelManager {
		private var savedY:Number;
		private var savedX:Number;
		private var _view:MovieClip;
		private var _currentLevel:int = 1;
		
		public function get currentLevel():int {
			return _currentLevel;
		}
		
		public function set currentLevel(value:int):void {
			_currentLevel = value;
		}
		
		public function LevelManager(view:MovieClip) {
			_view = view;
		}
		
		public function enterLevel(levelNumber:int):void {
			view.gotoAndStop(levelNumber);
			view.teaCup.visible = false;
		}
		
		public function resetLevels():void {
			_view.x = 319.6
			_view.y = -1355
			_view.officer.gotoAndPlay(7);
			_view.missionRunners.gotoAndPlay(2);
			for (var j:int = 5; j > 0; j--) {
				resetLevel(j)
			}
		}
		
		public function resetLevel(levelNumber:int):void {
			enterLevel(levelNumber);
			if (levelNumber != 1) {
				resetMissionObjects();
			}
			resetStamps();
			resetGhosts();
			currentLevel = levelNumber;
		}
		
		public function resetMissionObjects():void {
			for (var i:uint = 0; i < view.mission_objects.numChildren; i++) {
				view.mission_objects.getChildAt(i).visible = false;
			}
		}
		
		public function resetStamps():void {
			for (var i:uint = 0; i < view.stamps.numChildren; i++) {
				view.stamps.getChildAt(i).visible = true
			}
		}
		
		public function resetGhosts():void {
			for (var i:uint = 0; i < view.ghosts.numChildren; i++) {
				view.ghosts.getChildAt(i).visible = true
			}
		}
		
		public function displayMap():void {
			savedX = view.x;
			savedY = view.y;
			view.x = 0;
			view.y = 0;
			view.gotoAndStop(18);
		}
		
		public function restorePosition():void {
			view.x = savedX;
			view.y = savedY;
		}
		
		public function displayReleventMissionObjects():void {
			for (var i:uint = 0; i < view.mission_objects.numChildren; i++) {
				view.mission_objects.getChildAt(i).visible = false;
			}
			if (_currentLevel == 5) {
				view.mission_objects.object_1.visible = true;
			}
		}
		
		public function goToLevel(levelNumber:int):void {
			view.gotoAndStop(levelNumber);
			if (currentLevel != levelNumber) {
				currentLevel = levelNumber
				view.x = 319.6
				view.y = -1358
			} else {
				restorePosition();
			}
			if (currentLevel != 1) {
				displayReleventMissionObjects();
			}
		}
		
		public function officerRunAway():void {
			view.officer.gotoAndPlay(7);
		}
		
		public function playMissionRunners():void {
			view.missionRunners.play();
		}
		
		public function get view():MovieClip {
			return _view;
		}
	}
}