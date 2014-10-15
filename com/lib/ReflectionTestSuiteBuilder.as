package lib {
	import asunit.framework.TestSuite;

	public class ReflectionTestSuiteBuilder {
		private var objectInstance:Object;
		private var suite:TestSuite;

		public function ReflectionTestSuiteBuilder(objectInstance:Object) {
			suite = new TestSuite();
			this.objectInstance = objectInstance
		}

		private function addTest(method:Function):void {
			var functionName:String = Util.getFunctionName(method, objectInstance)
			var requiredTestClass:Class = Util.getClassOf(objectInstance)
			suite.addTest(new requiredTestClass(functionName))
		}

		public function addTests(tests:Array):void {
			tests.map(function(element:*, ... restMapParams):void {
				assert(element is Function)
			})
			for each (var test:Object in tests)
				addTest(test as Function)
		}

		public function getSuite():TestSuite {
			return suite;
		}
	}
}