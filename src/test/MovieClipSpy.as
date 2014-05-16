package test {
	import flash.display.MovieClip;

	public class MovieClipSpy extends MovieClip {
		private var _spy:Spy;
		
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