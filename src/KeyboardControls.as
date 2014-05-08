package  {
	import flash.display.Stage;
	import flash.events.*;
	
	public class KeyboardControls {
		private var main:Main;
		private var _leftKeyDown:Boolean;
		private var _rightKeyDown:Boolean;
		private var _shiftKeyDown:Boolean;
		private var _can_attack:Boolean;
		
		public function KeyboardControls(main:Main) {
			this.main = main;
		}
		
		public function startListening(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, checkKeyDown);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, checkKeyUp);
		}
		
		private function checkKeyDown(event:KeyboardEvent):void {
			if (event.keyCode == Keycode.LEFT_ARROW) {
				_leftKeyDown = true;
			}
			if (event.keyCode == Keycode.RIGHT_ARROW) {
				_rightKeyDown = true;
			}
			if (event.keyCode == Keycode.SHIFT) {
				main.attack();
				_shiftKeyDown = true;
			}
		}
		
		private function checkKeyUp(event:KeyboardEvent):void {
			if (event.keyCode == Keycode.LEFT_ARROW) {
				_leftKeyDown = false;
			}
			if (event.keyCode == Keycode.RIGHT_ARROW) {
				_rightKeyDown = false;
			}
			if (event.keyCode == Keycode.SPACEBAR) {
				main.jump();
			}
			if (event.keyCode == Keycode.ENTER) {
				main.checkForText();
			}
			if (event.keyCode == Keycode.SHIFT) {
				_shiftKeyDown = false;
				_can_attack = true;
			}
			if (event.keyCode == Keycode.M) {
				main.viewMap();
			}
		}
		
		public function get leftKeyDown():Boolean {
			return _leftKeyDown;
		}
		
		public function get rightKeyDown():Boolean {
			return _rightKeyDown;
		}
		
		public function get shiftKeyDown():Boolean {
			return _shiftKeyDown;
		}
		
		public function get can_attack():Boolean {
			return _can_attack;
		}
	}
}