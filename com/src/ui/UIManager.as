package src.ui {
	public interface UIManager {
		function initialize():void;
		function startMission():void;
		function reset():void;
		function increaseScore():void;
		function get life():uint;
		function increaseLives():void;
		function decreaseLives():void;
		function showQuestIcon():void;
		function hideQuestIcon():void;
		function isQuestIconVisible():Boolean;
		function showInterface():void;
		function hideInterface():void;
		function showItemIcon():void;
		function hideItemIcon():void;
		function tickSecondHand():void;
		function tickMinuteHand():void;
		function clockFinished():Boolean;
	}
}