package lib {
	/**
	 * If condition evaluates to false, this function will throw an AssertionFailedError with the message set to message.
	 */
	public function assert(condition:Boolean, message:String = ""):void {
		if (!condition)
			throw new AssertionFailedError(message);
	}
}