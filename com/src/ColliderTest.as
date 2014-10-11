package src {
	import asunit.framework.TestCase;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import src.Collider;
	import src.level.FakeLevelView;
	import src.level.LevelManager;
	import src.level.LevelManagerSpy;
	import src.player.PlayerColiderSpy;
	import src.player.PlayerDataSpy;

	public class ColliderTest extends TestCase {
		private var player:PlayerColiderSpy;
		private var levelView:FakeLevelView;
		private var level:LevelManager;
		private var collider:Collider;

		public function ColliderTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new PlayerColiderSpy()
			levelView = new FakeLevelView()
			level = new LevelManager(levelView)
			collider = new Collider(player, level);
		}

		private function makeLevel():LevelManager {
			var view:FakeLevelView = new FakeLevelView()
			return new LevelManager(view)
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

		private function addObstacleAboutToTouchPlayer():void {
			var obstacle:MovieClip = createStandardSizeObstacle()
			obstacle.x = -Collider.PLAYER_RADIUS - obstacle.width + 1
			obstacle.y = -player.jumpSpeed - 1
			levelView.h_plats.addChild(obstacle)
		}

		private function createStandardSizeObstacle():MovieClip {
			var obstacle:MovieClip = new MovieClip()
			setMovieClipWidth(obstacle, 100)
			setMovieClipHeight(obstacle, 100)
			return obstacle
		}

		// You cannot set DisplayObject::width directly so use this workaround instead.
		private function setMovieClipWidth(movieClip:MovieClip, width:Number):void {
			movieClip.addChild(new Bitmap())
			movieClip.addChild(new Bitmap())
			movieClip.getChildAt(0).x = width
		}

		// You cannot set DisplayObject::height directly so use this workaround instead.
		private function setMovieClipHeight(movieClip:MovieClip, height:Number):void {
			movieClip.addChild(new Bitmap())
			movieClip.addChild(new Bitmap())
			movieClip.getChildAt(0).y = height
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