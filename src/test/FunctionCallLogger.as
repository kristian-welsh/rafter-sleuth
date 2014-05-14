package test {
	import asunit.framework.Assert;
	
	public class FunctionCallLogger extends Assert {
		private var functionLog:Vector.<Function> = new Vector.<Function>();
		
		protected function log(functionCalled:Function):void {
			functionLog.push(functionCalled);
		}
		
		public function assertCalled(functionExpected:Function):void {
			if (!Util.listContainsItem(functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
		public function assertNotCalled(functionExpected:Function):void {
			if (Util.listContainsItem(functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
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