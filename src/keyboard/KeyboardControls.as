package keyboard {
	import flash.events.*;
	
	public class KeyboardControls {
		private var responder:KeyboardResponder;
		private var _leftKeyDown:Boolean;
		private var _rightKeyDown:Boolean;
		private var _can_attack:Boolean = true;
		
		public function KeyboardControls(responder:KeyboardResponder) {
			this.responder = responder;
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
				responder.attack();
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
				responder.jump();
			}
			if (event.keyCode == Keycode.ENTER) {
				responder.checkForText();
			}
			if (event.keyCode == Keycode.SHIFT) {
				_can_attack = true;
			}
			if (event.keyCode == Keycode.M) {
				responder.viewMap();
			}
		}
		
		public function get leftKeyDown():Boolean {
			return _leftKeyDown;
		}
		
		public function get rightKeyDown():Boolean {
			return _rightKeyDown;
		}
		
		public function get can_attack():Boolean {
			return _can_attack;
		}
		
		public function set can_attack(value:Boolean):void {
			_can_attack = value;
		}
	}
}