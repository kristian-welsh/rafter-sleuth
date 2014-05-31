package src.player {
	import lib.assert;
	import lib.test.BooleanStringCode;
	
	public class PlayerDataSpy implements PlayerData {
		private static const MJA_ONLY_ERROR_MESSAGE:String = "expectedState needs to be a case insensitive string matching \"mja\"";
		
		private var code:BooleanStringCode = new BooleanStringCode();
		
		public function set canMove(value:Boolean):void {
			code.setCodeIndexValue(0, value);
		}
		
		public function set canJump(value:Boolean):void {
			code.setCodeIndexValue(1, value);
		}
		
		public function set canAttack(value:Boolean):void {
			code.setCodeIndexValue(2, value);
		}
		
		/**
		 * @param	expectedState A string in the form of "mJa". M is canMove; J is canJump; and A is canAttack.
		 * An upper case letter represents true, and a lower case represents false.
		 */
		public function prepareAssertState(anticipatedStateCode:String):void {
			validateCode(anticipatedStateCode);
			code.prepareAssertState(anticipatedStateCode);
		}
		
		/**
		 * @param	expectedState A string in the form of "mJa". M is canMove; J is canJump; and A is canAttack.
		 * An upper case letter represents true, and a lower case represents false.
		 */
		public function assertState(expectedStateCode:String):void {
			validateCode(expectedStateCode);
			code.assertState(expectedStateCode);
		}
		
		private function validateCode(stateCode:String):void {
			assert(stateCode.toUpperCase() == "MJA", MJA_ONLY_ERROR_MESSAGE);
		}
	}
}