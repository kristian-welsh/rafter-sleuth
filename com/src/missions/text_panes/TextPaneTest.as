package src.missions.text_panes {
	import asunit.framework.TestCase;
	import src.missions.MissionManagerFake;
	import src.textbox.FakeTextBox;

	public class TextPaneTest extends TestCase {
		private var textPane:TextPane;

		public function TextPaneTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			textPane = new TextPane(new FakeTextBox(), new MissionManagerFake())
		}

		public function throws_correct_error_on_show():void {
			try {
				textPane.show();
			} catch (e:Error) {
				if (e != TextPane.METHOD_NOT_OVERRIDEN_ERROR)
					throw e
			}
		}
	}
}