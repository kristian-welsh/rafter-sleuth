package  {
	import flash.display.MovieClip;

	public class PlayerManager {
		static private const ATTACK_RIGHT_FRAME:Number = 7;
		static private const ATTACK_LEFT_FRAME:Number = 8;
		static private const ATTACK_END_FRAME:Number = 12;
		
		private var _view:MovieClip;
		private var _attacking:Boolean;
		private var _grounded:Boolean;
		private var _invincible:Boolean;
		private var _canMove:Boolean;
		private var _canJump:Boolean;
		private var _canAttack:Boolean;
		private var _lastDir:String = "right";
		
		public function get attacking():Boolean {
			return _attacking;
		}
		
		public function set attacking(value:Boolean):void {
			_attacking = value;
		}
		
		public function get grounded():Boolean {
			return _grounded;
		}
		
		public function set grounded(value:Boolean):void {
			_grounded = value;
		}
		
		public function get invincible():Boolean {
			return _invincible;
		}
		
		public function set invincible(value:Boolean):void {
			_invincible = value;
		}
		
		public function get canMove():Boolean {
			return _canMove;
		}
		
		public function set canMove(value:Boolean):void {
			_canMove = value;
		}
		
		public function get canJump():Boolean {
			return _canJump;
		}
		
		public function set canJump(value:Boolean):void {
			_canJump = value;
		}
		
		public function get canAttack():Boolean {
			return _canAttack;
		}
		
		public function set canAttack(value:Boolean):void {
			_canAttack = value;
		}
		
		public function get view():MovieClip {
			return _view;
		}
		
		public function get lastDir():String {
			return _lastDir;
		}
		
		public function set lastDir(value:String):void {
			_lastDir = value;
		}
		
		public function PlayerManager(view:MovieClip) {
			this._view = view;
		}
		
		public function shouldJump():Boolean {
			return grounded && (!attacking) && canJump;
		}
		
		public function checkAttackStatus():void {
			if (!attacking)
				return;
			if (playerIsFacing("right") && view.person.currentFrame != ATTACK_RIGHT_FRAME) {
				displayRightAttack();
			}
			if (playerIsFacing("left") && view.person.currentFrame != ATTACK_LEFT_FRAME) {
				displayLeftAttack();
			}
			if (grounded) {
				stopAttackingIfFinished();
			}
		}
		
		public function playerIsFacing(direction:String):Boolean {
			return _lastDir == direction;
		}
		
		private function displayRightAttack():void {
			view.person.gotoAndStop(ATTACK_RIGHT_FRAME);
			view.person.attackRight.play();
			view.attackHitBox.x = 0;
		}
		
		private function displayLeftAttack():void {
			view.person.gotoAndStop(ATTACK_LEFT_FRAME);
			view.person.attackLeft.play();
			view.attackHitBox.x = -200;
		}
		
		private function stopAttackingIfFinished():void {
			if (playerHasFinishedAttackingRight()) {
				attacking = false;
				view.person.attackRight.stop();
			}
			if (playerHasFinishedAttackingLeft()) {
				attacking = false;
				view.person.attackLeft.stop();
			}
		}
		
		private function playerHasFinishedAttackingRight():Boolean {
			return view.person.currentFrame == ATTACK_RIGHT_FRAME && view.person.attackRight.currentFrame == ATTACK_END_FRAME;
		}
		
		private function playerHasFinishedAttackingLeft():Boolean {
			return view.person.currentFrame == ATTACK_LEFT_FRAME && view.person.attackLeft.currentFrame == ATTACK_END_FRAME;
		}
	}
}