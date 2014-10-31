package src.collision {
	import asunit.framework.*;
	import flash.display.MovieClip;
	import lib.test.*;
	import lib.Util;
	import src.collision.HorizontalCollider;
	import src.level.*;
	import src.player.PlayerColiderSpy;

	/*
	 * TODO: Think about this: Instead of positioning a platform to collide with the player
	 * i should put the platform at 0,0 and position the player to collide with it.
	 * Whichever is more understandable.
	 */
	public class HorizontalColliderTest extends TestCase implements SuiteProvider {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:HorizontalCollider;

		private var collisionResult:Boolean;
		private const wallWidth:Number = 100

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTests([
				no_platforms,
				left_hard_collide,
				left_soft_collide,
				left_no_collide,
				left_nearly_buried,
				left_slightly_buried,
				left_very_buried])
			return testSuite.getSuite()
		}

		/*
		 * Vocabulary:
		 * hard collide: player will be stuck in the wall
		 * soft collide: player will be just touching the wall
		 * no collide: player won't be touching the wall
		 * buried collide: player started inside wall (should never happen)
		 *
		 * Quick note on nested conditional testing:
		 * When exercising one condition the rest of the conditions
		 * will be set to success states so that we can sense
		 * the success of the condition under test.
		 */
		public function HorizontalColliderTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new PlayerColiderSpy()
			levelView = new FakeLevelView()
			level = new LevelManager(levelView)
			collider = new HorizontalCollider(player, level);
		}

		private function collideWithWallAt(x:Number, y:Number):void {
			addWallAt(x, y)
			collide()
		}

		private function collide():void {
			collisionResult = collider.collide()
		}

		// Warning: mostly dupllicated in VerticalColliderTest
		private function addWallAt(x:Number, y:Number):void {
			var wall:MovieClip = createStandardSizeWall()
			setCollisionWall(wall)
			wall.y = y
			wall.x = x
		}

		// Warning: mostly dupllicated in VerticalColliderTest
		private function createStandardSizeWall():MovieClip {
			var wall:MovieClip = new MovieClip()
			Util.setMovieClipWidth(wall, wallWidth)
			Util.setMovieClipHeight(wall, 100)
			return wall
		}

		// Warning: mostly dupllicated in VerticalColliderTest
		private function setCollisionWall(wall:MovieClip):void {
			levelView.edge_plats.addChild(wall)
		}

		public function no_platforms():void {
			collide();
			assertNoCollision();
		}

		public function left_hard_collide():void {
			player.faceLeft()
			collideWithWallAt(-154, -50)
			assertCollisionResolvedTo(-8)
		}

		public function left_soft_collide():void {
			player.faceLeft()
			collideWithWallAt(-155, -50)
			assertNoCollision()
		}

		public function left_no_collide():void {
			player.faceLeft()
			collideWithWallAt(-156, -50)
			assertNoCollision()
		}

		public function left_nearly_buried():void {
			player.faceLeft()
			collideWithWallAt(-146, -50)
			assertCollisionResolvedTo(0)
		}

		// TODO: This seems like a bug, intuitively if the polayer's buried, we want to dig him out.
		public function left_slightly_buried():void {
			player.faceLeft()
			collideWithWallAt(-145, -50)
			assertNoCollision()
		}

		// TODO: This seems like a bug, intuitively if the polayer's buried, we want to dig him out.
		public function left_very_buried():void {
			player.faceLeft()
			collideWithWallAt(-144, -50)
			assertNoCollision()
		}

		private function assertCollisionResolvedTo(newPlayerX:Number):void {
			assertTrue(collisionResult)
			assertPlayerX(newPlayerX)
			assertPlayerIdle()
		}

		private function assertNoCollision():void {
			assertFalse(collisionResult)
			assertPlayerX(0)
			assertPlayerNotIdle();
		}

		private function assertPlayerX(expected:Number):void {
			assertEquals(expected, player.view.x)
		}

		private function assertPlayerIdle():void {
			if (player.isFacingLeft())
				player.getSpy().assertLogged(player.displayIdleLeft)
			else if (player.isFacingRight())
				player.getSpy().assertLogged(player.displayIdleRight)
			else
				throw new Error("Unexpected case")
		}

		private function assertPlayerNotIdle():void {
			player.getSpy().assertNotLogged(player.displayIdleLeft)
			player.getSpy().assertNotLogged(player.displayIdleRight)
		}
	}
}