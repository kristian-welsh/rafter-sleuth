package lib.test {
	import asunit.framework.Test;
	import asunit.framework.TestSuite;

	public class AssignedTestSuite {
		private var testClass:Class;
		private var suite:TestSuite;

		/**
		 * @param	testClass The class from which all of the tests will be executed.
		 */
		public function AssignedTestSuite(testClass:Class) {
			suite = new TestSuite();
			this.testClass = testClass;
		}

		/**
		 * Adds a test from the assigned TestCase class to the test suite.
		 * @param	methodName The name of the test method you want to add to the suite
		 */
		protected function addTest(methodName:String):void {
		// I would rather name this addTest but i can't overload or override TestSuite::addTest
			suite.addTest(new testClass(methodName));
		}

		public function getSuite():TestSuite {
			return suite;
		}
	}
}