package lib.test {
	import asunit.framework.Assert;
	import lib.StringUtil;

	// TODO: ensure statecode is composed of uppercase or lowercase letters
	public class BooleanStringCode {
		private var state:Object = new Object()

		public function setValueKey(value:Boolean, key:String):void {
			state[key.toLowerCase()] = value;
		}

		/**
		 * Sets state to a state that would fail every test if assertState is called directly after it.
		 * @param	expectedState An upper case letter represents true, and a lower case represents false.
		 */
		public function prepareAssertState(stateCode:String):void {
			forEachChar(stateCode, function(char:String):void {
				state[char.toLowerCase()] = !toBoolean(char);
			});
		}

		/**
		 * @param	func function to execute must accept a string as a parameter
		 */
		private function forEachChar(string:String, func:Function):void {
			for (var charIndex:uint = 0; charIndex < string.length; ++charIndex)
				func(string.charAt(charIndex));
		}

		private function toBoolean(letter:String):Boolean {
			return StringUtil.isUppercase(letter);
		}

		/**
		 * @param	expectedStateCode An upper case letter represents true, and a lower case represents false.
		 * @param	actualState Needs to be the same length as expectedStateCode.
		 */
		public function assertState(stateCode:String):void {
			forEachChar(stateCode, function(char:String):void {
				assertStateCharacter(char, state[char.toLowerCase()]);
			});
		}

		private function assertStateCharacter(codeLetter:String, val:Boolean):void {
			Assert.assertEquals(toBoolean(codeLetter), val);
		}
	}
}