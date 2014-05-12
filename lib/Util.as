package {
	import flash.utils.describeType;
	
	public class Util {
		/**
		 * Finds the source name of callee (ie: called on some function foo it would return "foo")
		 * This only works for public instance functions
		 * WARNING: REFLECTION
		 * @param	callee The public instance function you want to find the name of.
		 * @param	calleeOrigin The object (not class) that the function is defined on.
		 * @return	The name of callee.
		 * @throws	An Error with message "Method name not found for object "calleeOrigin"" if callee is not a public instance function on calleObject.
		 */
		static public function getFunctionName(callee:Function, calleeOrigin:Object):String {
			for each (var method:XML in describeType(calleeOrigin)..method)
				if (calleeOrigin[method.@name] == callee)
					return method.@name;
			throw new Error("Method name not found for object \"" + calleeOrigin + "\"");
		}
		
		/**
		 * Returns whether list contains itemToFind in one of it's indexes.
		 * @param	list A formaly defined list (eg: Array, Vector).
		 * @param	itemToFind A valid item for the list.
		 * @return	True if itemToFind is in list, otherwise false.
		 */
		static public function listContainsItem(list:Object, itemToFind:Object):Boolean {
			for each(var foundItem:Object in list)
				if (foundItem == itemToFind)
					return true;
			return false;
		}
	}
}