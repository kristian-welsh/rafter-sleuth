package src {
	import asunit.framework.*;
	import lib.test.*;
	import src.HorizontalCollider;
	import src.level.*;
	import src.player.PlayerColiderSpy;

	public class HorizontalColliderTest extends TestCase implements SuiteProvider {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:HorizontalCollider;

		private var collisionResult:Boolean;

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTests([
				no_platforms])
			return testSuite.getSuite()
		}

		public function HorizontalColliderTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new PlayerColiderSpy()
			levelView = new FakeLevelView()
			level = new LevelManager(levelView)
			collider = new HorizontalCollider(player, level);
		}

		public function no_platforms():void {
			collide();
			assertNoCollision();
		}

		private function collide():void {
			collisionResult = collider.collide()
		}

		private function assertNoCollision():void {
			assertFalse(collisionResult)
		}
	}
}