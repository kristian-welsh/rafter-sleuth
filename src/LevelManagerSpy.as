package  {
	import test.Spy;
	import flash.display.MovieClip;

	public class LevelManagerSpy implements ILevelManager {
		private var spy:Spy = new Spy(this);
		
		private var _currentLevel:int = 1;
		private var _view:MovieClip = new MovieClip();
		
		public function get currentLevel():int {
			return _currentLevel;
		}
		
		public function set currentLevel(value:int):void {
			_currentLevel = value;
		}
		
		public function enterLevel(levelNumber:int):void {
			spy.log(enterLevel, [levelNumber]);
		}
		
		public function resetLevels():void {
			spy.log(resetLevels);
		}
		
		public function resetLevel(levelNumber:int):void {
			spy.log(resetLevel, [levelNumber]);
		}
		
		public function resetMissionObjects():void {
			spy.log(resetMissionObjects);
		}
		
		public function resetStamps():void {
			spy.log(resetStamps);
		}
		
		public function resetGhosts():void {
			spy.log(resetGhosts);
		}
		
		public function displayMap():void {
			spy.log(displayMap);
		}
		
		public function restorePosition():void {
			spy.log(restorePosition);
		}
		
		public function displayReleventMissionObjects():void {
			spy.log(displayReleventMissionObjects);
		}
		
		public function goToLevel(levelNumber:int):void {
			spy.log(goToLevel, [levelNumber]);
		}
		
		public function officerRunAway():void {
			spy.log(officerRunAway);
		}
		
		public function playMissionRunners():void {
			spy.log(playMissionRunners);
		}
		
		public function get view():MovieClip {
			return _view;
		}
		
		public function getSpy():Spy {
			return spy;
		}
	}
}