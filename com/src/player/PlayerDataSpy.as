package src.player {
	import lib.assert;
	import lib.test.BooleanStringCode;
	
	public class PlayerDataSpy implements PlayerData {
		private var data:BooleanStringCode = new BooleanStringCode();
		
		public function set canMove(value:Boolean):void {
			data.setValueKey(value, "m");
		}
		
		public function set canJump(value:Boolean):void {
			data.setValueKey(value, "j");
		}
		
		public function set canAttack(value:Boolean):void {
			data.setValueKey(value, "a");
		}
		
		public function getData():BooleanStringCode{
			return data;
		}
	}
}