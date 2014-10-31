package src.collision {
	import src.level.LevelManager;
	import src.player.IPlayerColider;

	public class HorizontalCollider {
		static public const PLAYER_RADIUS:int = 45;
		private var player:IPlayerColider;
		private var level:LevelManager;

		// Assumptions:
		// player's 0,0 is in the middle at the bottom
		public function HorizontalCollider(player:IPlayerColider, level:LevelManager) {
			this.level = level;
			this.player = player;
		}

		// means the line is fully covered by tests: #
		/// Warning: both a command and a query
		public function collide():Boolean {
			var returnValue:Boolean;
			for (var i:uint = 0; i < level.view.edge_plats.numChildren; i++) {
				// player isn't entirely above wall
				if (player.view.y > level.view.edge_plats.getChildAt(i).y + level.view.edge_plats.y + level.view.y) {
					// player isn't entirely below wall
					if (player.view.y - player.view.height < level.view.edge_plats.getChildAt(i).y + level.view.edge_plats.y + level.view.y + 100) {
						// player is facing left
						if (player.isFacingLeft()) {
							// # player is entirely to the right of the wall (not buried)
							// # this might be implicit fron the fact that he's walking left?
							if (player.view.x - PLAYER_RADIUS > level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100) {
								// # player is about to walk into the wall
								if (player.view.x - PLAYER_RADIUS - player.walkSpeed < level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100) {
									// # hug the player to the wall
									// # Adjusts player instead of level, probably a bug
									player.view.x = level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x + 100 + PLAYER_RADIUS + 1;
									// # stop the player
									player.displayIdleLeft();
									// #
									returnValue = true;
									break;
								}
							}
						}
						// player is facing right
						if (player.isFacingRight()) {
							// player is entirely to the left of the wall
							// this might be implicit fron the fact that he's walking right?
							if (player.view.x + PLAYER_RADIUS < level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x) {
								// player is about to walk into the wall
								if (player.view.x + PLAYER_RADIUS + player.walkSpeed > level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x) {
									// hug the player to the wall
									player.view.x = level.view.edge_plats.getChildAt(i).x + level.view.edge_plats.x + level.view.x - PLAYER_RADIUS - 1;
									// stop the player
									player.displayIdleRight();
									returnValue = true;
									break;
								}
							}
						}
					}
				}
			}
			// # if there were no collisions
			if (i == level.view.edge_plats.numChildren) {
				// #
				returnValue = false;
			}
			// #
			return returnValue
		}
	}
}