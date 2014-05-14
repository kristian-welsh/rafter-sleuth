package test {
	import asunit.framework.Assert;
	
	public class FunctionCallLogger extends Assert {
<<<<<<< HEAD
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
		
=======
		private var _functionLog:Vector.<Function> = new Vector.<Function>();
		
		protected function log(functionCalled:Function):void {
			_functionLog.push(functionCalled);
		}
		
		public function assertCalled(functionExpected:Function):void {
			if (!Util.listContainsItem(_functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
>>>>>>> 39b40a4e84924fe4b7559bba501856a3baee8db1
		private function failNotCalled(functionExpected:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(functionExpected, this);
			fail("Expected function \"" + expectedFunctionName + "\" to have been called, but it was not.");
		}
<<<<<<< HEAD
		
		private function failCalled(functionExpected:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(functionExpected, this);
			fail("Expected function \"" + expectedFunctionName + "\" to not have been called, but it was.");
		}
		
		private function failAnyFunctionCalled():void {
			fail("Expected no function to have been called, but a funciton was called.");
		}
=======
>>>>>>> 39b40a4e84924fe4b7559bba501856a3baee8db1
	}
}