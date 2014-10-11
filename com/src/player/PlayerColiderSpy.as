package src.player {
	import flash.display.MovieClip;
	import lib.test.Spy;

	public class PlayerColiderSpy implements IPlayerColider {
		private var spy:Spy

		public function getSpy():Spy {
			return spy
		}

		public function PlayerColiderSpy() {
			spy = new Spy(this)
		}

		public function get view():MovieClip {
			return new MovieClip()
		}

		public function get walkSpeed():Number {
			return 0
		}

		public function get jumpSpeed():Number {
			return -10
		}

		public function isFacingLeft():Boolean {
			return false
		}

		public function isFacingRight():Boolean {
			return false
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