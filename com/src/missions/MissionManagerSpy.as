package src.missions {
	import lib.test.Spy;

	public class MissionManagerSpy implements IMissionManager {
		private var spy:Spy = new Spy(this);
		
		public function checkForText():void {
			spy.log(checkForText);
		}
		
		public function getSpy():Spy {
			return spy;
		}
	}
}