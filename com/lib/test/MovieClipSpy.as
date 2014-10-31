package lib.test {
	import flash.display.MovieClip;
	import lib.test.Spy;

	public class MovieClipSpy extends MovieClip {
		private var _spy:Spy;

		/**
		 * Since you can't change the frame number of a movieclip created by code, use this class to test calls to gotoAndStop.
		 */
		public function MovieClipSpy() {
			_spy = new Spy(this);
			super();
		}

		public function get spy():Spy {
			return _spy;
		}

		override public function gotoAndStop(frame:Object, scene:String = null):void {
			_spy.log(gotoAndStop);
		}

		public function get box():MovieClip {
			return null;
		}
	}
}