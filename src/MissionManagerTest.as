package {
	import asunit.framework.Assert;
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import flash.events.Event;
	import test.Spy;
	import ui.UserInterfaceManager;
	import ui.UserInterfaceView;
	
	public class MissionManagerTest extends TestCase {
		private var textBox:TextBox;
		private var missionManager:MissionManager;
		private var player:PlayerDataSpy;
		private var level:LevelManagerSpy;
		
		public function MissionManagerTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			textBox = new TextBox(new MovieClip());
			player = new PlayerDataSpy();
			level = new LevelManagerSpy();
			var userInterface:UserInterfaceManager = new UserInterfaceManager(new UserInterfaceView(new MovieClip()));
			var gameWin:Function = function(e:Event):void {
			
			}
			missionManager = new MissionManager(textBox, player, level, userInterface, gameWin);
		}
		
		public function testPane1():void {
			textBox.displayTextPane(1);
			missionManager.checkForText();
			
			assertEquals(2, textBox.currentTextPane);
			assertEquals(2, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("Mja");
		}
		
		public function testPane2():void {
			textBox.displayTextPane(2);
			missionManager.checkForText();
			
			assertEquals(3, textBox.currentTextPane);
			assertEquals(3, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("mJa");
		}
		
		public function testPane3():void {
			textBox.displayTextPane(3);
			missionManager.checkForText();
			
			assertEquals(4, textBox.currentTextPane);
			assertEquals(4, missionManager.tutorialProgress);
			assertFalse(missionManager.canAdvanceText);
			
			player.assertState("mjA");
		}
		
		public function testPane4():void {
			textBox.displayTextPane(4);
			missionManager.checkForText();
			
			assertEquals(5, textBox.currentTextPane);
			assertEquals(5, missionManager.tutorialProgress);
			
			player.assertState("mja");
		}
		
		public function testNormalPane():void {
			textBox.displayTextPane(10);
			missionManager.checkForText();
			
			assertEquals(11, textBox.currentTextPane);
			assertEquals(11, missionManager.tutorialProgress);
		}
		
		public function testPane11():void {
			textBox.displayTextPane(11);
			missionManager.checkForText();
			
			assertEquals(12, textBox.currentTextPane);
			assertEquals(13, missionManager.tutorialProgress);
			assertFalse(textBox.visible);
			
			player.assertState("MJA");
			
			assertCalled(level, level.officerRunAway);
			assertCalled(level, level.playMissionRunners);
		}
		
		// Not used as of yet.
		
		public function testPane12():void {
			textBox.displayTextPane(12);
			missionManager.checkForText();
		}
		
		public function testPane13():void {
			textBox.displayTextPane(13);
			missionManager.checkForText();
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
			if(expectedArguments == null)
				spy.assertCalled(expectedFunction);
			else
				spy.assertCalledWithArguments(expectedFunction, expectedArguments);
		}
	}
}