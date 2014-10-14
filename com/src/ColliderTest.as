package src {
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import lib.Util;
	import src.Collider;
	import src.level.FakeLevelView;
	import src.level.LevelManager;
	import src.player.PlayerColiderSpy;

	public class ColliderTest extends TestCase {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:Collider;
		private const platformWidth:Number = 100

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
			addObstacleAboutToTouchPlayer()
			collider.collideV()
			assertEquals(-8, levelView.y)
			assertCollision()
		}

		public function collideV_miss_too_far_left():void {
			addObstacleAboutToPassPlayersRightSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_scrape_too_far_left():void {
			addObstacleAboutToScrapePlayersRightSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_miss_too_far_right():void {
			addObstacleAboutToPassPlayersLeftSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_scrape_too_far_right():void {
			addObstacleAboutToScrapePlayersLeftSide()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_player_too_far_away_verticaly():void {
			addObstacleFarBelowPlayer()
			collider.collideV()
			assertNoCollision()
		}

		public function collideV_platform_just_above_player():void {
			addObstacleJustAbovePlayer()
			collider.collideV()
			assertNoCollision()
		}

		private function addObstacleAboutToScrapePlayersLeftSide():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth)
		}

		private function addObstacleAboutToPassPlayersLeftSide():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth - 1)
		}

		private function addObstacleAboutToPassPlayersRightSide():void {
			createCatchingPlatformAtX(Collider.PLAYER_RADIUS + 1)
		}

		private function addObstacleAboutToScrapePlayersRightSide():void {
			createCatchingPlatformAtX(Collider.PLAYER_RADIUS)
		}

		private function addObstacleAboutToTouchPlayer():void {
			createCatchingPlatformAtX(-Collider.PLAYER_RADIUS - platformWidth + 5)
		}

		private function createCatchingPlatformAtX(x:Number):void {
			addPlatformAt(x, justUnderPlayer())
		}

		private function addObstacleFarBelowPlayer():void {
			const xThatWouldCatchPlayer:Number = -Collider.PLAYER_RADIUS - platformWidth + 5
			const yThatWouldNotCatchPlayer:Number = -player.jumpSpeed * 5
			addPlatformAt(xThatWouldCatchPlayer, yThatWouldNotCatchPlayer)
		}

		private function addObstacleJustAbovePlayer():void {
			const xThatWouldCatchPlayer:Number = -Collider.PLAYER_RADIUS - platformWidth + 5
			const yThatWouldNotCatchPlayer:Number = player.view.y - 1
			addPlatformAt(xThatWouldCatchPlayer, yThatWouldNotCatchPlayer)
		}

		private function addPlatformAt(x:Number, y:Number):void {
			var platform:MovieClip = createStandardSizeObstacle()
			setCollisionPlatform(platform)
			platform.y = y
			platform.x = x
		}

		private function createStandardSizeObstacle():MovieClip {
			var obstacle:MovieClip = new MovieClip()
			Util.setMovieClipWidth(obstacle, platformWidth)
			Util.setMovieClipHeight(obstacle, 100)
			return obstacle
		}

		private function setCollisionPlatform(platform:MovieClip):void {
			levelView.h_plats.addChild(platform)
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