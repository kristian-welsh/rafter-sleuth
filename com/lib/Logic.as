package lib {

	public class Logic {
		public static function XOR(a:Boolean, b:Boolean):Boolean {
			return (!a && b) || (a && !b)
		}

		public static function XNOR(a:Boolean, b:Boolean):Boolean {
			return (!a && !b) || (a && b)
		}
	}
}