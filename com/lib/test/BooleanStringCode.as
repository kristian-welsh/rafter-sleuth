package lib.test {
	import asunit.framework.Assert;
	import lib.assert;
	
	// TODO: Migrate from array access to hash lookup to make use more intuitive.
	public class BooleanStringCode {
		
		private var states:Vector.<Boolean> = new Vector.<Boolean>()
		
		public function setCodeIndexValue(number:uint, value:Boolean):void {
			states[number] = value;
		}
		
		/**
		 * Sets state to a state that would fail every test if assertState is called directly after it.
		 * @param	expectedState An upper case letter represents true, and a lower case represents false.
		 */
		public function prepareAssertState(anticipatedStateCode:String):void {
			for (var valueIndex:uint = 0; valueIndex < anticipatedStateCode.length; ++valueIndex) {
				var booleanCharValue:Boolean = toBoolean(anticipatedStateCode.charAt(valueIndex));
				states.push(!booleanCharValue);
			}
		}
		
		/**
		 * @param	expectedStateCode An upper case letter represents true, and a lower case represents false.
		 * @param	actualState Needs to be the same length as expectedStateCode.
		 */
		public function assertState(expectedStateCode:String):void {
			assert(expectedStateCode.length == states.length, "expectedStateCode needs to be the same length as anticipatedStateCode");
			for (var stateIndex:uint = 0; stateIndex < expectedStateCode.length; ++stateIndex)
				assertStateCharacter(expectedStateCode.charAt(stateIndex), states[stateIndex]);
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