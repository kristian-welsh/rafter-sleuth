package lib {
	public class StringUtil {
		static public function isUppercase(string:String):Boolean {
			return string == string.toUpperCase();
		}
		
		static public function isLowercase(string:String):Boolean {
			return string == string.toLowerCase();
		}
	}
}