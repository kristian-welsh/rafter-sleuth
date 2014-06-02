package src.keyboard {
	import flash.events.*;
	import src.missions.IMissionManager;
	
	public class KeyboardControls {
		private var responder:KeyboardResponder;
		private var missionManager:IMissionManager;
		
		private var _leftKeyDown:Boolean;
		private var _rightKeyDown:Boolean;
		private var _can_attack:Boolean = true;
		
		public function KeyboardControls(responder:KeyboardResponder, missionManager:IMissionManager) {
			this.responder = responder;
			this.missionManager = missionManager;
		}
		
		public function startListening(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function keyDown(event:KeyboardEvent):void {
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
		
		private function keyUp(event:KeyboardEvent):void {
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
				missionManager.checkForText();
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
		
		public function get canAttack():Boolean {
			return _can_attack;
		}
		
		public function set canAttack(value:Boolean):void {
			_can_attack = value;
		}
	}
}