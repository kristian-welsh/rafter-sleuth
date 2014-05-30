package src {
	import asunit.framework.TestCase;
	import flash.events.Event;
	import lib.assert;
	import lib.test.Spy;
	import src.level.LevelManagerSpy;
	import src.player.PlayerDataSpy;
	import src.textbox.TextBoxSpy;
	import src.ui.UIManagerFake;
	
	public class MissionManagerTest extends TestCase {
		private var textBox:TextBoxSpy;
		private var missionManager:MissionManager;
		private var player:PlayerDataSpy;
		private var level:LevelManagerSpy;
		private var userInterface:UIManagerFake;
		private var gameWin:Function = function(e:Event):void {
		
		};
		
		public function MissionManagerTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			textBox = new TextBoxSpy();
			player = new PlayerDataSpy();
			level = new LevelManagerSpy();
			userInterface = new UIManagerFake();
			missionManager = new MissionManager(textBox, player, level, userInterface, gameWin);
		}
		
		public function testPane1():void {
			player.prepareAssertState("Mja");
			
			textBox.displayTextPane(1);
			missionManager.checkForText();
			
			assertEquals(2, textBox.currentTextPane);
			assertEquals(2, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("Mja");
		}
		
		public function testPane2():void {
			player.prepareAssertState("mJa");
			
			textBox.displayTextPane(2);
			missionManager.checkForText();
			
			assertEquals(3, textBox.currentTextPane);
			assertEquals(3, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("mJa");
		}
		
		public function testPane3():void {
			player.prepareAssertState("mjA");
			
			textBox.displayTextPane(3);
			missionManager.checkForText();
			
			assertEquals(4, textBox.currentTextPane);
			assertEquals(4, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("mjA");
		}
		
		public function testPane4():void {
			player.prepareAssertState("mja");
			
			textBox.displayTextPane(4);
			missionManager.checkForText();
			
			assertEquals(5, textBox.currentTextPane);
			assertEquals(5, missionManager.tutorialProgress);
			
			player.assertState("mja");
		}
		
		public function testTutorialPane():void {
			textBox.displayTextPane(10);
			missionManager.checkForText();
			
			assertEquals(11, textBox.currentTextPane);
			assertEquals(11, missionManager.tutorialProgress);
		}
		
		public function testPane11():void {
			player.prepareAssertState("MJA");
			textBox.show();
			
			textBox.displayTextPane(11);
			missionManager.checkForText();
			
			assertEquals(12, textBox.currentTextPane);
			assertEquals(13, missionManager.tutorialProgress);
			assertFalse(textBox.visible);
			
			player.assertState("MJA");
			
			level.getSpy().assertLogged(level.officerRunAway);
			level.getSpy().assertLogged(level.playMissionRunners);
		}
		
		public function testPane12():void {
			textBox.show();
			player.prepareAssertState("MJA");
			
			textBox.displayTextPane(12);
			missionManager.checkForText();
			
			assertEquals(13, textBox.currentTextPane);
			assertEquals(1, missionManager.currentMission);
			assertFalse(textBox.visible);
			player.assertState("MJA");
			
			userInterface.getSpy().assertLogged(userInterface.startMission);
		}
		
		public function testPane13():void {
			textBox.displayTextPane(13);
			missionManager.checkForText();
			
			assertEquals(14, textBox.currentTextPane);
			textBox.getSpy().assertLogged(textBox.whenPlayAgainClickedExecute, [gameWin]);
			level.getSpy().assertLogged(level.playMissionRunners);
		}
		
		public function testPane14():void {
			textBox.displayTextPane(14);
			missionManager.checkForText();
			
			assertFalse(textBox.visible);
			player.assertState("MJA");
		}
		
		public function testPane15():void {
			textBox.displayTextPane(15);
			missionManager.checkForText();
			
			// end game not yet implemented so no behaviour to test here.
		}
		
		public function testPane16():void {
			textBox.displayTextPane(16);
			missionManager.checkForText();
			
			assertEquals(17, textBox.currentTextPane);
		}
		
		public function testPane17():void {
			textBox.displayTextPane(17);
			missionManager.checkForText();
			
			// end game not yet implemented so no behaviour to test here.
		}
	}
}