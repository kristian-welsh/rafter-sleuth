package src.player {
	import flash.display.MovieClip;
	
	public class PlayerManager implements PlayerData {
		static private const IDLE_RIGHT_FRAME:Number = 1;
		static private const IDLE_LEFT_FRAME:Number = 2;
		static private const WALK_RIGHT_FRAME:Number = 3;
		static private const WALK_LEFT_FRAME:Number = 4;
		static private const FALL_RIGHT_FRAME:Number = 5;
		static private const FALL_LEFT_FRAME:Number = 6;
		static private const ATTACK_RIGHT_FRAME:Number = 7;
		static private const ATTACK_LEFT_FRAME:Number = 8;
		
		static private const ATTACK_ANIMATION_END_FRAME:Number = 12;
		
		private var _view:MovieClip;
		private var _attacking:Boolean;
		private var _grounded:Boolean;
		private var _invincible:Boolean;
		private var _canMove:Boolean;
		private var _canJump:Boolean;
		private var _canAttack:Boolean;
		private var _lastDir:String = "right";
		private var _jumpSpeed:Number = 0;
		private var _walkSpeed:Number = 15;
		private var _gravity:Number = 1.5;
		
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
		
		public function get jumpSpeed():Number {
			return _jumpSpeed;
		}
		
		public function set jumpSpeed(value:Number):void {
			_jumpSpeed = value;
		}
		
		public function get walkSpeed():Number {
			return _walkSpeed;
		}
		
		public function get gravity():Number {
			return _gravity;
		}
		
		public function setLastDireciton(value:String):void {
			_lastDir = value;
		}
		
		public function isFacingRight():Boolean {
			return isFacing("right");
		}
		
		public function isFacingLeft():Boolean {
			return isFacing("left");
		}
		
		private function isFacing(direction:String):Boolean {
			return _lastDir == direction;
		}
		
		public function PlayerManager(view:MovieClip) {
			_view = view;
		}
		
		public function shouldJump():Boolean {
			return grounded && (!attacking) && canJump;
		}
		
		public function jump():void {
			grounded = false;
			jumpSpeed = 35;
		}
		
		public function checkAttackStatus():void {
			if (!attacking)
				return;
			displayAttack();
			if (grounded) {
				stopAttackingIfFinished();
			}
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
			return view.person.currentFrame == ATTACK_RIGHT_FRAME && view.person.attackRight.currentFrame == ATTACK_ANIMATION_END_FRAME;
		}
		
		private function playerHasFinishedAttackingLeft():Boolean {
			return view.person.currentFrame == ATTACK_LEFT_FRAME && view.person.attackLeft.currentFrame == ATTACK_ANIMATION_END_FRAME;
		}
		
		private function displayAttack():void {
			if (isFacing("right") && view.person.currentFrame != ATTACK_RIGHT_FRAME) {
				displayRightAttack();
			}
			if (isFacing("left") && view.person.currentFrame != ATTACK_LEFT_FRAME) {
				displayLeftAttack();
			}
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
		
		public function displayIdle():void {
			if (isFacing("right"))
				displayIdleRight();
			else if (isFacing("left"))
				displayIdleLeft();
		}
		
		private function displayFrame(frameNumber:uint):void {
			if (view.person.currentFrame != frameNumber)
				view.person.gotoAndStop(frameNumber);
		}
		
		public function displayIdleRight():void {
			displayFrame(IDLE_RIGHT_FRAME);
		}
		
		public function displayIdleLeft():void {
			displayFrame(IDLE_LEFT_FRAME);
		}
		
		public function displayFalling():void {
			if (isFacing("right"))
				displayFrame(FALL_RIGHT_FRAME);
			if (isFacing("left"))
				displayFrame(FALL_LEFT_FRAME);
		}
		
		public function displayWalkRight():void {
			displayFrame(WALK_RIGHT_FRAME);
		}
		
		public function displayWalkLeft():void {
			displayFrame(WALK_LEFT_FRAME);
		}
		
		public function freeze():void {
			canMove = false;
			canJump = false;
			canAttack = false;
		}
		
		public function fall():void {
			grounded = false;
			displayFalling();
		}
		
		public function updateInvincibility():void {
			if (view.invincibility.currentFrame == 1)
				invincible = false;
		}
		
		public function reset():void {
			canMove = true;
			canJump = true;
			canAttack = true;
			invincible = false;
			view.invincibility.gotoAndStop(1);
		}
	}
}