package src.textbox {
	import asunit.framework.TestCase;
	import src.test.MovieClipSpy;
	
	public class TextBoxTest extends TestCase {
		private var view:MovieClipSpy;
		private var textBox:TextBox;
		
		public function TextBoxTest(methodName:String = null) {
			super(methodName);
		}
		
		override protected function setUp():void {
			view = new MovieClipSpy();
			textBox = new TextBox(view);
		}
		
		public function visible_returns_whether_view_is_visible():void {
			view.visible = true;
			assertTrue(textBox.visible);
			view.visible = false;
			assertFalse(textBox.visible);
		}
		
		public function show_makes_view_visible():void {
			view.visible = false;
			textBox.show();
			assertTrue(view.visible);
		}
		
		public function hide_makes_view_invisible():void {
			view.visible = true;
			textBox.hide();
			assertFalse(view.visible);
		}
		
		public function currentTextPane_returns_1():void {
			assertEquals(1, textBox.currentTextPane);
		}
		
		public function get_box_does_not_throw_error():void {
			textBox.box;
		}
		
		public function displayTextPane_calls_gotoAndStop_on_view():void {
			textBox.displayTextPane(0);
			view.spy.assertLogged(view.gotoAndStop);
		}
	}
}