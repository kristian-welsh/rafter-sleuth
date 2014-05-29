package lib.test {
	import asunit.framework.Test;
	import asunit.framework.TestSuite;

	public class AssignedTestSuite extends TestSuite {
		private var testClass:Class;
		
		/**
		 * @param	testClass The class from which all of the tests will be executed.
		 */
		public function AssignedTestSuite(testClass:Class) {
			this.testClass = testClass;
		}
		
		/**
		 * Adds a test from the assigned TestCase class to the test suite.
		 * @param	methodName The name of the test method you want to add to the suite
		 */
		protected function test(methodName:String):void {
		// I would rather name this addTest but i can't overload or override TestSuite::addTest
			addTest(new testClass(methodName));
		}
	}
}