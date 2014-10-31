package lib {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Util {
		/**
		 * Finds the source name of callee (ie: called on some function foo it would return "foo")
		 * This only works for public instance functions.
		 * WARNING: REFLECTION
		 * @param	callee The public instance function you want to find the name of.
		 * @param	calleeOrigin The specific instance (not class) that the function was taken from.
		 * @return	The name of callee.
		 * @throws	An Error with message "Method name not found for object "calleeOrigin"" if callee is not a public instance function on calleObject.
		 */
		static public function getFunctionName(callee:Function, calleeOrigin:Object):String {
			for each (var method:XML in describeType(calleeOrigin)..method)
				if (calleeOrigin[method.@name] == callee)
					return method.@name;
			throw new Error("Method name not found for object \"" + calleeOrigin + "\". Either the function is not defined, or you gave us the wrong instance");
		}

		/**
		 * Finds which class the object you passed in is an instance of.
		 * @param	instance An instance of the class you want to find.
		 * @return	Class of the object passed in
		 */
		static public function getClassOf(instance:Object):Class {
			var fullyQualifiedClassName:String = getQualifiedClassName(instance)
			var classHierarchyDefinition:Object = getDefinitionByName(fullyQualifiedClassName)
			return classHierarchyDefinition as Class
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

		/**
		 * Removes a displayObject from it's parent via removeChild.
		 */
		static public function orphanDisplayObject(displayObject:DisplayObject):void {
			if (displayObject.parent)
				displayObject.parent.removeChild(displayObject);
		}

		/**
		 * Warning: Works by adding children, may be unsuitable in some situations.
		 */
		static public function setMovieClipWidth(movieClip:MovieClip, width:Number):void {
			movieClip.addChild(new Bitmap())
			movieClip.addChild(new Bitmap())
			movieClip.getChildAt(0).x = width
		}

		/**
		 * Warning: Works by adding children, may be unsuitable in some situations.
		 */
		static public function setMovieClipHeight(movieClip:MovieClip, height:Number):void {
			movieClip.addChild(new Bitmap())
			movieClip.addChild(new Bitmap())
			movieClip.getChildAt(0).y = height
		}
	}
}