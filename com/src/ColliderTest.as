package src {
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	import flash.display.MovieClip;
	import lib.ReflectionTestSuiteBuilder;
	import lib.test.SuiteProvider;
	import lib.Util;
	import src.Collider;
	import src.level.FakeLevelView;
	import src.level.LevelManager;
	import src.player.PlayerColiderSpy;

	public class ColliderTest extends TestCase implements SuiteProvider {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:Collider;
		private const platformWidth:Number = 100

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTests([
				collideV_no_platforms,
				collideV_platform_about_to_touch_player,
				collideV_miss_too_far_left,
				collideV_scrape_too_far_left,
				collideV_miss_too_far_right,
				collideV_scrape_too_far_right,
				collideV_player_too_far_away_verticaly,
				collideV_platform_just_above_player])
			return testSuite.getSuite()
		}

		// scrape means they fall with the entities sides touching (eg player right side == platform left side)
		// a happy case and sad case for each boolean condition
		public function ColliderTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new PlayerColiderSpy()
			levelView = new FakeLevelView()
			level = new LevelManager(levelView)
			collider = new Collider(player, level);
		}

		public function collideV_no_platforms():void {
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_platform_about_to_touch_player():void {
			addPlatformAboutToTouchPlayer()
			collider.collideV()
			assertEquals(-8, levelView.y)
			assertCollision()
		}

		public function collideV_miss_too_far_left():void {
			addPlatformAboutToPassPlayersRightSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_scrape_too_far_left():void {
			addPlatformAboutToScrapePlayersRightSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_miss_too_far_right():void {
			addPlatformAboutToPassPlayersLeftSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_scrape_too_far_right():void {
			addPlatformAboutToScrapePlayersLeftSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_player_too_far_away_verticaly():void {
			addPlatformFarBelowPlayer()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_platform_just_above_player():void {
			addPlatformJustAbovePlayer()
			collider.collideV()
			assertNoCollision()
		}

		private function addPlatformAboutToScrapePlayersLeftSide():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth)
		}

		private function addPlatformAboutToPassPlayersLeftSide():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth - 1)
		}

		private function addPlatformAboutToPassPlayersRightSide():void {
			createCatchingPlatformAtX(Collider.PLAYER_RADIUS + 1)
		}

		private function addPlatformAboutToScrapePlayersRightSide():void {
			createCatchingPlatformAtX(Collider.PLAYER_RADIUS)
		}

		private function addPlatformAboutToTouchPlayer():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth + 5)
		}

		private function createCatchingPlatformAtX(x:Number):void {
			addPlatformAt(x, justUnderPlayer())
		}

		private function addPlatformFarBelowPlayer():void {
			const xThatWouldCatchPlayer:Number = -Collider.PLAYER_RADIUS - platformWidth + 5
			const yThatWouldNotCatchPlayer:Number = -player.jumpSpeed * 5
			addPlatformAt(xThatWouldCatchPlayer, yThatWouldNotCatchPlayer)
		}

		private function addPlatformJustAbovePlayer():void {
			const xThatWouldCatchPlayer:Number = -Collider.PLAYER_RADIUS - platformWidth + 5
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