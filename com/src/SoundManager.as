package src {
	import flash.media.*;

	public class SoundManager {
		private var soundEffectChannel:SoundChannel = new SoundChannel();
		private var questSound:Sound = new Bell_alert();
		private var completeSound:Sound = new Mission_complete();
		
		public function playQuestSound():void {
			soundEffectChannel = questSound.play();
		}
		
		public function playCompleteSound():void {
			soundEffectChannel = completeSound.play();
		}
	}
}