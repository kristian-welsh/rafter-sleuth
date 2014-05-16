package ui {
	public interface UIView {
		function show():void;
		function hide():void;
		function showQuestIcon():void;
		function hideQuestIcon():void;
		function get questIconVisible():Boolean;
		function showItemIcon():void;
		function hideItemIcon():void;
		function showClockHands():void;
		function hideClockHands():void;
		function setSecondHandRotation(number:Number):void;
		function addSecondHandRotation(number:Number):void;
		function get secondHandRotation():Number;
		function setMinuteHandRotation(number:Number):void;
		function addMinuteHandRotation(number:Number):void;
		function get minuteHandRotation():Number;
		function setScore(score:int):void;
		function setLives(life:int):void;
	}
}