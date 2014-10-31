package src.collision {
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	import flash.display.MovieClip;
	import lib.test.ReflectionTestSuiteBuilder;
	import lib.test.SuiteProvider;
	import lib.Util;
	import src.collision.VerticalCollider;
	import src.level.FakeLevelView;
	import src.level.LevelManager;
	import src.player.PlayerColiderSpy;

	public class VerticalColliderTest extends TestCase implements SuiteProvider {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:VerticalCollider;
		private const platformWidth:Number = 100

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTests([
				no_platforms,
				platform_about_to_touch_player,
				miss_too_far_left,
				scrape_too_far_left,
				miss_too_far_right,
				scrape_too_far_right,
				player_too_far_away_verticaly,
				platform_just_above_player])
			return testSuite.getSuite()
		}

		// scrape means they fall with the entities sides touching (eg player right side == platform left side)
		// a happy case and sad case for each boolean condition
		public function VerticalColliderTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new PlayerColiderSpy()
			levelView = new FakeLevelView()
			level = new LevelManager(levelView)
			collider = new VerticalCollider(player, level);
		}

		public function no_platforms():void {
			collider.collide()
			assertNoCollision()
		}

		public function platform_about_to_touch_player():void {
			addPlatformAboutToTouchPlayer()
			collider.collide()
			assertEquals(-8, levelView.y)
			assertCollision()
		}

		public function miss_too_far_left():void {
			addPlatformAboutToPassPlayersRightSide()
			collider.collide()
			assertNoCollision()
		}

		public function scrape_too_far_left():void {
			addPlatformAboutToScrapePlayersRightSide()
			collider.collide()
			assertNoCollision()
		}

		public function miss_too_far_right():void {
			addPlatformAboutToPassPlayersLeftSide()
			collider.collide()
			assertNoCollision()
		}

		public function scrape_too_far_right():void {
			addPlatformAboutToScrapePlayersLeftSide()
			collider.collide()
			assertNoCollision()
		}

		public function player_too_far_away_verticaly():void {
			addPlatformFarBelowPlayer()
			collider.collide()
			assertNoCollision()
		}

		public function platform_just_above_player():void {
			addPlatformJustAbovePlayer()
			collider.collide()
			assertNoCollision()
		}

		private function addPlatformAboutToScrapePlayersLeftSide():void {
			createCatchingPlatformAtX(-VerticalCollider.PLAYER_RADIUS - platformWidth)
		}

		private function addPlatformAboutToPassPlayersLeftSide():void {
			createCatchingPlatformAtX(-VerticalCollider.PLAYER_RADIUS - platformWidth - 1)
		}

		private function addPlatformAboutToPassPlayersRightSide():void {
			createCatchingPlatformAtX(VerticalCollider.PLAYER_RADIUS + 1)
		}

		private function addPlatformAboutToScrapePlayersRightSide():void {
			createCatchingPlatformAtX(VerticalCollider.PLAYER_RADIUS)
		}

		private function addPlatformAboutToTouchPlayer():void {
			createCatchingPlatformAtX(-VerticalCollider.PLAYER_RADIUS - platformWidth + 5)
		}

		private function createCatchingPlatformAtX(x:Number):void {
			addPlatformAt(x, justUnderPlayer())
		}

		private function addPlatformFarBelowPlayer():void {
			const xThatWouldCatchPlayer:Number = -VerticalCollider.PLAYER_RADIUS - platformWidth + 5
			const yThatWouldNotCatchPlayer:Number = -player.jumpSpeed * 5
			addPlatformAt(xThatWouldCatchPlayer, yThatWouldNotCatchPlayer)
		}

		private function addPlatformJustAbovePlayer():void {
			const xThatWouldCatchPlayer:Number = -VerticalCollider.PLAYER_RADIUS - platformWidth + 5
			const yThatWouldNotCatchPlayer:Number = player.view.y - 1
			addPlatformAt(xThatWouldCatchPlayer, yThatWouldNotCatchPlayer)
		}

		private function addPlatformAt(x:Number, y:Number):void {
			var platform:MovieClip = createStandardSizePlatform()
			setCollisionPlatform(platform)
			platform.y = y
			platform.x = x
		}

		private function createStandardSizePlatform():MovieClip {
			var obstacle:MovieClip = new MovieClip()
			Util.setMovieClipWidth(obstacle, platformWidth)
			Util.setMovieClipHeight(obstacle, 100)
			return obstacle
		}

		private function setCollisionPlatform(platform:MovieClip):void {
			levelView.horizontalPlatforms.addChild(platform)
		}

		private function justUnderPlayer():Number {
			return -player.jumpSpeed - 1
		}

		private function assertCollision():void {
			player.getSpy().assertNotLogged(player.fall)
			player.getSpy().assertLogged(player.setGrounded, [true])
		}

		private function assertNoCollision():void {
			player.getSpy().assertLogged(player.fall)
			player.getSpy().assertNotLogged(player.setGrounded)
		}
	}
}