package src {
	import flash.display.MovieClip;
	import src.level.LevelManager;
	import src.player.IPlayerColider;
	import src.player.PlayerManager;
	public class Collider {
		static public const PLAYER_RADIUS:int = 45;
		private var player:IPlayerColider;
		private var level:LevelManager;

		// Vocabulary: h_plats means horizontal platforms
		// player's 0,0 is in the middle at the bottom
		// platform cube's 0,0 is at the top-left corner
		public function Collider(player:IPlayerColider, level:LevelManager) {
			this.level = level;
			this.player = player;
		}

		public function collideV():void {
			for (var i:uint = 0; i < level.view.h_plats.numChildren; i++) {
				if (collideVPlatform(i))
					break
			}
			if (i == level.view.h_plats.numChildren)
				player.fall();
		}

		/**
		 * @return true if collision occured, otherwise false
		 */
		private function collideVPlatform(i:uint):Boolean {
			const platform:MovieClip = level.view.h_plats.getChildAt(i)
			const platformX:Number = platform.x + level.view.h_plats.x + level.view.x
			const platformY:Number = platform.y + level.view.h_plats.y + level.view.y
			const platformWidth:Number = 100

			const playerX:Number = player.view.x
			const playerY:Number = player.view.y

			const playersLeftSide:Number = playerX - PLAYER_RADIUS
			const playersRightSide:Number = playerX + PLAYER_RADIUS
			const playersBottomSide:Number = playerY

			const platformRightSide:Number = platformX + platformWidth
			const platformLeftSide:Number = platformX
			const platformTopSide:Number = platformY

			const horizontalyAligned:Boolean = playersRightSide > platformLeftSide && playersLeftSide < platformRightSide
			const abovePlatform:Boolean = platformTopSide > playersBottomSide
			const willCollideNextFallTick:Boolean = platformTopSide < playersBottomSide - player.jumpSpeed

			if (horizontalyAligned) {
				if (abovePlatform && willCollideNextFallTick) {
					// player.jumpSpeed needs to be negative (player is falling) for both to be true
					resolveCollision(platform)
					player.setGrounded(true)
					return true
				}
			}
			return false
		}

		private function resolveCollision(platform:MovieClip):void {
			level.view.y = player.view.y - level.view.h_plats.y - platform.y + 1;
		}

		/// Warning: both a command and a query
		public function collideH():Boolean {
			var returnValue:Boolean;
			for (var i:uint = 0; i < level.view.edge_plats.numChildren; i++) {
				if (player.view.y > level.view.edge_plats.getChildAt(i).y + level.view.edge_plats.y + level.view.y) {
					if (player.view.y - player.view.height < level.view.edge_plats.getChildAt(i).y + level.view.edge_plats.y + level.view.y + 100) {
						if (player.isFacingLeft()) {
							if (player.view.x - PLAYER_RADIUS > level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100) {
								if (player.view.x - PLAYER_RADIUS - player.walkSpeed < level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100) {
									player.view.x = level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100 + PLAYER_RADIUS + 1;
									returnValue = true;
									player.displayIdleLeft();
									break;
								}
							}
						}
						if (player.isFacingRight()) {
							if (player.view.x + PLAYER_RADIUS < level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x) {
								if (player.view.x + PLAYER_RADIUS + player.walkSpeed > level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x) {
									player.view.x = level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x - PLAYER_RADIUS - 1;
									returnValue = true;
									player.displayIdleRight();
									break;
								}
							}
						}
					}
				}
			}
			if (i == level.view.edge_plats.numChildren) {
				returnValue = false;
			}
			return returnValue
		}
	}
}