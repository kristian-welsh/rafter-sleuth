package src {
	import src.level.LevelManager;
	import src.player.PlayerManager;
	public class Collider {
		static private const PLAYER_RADIUS:int = 45;
		private var player:PlayerManager;
		private var level:LevelManager;
		
		public function Collider(player:PlayerManager, level:LevelManager) {
			this.level = level;
			this.player = player;
		}
		
		/// Warning: both a command and a query
		public function collideV():void {
			for (var i:uint = 0; i < level.view.h_plats.numChildren; i++) {
				if (player.view.x - PLAYER_RADIUS < level.view.h_plats.getChildAt(i).x + level.view.h_plats.x + level.view.x + 100) {
					if (player.view.x + PLAYER_RADIUS > level.view.h_plats.getChildAt(i).x + level.view.h_plats.x + level.view.x) {
						if (player.view.y < level.view.h_plats.getChildAt(i).y + level.view.h_plats.y + level.view.y) {
							if (player.view.y - player.jumpSpeed > level.view.h_plats.getChildAt(i).y + level.view.h_plats.y + level.view.y) {
								level.view.y = player.view.y - level.view.h_plats.y - level.view.h_plats.getChildAt(i).y + 1;
								player.grounded = true;
								break;
							}
						}
					}
				}
			}
			if (i == level.view.h_plats.numChildren) {
				player.fall();
			}
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