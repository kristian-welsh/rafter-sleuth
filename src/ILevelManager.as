package {
	import flash.display.MovieClip;
	
	public interface ILevelManager {
		function get currentLevel():int;
		function set currentLevel(value:int):void;
		function enterLevel(levelNumber:int):void;
		function resetLevels():void;
		function resetLevel(levelNumber:int):void;
		function resetMissionObjects():void;
		function resetStamps():void;
		function resetGhosts():void;
		function displayMap():void;
		function restorePosition():void;
		function displayReleventMissionObjects():void;
		function goToLevel(levelNumber:int):void;
		function officerRunAway():void;
		function playMissionRunners():void ;
		function get view():MovieClip;
		
	}
}