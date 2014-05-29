package src.player {
	import asunit.framework.Assert;
	import lib.assert;
	
	public class PlayerDataSpy implements PlayerData {
		private static const MJA_ONLY_ERROR_MESSAGE:String = "expectedState needs to be a case insensitive string matching \"mja\"";
		
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
		
		/**
		 * Sets state to a state that would fail every test if assertState is called directly after it.
		 * Assumes all values are false when called.
		 * @param	expectedState Is expected to be a string in the form of "MJA". M is canMove; J is canJump; and A is canAttack.
		 * An upper case letter represents true, and a lower case represents false.
		 */
		public function prepareAssertState(expectedStateCode:String):void {
			validateCode(expectedStateCode);
			_canMove = !toBoolean(expectedStateCode.charAt(0));
			_canJump = !toBoolean(expectedStateCode.charAt(1));
			_canAttack = !toBoolean(expectedStateCode.charAt(2));
		}
		
		/**
		 * Assumes letter is case sensitive.
		 * @return true if letter is uppercase, false if it is lowercase.
		 */
		private function toBoolean(letter:String):Boolean {
			if (letter == letter.toUpperCase())
				return true;
			if (letter == letter.toLowerCase())
				return false;
			else
				throw new Error("letter is not case sensitive");
		}
		
		/**
		 * Asserts whether the values infered from expectedState are correct.
		 * @param	expectedState Is expected to be a string in the form of "MJA". M is canMove; J is canJump; and A is canAttack.
		 * An upper case letter represents true, and a lower case represents false.
		 */
		public function assertState(expectedStateCode:String):void {
			validateCode(expectedStateCode);
			assertStateCharacter(expectedStateCode.charAt(0), _canMove);
			assertStateCharacter(expectedStateCode.charAt(1), _canJump);
			assertStateCharacter(expectedStateCode.charAt(2), _canAttack);
		}
		
		private function assertStateCharacter(codeLetter:String, val:Boolean):void {
			Assert.assertEquals(toBoolean(codeLetter), val);
		}
		
		private function validateCode(stateCode:String):void {
			assert(stateCode.toUpperCase() == "MJA", MJA_ONLY_ERROR_MESSAGE);
		}
	}
}