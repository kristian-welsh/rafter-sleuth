package lib.test {
	import asunit.framework.Assert;
	import lib.Util;
	
	public class Spy extends Assert {
		private var target:Object;
		private var functionLog:Vector.<Function> = new Vector.<Function>();
		private var argumentLog:Vector.<Array> = new Vector.<Array>();
		
		/**
		 * Log function calls, then assert on whether a function was called or not.
		 */
		public function Spy(target:Object) {
			this.target = target;
			super();
		}
		
		/**
		 * @param	functionCalled A referance to the function that has been called.
		 * @param	args Order dependant list of srguments passed to the function
		 */
		public function log(functionCalled:Function, args:Array = null):void {
			functionLog.push(functionCalled);
			argumentLog.push(args);
		}
		
		/**
		 * Asserts that the funciton has been logged.
		 */
		public function assertCalled(expectedFunction:Function):void {
			if (!Util.listContainsItem(functionLog, expectedFunction))
				failNotCalled(expectedFunction);
		}
		
		/**
		 * Asserts that the funciton has been logged with the expected arguments.
		 */
		public function assertCalledWithArguments(expectedFunction:Function, expectedArguments:Array):void {
			assertCalled(expectedFunction);
			for (var functionIndex:uint = 0; functionIndex < functionLog.length; ++functionIndex) {
				if (expectedFunction == functionLog[functionIndex]) {
					if (argsMatch(argumentLog[functionIndex], expectedArguments))
						return;
				}
			}
			fail("function matched, but with incorrect arguments");
		}
		
		private function argsMatch(loggedArguments:Array, expectedArguments:Array):Boolean {
			for (var argumentIndex:uint = 0; argumentIndex < loggedArguments.length; ++argumentIndex) {
				if (expectedArguments[argumentIndex] == loggedArguments[argumentIndex]) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Asserts that the funciton has not been logged.
		 */
		public function assertNotCalled(expectedFunction:Function):void {
			if (Util.listContainsItem(functionLog, expectedFunction))
				failNotCalled(expectedFunction);
		}
		
		/**
		 * Asserts that no funciton has been logged.
		 */
		public function assertNotUsed():void {
			if (functionLog.length != 0)
				failAnyFunctionCalled();
		}
		
		private function failNotCalled(expectedFunction:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(expectedFunction, target); // possibly breaks if not logged from a subclass
			fail("Expected function \"" + expectedFunctionName + "\" to have been called, but it was not.");
		}
		
		private function failCalled(expectedFunction:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(expectedFunction, target);
			fail("Expected function \"" + expectedFunctionName + "\" to not have been called, but it was.");
		}
		
		private function failAnyFunctionCalled():void {
			fail("Expected no function to have been called, but a funciton was called.");
		}
	}
}