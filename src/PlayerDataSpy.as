package  {
	import test.Spy;

	public class PlayerDataSpy implements PlayerData {
		private var _spy:Spy = new Spy(this);
		
		public function getSpy():Spy {
			return _spy;
		}
		
		public function set canMove(value:Boolean):void {
			_spy.log(setCanMove, [value]);
		}
		
		public function set canJump(value:Boolean):void {
			_spy.log(setCanJump, [value]);
		}
		
		public function set canAttack(value:Boolean):void {
			_spy.log(setCanAttack, [value]);
		}
		
		// these functions exist so i can log the use of the set functions.
		// in future change set functions to normal setters
		public function setCanMove():void {
			
		}
		
		public function setCanJump():void {
			
		}
		
		public function setCanAttack():void {
			
		}
	}
}