package src.missions {
	import src.level.ILevelManager;
	import src.missions.text_panes.*;
	import src.player.PlayerData;
	import src.textbox.TextBox;
	import src.ui.UIManager;

	public class MissionManager implements IMissionManager {
		private var factory:TextPaneFactory;

		private var textBox:TextBox;
		private var player:PlayerData;
		private var level:ILevelManager;
		private var userInterface:UIManager;

		private var _canAdvanceText:Boolean = true;
		private var _currentMission:uint = 0;
		private var _tutorialSection:uint = 1;

		public function MissionManager(textBox:TextBox, player:PlayerData, level:ILevelManager, userInterface:UIManager) {
			factory = new TextPaneFactory(textBox, level, this)
			this.textBox = textBox
			this.player = player
			this.level = level
			this.userInterface = userInterface
		}

		public function checkForText():void {
			var pane:ITextPane = factory.createTextPane(textBox.currentTextPane)
			if (textBox.visible && _canAdvanceText)
				pane.show();
		}

		// get canAdvanceText() is only used by tests.
		// I would delete it, but I need to decouple the pane tests from MissionManager first.
		public function get canAdvanceText():Boolean {
			return _canAdvanceText;
		}

		public function enableTextAdvancement():void {
			_canAdvanceText = true
		}

		public function disableTextAdvancement():void {
			_canAdvanceText = false
		}

		public function get currentMission():uint {
			return _currentMission;
		}

		// get tutorialSection() is only used by tests.
		// I would delete it, but I need to decouple the pane tests from MissionManager first.
		public function get tutorialSection():uint {
			return _tutorialSection;
		}

		public function incrementTutorialSection():void {
			_tutorialSection += 1
		}

		public function tutorialActionCompleted(tutorialSectionCompleted:uint):void {
			if (tutorialSection == tutorialSectionCompleted)
				advanceTutorial()
		}

		public function advanceTutorial():void {
			_canAdvanceText = true;
			checkForText();
		}

		public function endTutorial():void {
			incrementTutorialSection();
			level.officerRunAway();
			level.playMissionRunners();
		}

		public function tutorialCompleted():Boolean {
			return _tutorialSection == 12
		}

		public function startMission():void {
			_currentMission = 1
			userInterface.startMission();
		}

		public function endMission():void {
			level.playMissionRunners();
		}

		public function resetProgress():void {
			_currentMission = 0
			_tutorialSection = 1
		}
//--
		public function disablePlayerMovement():void {
			player.canMove = false;
		}

		public function enablePlayerMovement():void {
			player.canMove = true;
		}

		public function disablePlayerJump():void {
			player.canJump = false;
		}

		public function enablePlayerJump():void {
			player.canJump = true;
		}

		public function disablePlayerAttack():void {
			player.canAttack = false;
		}

		public function enablePlayerAttack():void {
			player.canAttack = true;
		}
	}
}