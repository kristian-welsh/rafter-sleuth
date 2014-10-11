package src.player {
	import flash.display.MovieClip;

	public interface IPlayerColider {
		function get view():MovieClip
		function get walkSpeed():Number
		function get jumpSpeed():Number
		function setGrounded(value:Boolean):void
		function isFacingLeft():Boolean
		function isFacingRight():Boolean
		function fall():void
		function displayIdleLeft():void
		function displayIdleRight():void
	}
}