package lib.test {
	import asunit.framework.TestSuite;

	// Meant mainly for test cases that supply their own test suite.
	public interface SuiteProvider{
		function getSuite():TestSuite
	}
}