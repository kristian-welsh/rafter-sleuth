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
		 * Adds a function call to the log.
		 * @param	functionCalled A referance to the function that has been called.
		 * @param	args An order dependant list of arguments that were passed to the function.
		 */
		public function log(functionCalled:Function, args:Array = null):void {
			functionLog.push(functionCalled);
			argumentLog.push(args);
		}

		/**
		 * Asserts that the funciton has been logged as expected.
		 */
		public function assertLogged(expectedFunction:Function, expectedArguments:Array = null):void {
			if (expectedArguments == null)
				assertLoggedWithoutArguments(expectedFunction);
			else
				assertLoggedWithArguments(expectedFunction, expectedArguments);
		}

		private function assertLoggedWithoutArguments(expectedFunction:Function):void {
			if (!Util.listContainsItem(functionLog, expectedFunction))
				failNotLogged(expectedFunction);
		}

		private function assertLoggedWithArguments(expectedFunction:Function, expectedArguments:Array):void {
			assertLoggedWithoutArguments(expectedFunction);
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
		public function assertNotLogged(unexpectedFunction:Function, unexpectedArguments:Array = null):void {
			if (unexpectedArguments == null)
				assertNotLoggedWithoutArguments(unexpectedFunction);
			else
				assertNotLoggedWithArguments(unexpectedFunction, unexpectedArguments);
		}

		private function assertNotLoggedWithoutArguments(unexpectedFunction:Function):void {
			if (Util.listContainsItem(functionLog, unexpectedFunction))
				failLogged(unexpectedFunction);
		}

		private function assertNotLoggedWithArguments(unexpectedFunction:Function, unexpectedArguments:Array):void {
			assertNotLoggedWithoutArguments(unexpectedFunction);
			for (var functionIndex:uint = 0; functionIndex < functionLog.length; ++functionIndex) {
				if (functionLog[functionIndex] == unexpectedFunction) {
					if (argsMatch(argumentLog[functionIndex], unexpectedArguments))
						fail("An unallowed function argument pair was found in the logs")
				}
			}
		}

		/**
		 * Asserts that no funciton has been logged.
		 */
		public function assertNoLogs():void {

			if (functionLog.length != 0)
				failAnyFunctionLogged();
		}

		private function failNotLogged(expectedFunction:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(expectedFunction, target); // possibly breaks if not logged from a subclass
			fail("Expected function \"" + expectedFunctionName + "\" to have been called, but it was not.");
		}

		private function failLogged(expectedFunction:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(expectedFunction, target);
			fail("Expected function \"" + expectedFunctionName + "\" to not have been called, but it was.");
		}

		private function failAnyFunctionLogged():void {
			fail("Expected no function to have been called, but a funciton was called.");
		}
	}
}