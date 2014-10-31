package src.player {
	import flash.display.MovieClip;
	import lib.test.Spy;

	public class PlayerColiderSpy implements IPlayerColider {
		private var _view:MovieClip = new MovieClip()
		private var spy:Spy
		private var facingLeft:Boolean = false;

		public function getSpy():Spy {
			return spy
		}

		public function PlayerColiderSpy() {
			spy = new Spy(this)
		}

		public function get view():MovieClip {
			return _view
		}

		public function get walkSpeed():Number {
			return 10
		}

		public function get jumpSpeed():Number {
			return -10
		}

		public function faceLeft():void {
			facingLeft = true
		}

		public function faceRight():void {
			facingLeft = false
		}

		public function isFacingLeft():Boolean {
			return facingLeft
		}

		public function isFacingRight():Boolean {
			return !facingLeft
		}

		public function setGrounded(value:Boolean):void {
			spy.log(setGrounded, [value])
		}

		public function fall():void {
			spy.log(fall)
		}

		public function displayIdleLeft():void {
			spy.log(displayIdleLeft)
		}

		public function displayIdleRight():void {
			spy.log(displayIdleRight)
		}
	}
}