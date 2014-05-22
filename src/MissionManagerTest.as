package {
	import asunit.framework.TestCase;
	import flash.display.MovieClip;
	import flash.events.Event;
	import ui.UserInterfaceManager;
	import ui.UserInterfaceView;
	
	public class MissionManagerTest extends TestCase {
		private var textBox:TextBox;
		private var missionManager:MissionManager;
		
		public function MissionManagerTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			textBox = new TextBox(new MovieClip());
			var player:PlayerManager = new PlayerManager(new MovieClip());
			var level:LevelManager = new LevelManager(new MovieClip());
			var userInterface:UserInterfaceManager = new UserInterfaceManager(new UserInterfaceView(new MovieClip()));
			var gameWin:Function = function(e:Event):void {
			
			}
			missionManager = new MissionManager(textBox, player, level, userInterface, gameWin);
		}
		
		public function testPane1():void {
			textBox.displayTextPane(1);
			missionManager.checkForText();
		}
		
		// not used yet
		
		public function testPane2():void {
			textBox.displayTextPane(2);
			missionManager.checkForText();
		}
		
		public function testPane3():void {
			textBox.displayTextPane(3);
			missionManager.checkForText();
		}
		
		public function testPane4():void {
			textBox.displayTextPane(4);
			missionManager.checkForText();
		}
		
		public function testPane5():void {
			textBox.displayTextPane(5);
			missionManager.checkForText();
		}
		
		public function testPane6():void {
			textBox.displayTextPane(6);
			missionManager.checkForText();
		}
		
		public function testPane7():void {
			textBox.displayTextPane(7);
			missionManager.checkForText();
		}
		
		public function testPane8():void {
			textBox.displayTextPane(8);
			missionManager.checkForText();
		}
		
		public function testPane9():void {
			textBox.displayTextPane(9);
			missionManager.checkForText();
		}
		
		public function testPane10():void {
			textBox.displayTextPane(10);
			missionManager.checkForText();
		}
		
		public function testPane11():void {
			textBox.displayTextPane(11);
			missionManager.checkForText();
		}
		
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
	}
}