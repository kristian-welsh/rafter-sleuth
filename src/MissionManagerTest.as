package {
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import flash.events.Event;
	import test.Spy;
	import ui.UIManagerFake;
	
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
		
		public function testtutorialPane():void {
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
			
			assertCalled(level, level.officerRunAway);
			assertCalled(level, level.playMissionRunners);
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
			
			assertCalled(userInterface, userInterface.startMission);
		}
		
		// Not used as of yet.
		
		public function testPane13():void {
			textBox.displayTextPane(13);
			missionManager.checkForText();
		
			assertEquals(14, textBox.currentTextPane);
			assertCalled(textBox, textBox.whenPlayAgainClickedExecute, [gameWin]);
			assertCalled(level, level.playMissionRunners);
		}
		
		public function testPane14():void {
			textBox.displayTextPane(14);
			missionManager.checkForText();
		}
		
		public function testPane15():void {
			textBox.displayTextPane(15);
			missionManager.checkForText();
		}
		
		public function testPane16():void {
			textBox.displayTextPane(16);
			missionManager.checkForText();
		}
		
		public function testPane17():void {
			textBox.displayTextPane(17);
			missionManager.checkForText();
		}
		
		/**
		 * @param	object Assumed to have a Object::getSpy instance function.
		 * @param	expectedFunction Assumed to be an instance function of object that is logged on spy.
		 */
		private function assertCalled(object:Object, expectedFunction:Function, expectedArguments:Array = null):void {
			assert(object.getSpy, "object does not have a function named " + expectedFunction);
			var spy:Spy = object.getSpy();
			if (expectedArguments == null)
				spy.assertCalled(expectedFunction);
			else
				spy.assertCalledWithArguments(expectedFunction, expectedArguments);
		}
	}
}