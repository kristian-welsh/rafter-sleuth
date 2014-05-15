package test {
	import asunit.framework.Assert;
	
	public class Spy extends Assert {
		private var functionLog:Vector.<Function> = new Vector.<Function>();
		
		/**
		 * Log function calls, then assert on whether a function was called or not.
		 */
		public function Spy() {
			super();
		}
		
		/**
		 * @param	functionCalled A referance to the function that has been called.
		 */
		public function log(functionCalled:Function):void {
			functionLog.push(functionCalled);
		}
		
		/**
		 * Asserts that the funciton has been logged.
		 */
		public function assertCalled(functionExpected:Function):void {
			if (!Util.listContainsItem(functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
		/**
		 * Asserts that the funciton has not been logged.
		 */
		public function assertNotCalled(functionExpected:Function):void {
			if (Util.listContainsItem(functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
		/**
		 * Asserts that no funciton has been logged.
		 */
		public function assertNotUsed():void {
			if (functionLog.length != 0)
				failAnyFunctionCalled();
		}
		
		private function failNotCalled(functionExpected:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(functionExpected, this);
			fail("Expected function \"" + expectedFunctionName + "\" to have been called, but it was not.");
		}
		
		private function failCalled(functionExpected:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(functionExpected, this);
			fail("Expected function \"" + expectedFunctionName + "\" to not have been called, but it was.");
		}
		
		private function failAnyFunctionCalled():void {
			fail("Expected no function to have been called, but a funciton was called.");
		}
	}
}