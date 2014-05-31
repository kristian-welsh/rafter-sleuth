package src {
	import asunit.framework.Assert;
	import lib.assert;
	
	public class BooleanStringCode {
		// ######### Warning: Still PlayerDataSpy specific. #########
		
		private static const MJA_ONLY_ERROR_MESSAGE:String = "expectedState needs to be a case insensitive string matching \"mja\"";
		
		private var _canMove:Boolean;
		private var _canJump:Boolean;
		private var _canAttack:Boolean;
		
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
		
		private function validateCode(stateCode:String):void {
			assert(stateCode.toUpperCase() == "MJA", MJA_ONLY_ERROR_MESSAGE);
		}
		
		/**
		 * @param	expectedStateCode Is expected to be a string in the form of "MJA". M is canMove; J is canJump; and A is canAttack.
		 * An upper case letter represents true, and a lower case represents false.
		 * @param	actualState needs to be the same length as expectedStateCode
		 */
		public function assertState(expectedStateCode:String, actualState:Array):void {
			assert(expectedStateCode.length == actualState.length, "expectedStateCode needs to be the same length as actualState");
			validateCode(expectedStateCode);
			assertStateCharacter(expectedStateCode.charAt(0), actualState[0]);
			assertStateCharacter(expectedStateCode.charAt(1), actualState[1]);
			assertStateCharacter(expectedStateCode.charAt(2), actualState[2]);
		}
		
		private function assertStateCharacter(codeLetter:String, val:Boolean):void {
			Assert.assertEquals(toBoolean(codeLetter), val);
		}
		
		/**
		 * @return true if letter is uppercase, false if it is lowercase.
		 * @throws Error if lettter is not case sensitive
		 */
		private function toBoolean(letter:String):Boolean {
			if (isUppercase(letter))
				return true;
			else if (isLowercase(letter))
				return false;
			else
				throw new Error("letter is not case sensitive. letter: " + letter);
		}
		
		private function isUppercase(string:String):Boolean {
			return string == string.toUpperCase();
		}
		
		private function isLowercase(string:String):Boolean {
			return string == string.toLowerCase();
		}
	}
}