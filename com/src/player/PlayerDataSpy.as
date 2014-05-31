package src.player {
	import asunit.framework.Assert;
	import lib.assert;
	import src.BooleanStringCode;
	
	public class PlayerDataSpy implements PlayerData {
		private var code:BooleanStringCode = new BooleanStringCode();
		
		private var _canMove:Boolean;
		private var _canJump:Boolean;
		private var _canAttack:Boolean;
		
		public function set canMove(value:Boolean):void {
			_canMove = value;
		}
		
		public function set canJump(value:Boolean):void {
			_canJump = value;
		}
		
		public function set canAttack(value:Boolean):void {
			_canAttack = value;
		}
		
		// TODO: From here onward should be a new class
		
		public function prepareAssertState(expectedStateCode:String):void {
			code.prepareAssertState(expectedStateCode);
		}
		
		public function assertState(expectedStateCode:String):void {
			code.assertState(expectedStateCode, [_canMove, _canJump, _canAttack]);
		}
	}
}