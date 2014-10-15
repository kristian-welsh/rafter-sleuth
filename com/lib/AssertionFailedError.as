package lib {
	public class AssertionFailedError extends Error {
        public function AssertionFailedError(message:String = "") {
            super(message);
            name = "AssertionFailedError";
        }
	}
}