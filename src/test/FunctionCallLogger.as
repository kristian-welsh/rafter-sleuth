package test {
	import asunit.framework.Assert;
	
	public class FunctionCallLogger extends Assert {
		private var _functionLog:Vector.<Function> = new Vector.<Function>();
		
		protected function log(functionCalled:Function):void {
			_functionLog.push(functionCalled);
		}
		
		public function assertCalled(functionExpected:Function):void {
			if (!Util.listContainsItem(_functionLog, functionExpected))
				failNotCalled(functionExpected);
		}
		
		private function failNotCalled(functionExpected:Function):void {
			var expectedFunctionName:String = Util.getFunctionName(functionExpected, this);
			fail("Expected function \"" + expectedFunctionName + "\" to have been called, but it was not.");
		}
	}
}