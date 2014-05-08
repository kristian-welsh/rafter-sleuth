package test {
	import asunit.framework.TestSuite;
	import keyboard.KeyboardControlsTest;
	
	public class AllTests extends TestSuite {
		public function AllTests() {
			addTest(new KeyboardControlsTest("initial_values_are_correct"));
		}
	}
}