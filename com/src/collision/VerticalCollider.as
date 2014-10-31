package src.collision {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import src.level.LevelManager;
	import src.player.IPlayerColider;

	public class VerticalCollider {
		static public const PLAYER_RADIUS:int = 45;
		static public const PLAYER_WIDTH:int = PLAYER_RADIUS * 2;
		static public const PLATFORM_WIDTH:Number = 100
		private var player:IPlayerColider;
		private var level:LevelManager;
		private var playerLanding:Boolean

		public function VerticalCollider(player:IPlayerColider, level:LevelManager) {
			this.level = level;
			this.player = player;
		}

		/**
		 * If the player's going to pass a platform on the next fall tick
		 * place the player on that platform and stop his fall.
		 * Assumes player's 0,0 is in the middle at the bottom.
		 */
		public function collide():void {
			playerLanding = false
			tryLandingEachPlatform()
			fallIfNotLanding()
		}

		private function tryLandingEachPlatform():void {
			for (var i:uint = 0; i < numPlatforms(); i++)
				if (canLandAt(i))
					landAt(i)
		}

		private function numPlatforms():uint {
			return level.view.horizontalPlatforms.numChildren
		}

		private function canLandAt(platformIndex:uint):Boolean {
			return wouldFallThrough(playerHitbox(), platformHitboxAt(platformIndex))
		}

		private function wouldFallThrough(player:Rectangle, platform:Rectangle):Boolean {
			return horizontalyAligned(player, platform) && abovePlatform(player, platform) && willLandNextFallTick(player, platform)
		}

		private function horizontalyAligned(player:Rectangle, platform:Rectangle):Boolean {
			return player.right > platform.left && player.left < platform.right
		}

		private function abovePlatform(player:Rectangle, platform:Rectangle):Boolean {
			return platform.top > player.bottom
		}

		private function willLandNextFallTick(player:Rectangle, platform:Rectangle):Boolean {
			return platform.top < player.bottom - playerJumpSpeed()
		}

		private function playerHitbox():Rectangle {
			return new Rectangle(playerX() - PLAYER_WIDTH / 2, playerY(), PLAYER_WIDTH, 0)
		}

		private function playerX():Number {
			return player.view.x
		}

		private function playerY():Number {
			return player.view.y
		}

		private function platformHitboxAt(platformIndex:uint):Rectangle {
			return platformHitbox(platformAt(platformIndex))
		}

		private function platformAt(i:uint):MovieClip {
			return level.view.horizontalPlatforms.getChildAt(i)
		}

		private function platformHitbox(platform:MovieClip):Rectangle {
			return new Rectangle(platformX(platform), platformY(platform), PLATFORM_WIDTH, PLATFORM_WIDTH)
		}

		private function platformX(platform:MovieClip):Number {
			return platformGlobalPos(platform).x
		}

		private function platformY(platform:MovieClip):Number {
			return platformGlobalPos(platform).y
		}

		private function platformGlobalPos(platform:MovieClip):Point {
			return platform.localToGlobal(new Point(0, 0))
		}

		private function playerJumpSpeed():Number {
			return player.jumpSpeed
		}

		private function landAt(i:uint):void {
			landPlayer(platformAt(i))
		}

		private function landPlayer(platform:MovieClip):void {
			positionPlayerAbove(platform)
			player.setGrounded(true)
			playerLanding = true
		}

		private function positionPlayerAbove(platform:MovieClip):void {
			level.view.y = player.view.y - level.view.horizontalPlatforms.y - platform.y + 1;
		}

		private function fallIfNotLanding():void {
			if (!playerLanding)
				player.fall();
		}
	}
}