package lib {
	import asunit.framework.TestSuite;

	public class ReflectionTestSuiteBuilder {
		private var objectInstance:Object;
		private var suite:TestSuite;

		public function ReflectionTestSuiteBuilder(objectInstance:Object) {
			suite = new TestSuite();
			this.objectInstance = objectInstance
		}

		public function addTest(method:Function):void {
			var functionName:String = Util.getFunctionName(method, objectInstance)
			var requiredTestClass:Class = Util.getClassOf(objectInstance)
			suite.addTest(new requiredTestClass(functionName))
		}

		public function getSuite():TestSuite {
			return suite;
		}
	}
}