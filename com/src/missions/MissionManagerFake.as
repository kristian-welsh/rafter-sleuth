package src.missions {
	import flash.display.MovieClip;
	import src.level.LevelManager;
	import src.player.PlayerDataSpy;
	import src.textbox.FakeTextBox;
	import src.ui.UIManagerFake;

	public class MissionManagerFake extends MissionManager {
		public function MissionManagerFake() {
			super(new FakeTextBox(), new PlayerDataSpy(), new LevelManager(new MovieClip()), new UIManagerFake())
		}
	}
}