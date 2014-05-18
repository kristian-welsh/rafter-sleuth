package {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.UserInterfaceManager;
	
	public class ClockManager {
		private var userInterface:UserInterfaceManager;
		private var textBox:TextBox;
		private var player:PlayerManager;
		private var timer:Timer = new Timer(1000);
		
		public function ClockManager(userInterface:UserInterfaceManager, textBox:TextBox, player:PlayerManager):void {
			this.player = player;
			this.textBox = textBox;
			this.userInterface = userInterface;
		}
		
		public function start():void {
			timer.addEventListener(TimerEvent.TIMER, clock);
			timer.start();
		}
		
		public function stop():void {
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, clock);
		}
		
		public function clock(event:TimerEvent):void {
			if (userInterface.clockFinished()) {
				if (textBox.currentTextPane < 14) {
					textBox.show();
					player.freeze();
					textBox.displayTextPane(15);
					userInterface.hideItemIcon();
					userInterface.hideQuestIcon();
				}
			}
			if (textBox.visible == false) {
				userInterface.tickSecondHand();
				userInterface.tickMinuteHand();
			}
		}
	}
}