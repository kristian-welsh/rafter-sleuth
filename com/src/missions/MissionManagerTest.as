package src.missions {
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	import lib.test.ReflectionTestSuiteBuilder;
	import lib.test.SuiteProvider;
	import src.level.LevelManagerSpy;
	import src.missions.text_panes.*;
	import src.player.PlayerDataSpy;
	import src.textbox.FakeTextBox;
	import src.textbox.TextBox;
	import src.ui.UIManagerFake;

	public class MissionManagerTest extends TestCase implements SuiteProvider {
		private var textBox:TextBox;
		private var missionManager:MissionManager;
		private var player:PlayerDataSpy;
		private var level:LevelManagerSpy;
		private var userInterface:UIManagerFake;

		public function getSuite():TestSuite {
			var testSuite:ReflectionTestSuiteBuilder = new ReflectionTestSuiteBuilder(this)
			testSuite.addTests([
				testPane1,
				testPane2,
				testPane3,
				testPane4,
				testTutorialPane,
				testPane11,
				testPane12,
				testPane13,
				testPane14,
				testPane15,
				testPane16,
				testPane17]);
			return testSuite.getSuite()
		}

		public function MissionManagerTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			textBox = new FakeTextBox()
			player = new PlayerDataSpy();
			level = new LevelManagerSpy();
			userInterface = new UIManagerFake();
			missionManager = new MissionManager(textBox, player, level, userInterface);
		}

		public function testPane1():void {
			player.getData().prepareAssertState("Mja");

			textBox.displayTextPane(1);
			missionManager.checkForText();
			assertTutorialPane(1);
			player.getData().assertState("Mja");

			assertFalse(missionManager.canAdvanceText);
		}

		private function assertTutorialPane(previousPaneNumber:uint):void {
			assertEquals(previousPaneNumber + 1, textBox.currentTextPane);
			assertEquals(2, missionManager.tutorialSection);
		}

		public function testPane2():void {
			player.getData().prepareAssertState("mJa");

			textBox.displayTextPane(2);
			missionManager.checkForText();
			assertTutorialPane(2);
			player.getData().assertState("mJa");

			assertFalse(missionManager.canAdvanceText);
		}

		public function testPane3():void {
			player.getData().prepareAssertState("mjA");

			textBox.displayTextPane(3);
			missionManager.checkForText();
			assertTutorialPane(3);
			player.getData().assertState("mjA");

			assertFalse(missionManager.canAdvanceText);
		}

		public function testPane4():void {
			player.getData().prepareAssertState("mja");

			textBox.displayTextPane(4);
			missionManager.checkForText();
			assertTutorialPane(4);
			player.getData().assertState("mja");
		}

		public function testTutorialPane():void {
			textBox.displayTextPane(10);
			missionManager.checkForText();
			assertTutorialPane(10);
		}

		public function testPane11():void {
			player.getData().prepareAssertState("MJA");
			textBox.show();

			textBox.displayTextPane(11);
			missionManager.checkForText();
			assertTutorialPane(11);
			player.getData().assertState("MJA");

			assertFalse(textBox.visible);
			level.getSpy().assertLogged(level.officerRunAway);
			level.getSpy().assertLogged(level.playMissionRunners);
		}

		public function testPane12():void {
			textBox.show();
			player.getData().prepareAssertState("MJA");

			textBox.displayTextPane(12);
			missionManager.checkForText();

			assertEquals(13, textBox.currentTextPane);
			assertEquals(1, missionManager.currentMission);
			player.getData().assertState("MJA");

			assertFalse(textBox.visible);
			userInterface.getSpy().assertLogged(userInterface.startMission);
		}

		public function testPane13():void {
			textBox.displayTextPane(13);
			missionManager.checkForText();

			assertEquals(14, textBox.currentTextPane);
			level.getSpy().assertLogged(level.playMissionRunners);
		}

		public function testPane14():void {
			textBox.displayTextPane(14);
			missionManager.checkForText();

			assertFalse(textBox.visible);
			player.getData().assertState("MJA");
		}

		public function testPane15():void {
			textBox.displayTextPane(15);
			missionManager.checkForText();

			assertGameEnded();
		}

		public function testPane16():void {
			textBox.displayTextPane(16);
			missionManager.checkForText();

			assertEquals(17, textBox.currentTextPane);
		}

		public function testPane17():void {
			textBox.displayTextPane(17);
			missionManager.checkForText();

			assertGameEnded();
		}

		private function assertGameEnded():void {
			// end game not yet implemented so no behaviour to test here.
		}
	}
}