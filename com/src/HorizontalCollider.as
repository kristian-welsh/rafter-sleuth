package src {
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

		/// Warning: both a command and a query
		public function collide():Boolean {
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