package screens;

import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Stage;
import openfl.text.TextField;
import openfl.system.System;
import screens.ScreenManager;

import openfl.media.Sound;
import openfl.media.SoundTransform;

/**
 * Title Screen
 */
class ScreenTitle extends Screen
{

	public function new() 
	{
		super();
		trace("Titlescreen loaded");
		screenType = ScreenType.Title;
		onLoad();
	}
	
	//Loads UI and other elements
	public override function onLoad(){
		
		var scoreTextField:TextField = new TextField();
		var myStage : Stage = Lib.current.stage;
		
		
		//Background
		var bitmap : Bitmap = new Bitmap(Assets.getBitmapData("img/titleScreen.jpg"));
		bitmap.width = Lib.current.stage.stageWidth;
		bitmap.height = Lib.current.stage.stageHeight;
		addChild(bitmap);
		
		//Music
		if (Main.getInstance().audioOn){
			Main.getInstance().musicChannel.stop();
			var bgm : Sound = Assets.getSound("audio/menu_music.ogg");
			trace(bgm);
			Main.getInstance().musicChannel = bgm.play(0, 100, Main.getInstance().musicTransform);
		}
		
		//Text field test
		scoreTextField.width = 100;
		scoreTextField.x = (myStage.stageWidth * 0.5) - (scoreTextField.width * 0.5);
		scoreTextField.y = (myStage.stageHeight * 0.5) - (scoreTextField.height * 0.5);
		scoreTextField.border = true;
		scoreTextField.borderColor = 0x80FF00;
		scoreTextField.text = "Title screen";
		scoreTextField.textColor = 0x80FF00;
		//addChild(scoreTextField);
		
		var buttonCount : Int = 0;
		
		//Start button
		var startButton : Button = new Button(Assets.getBitmapData("img/UI/Play1.png"), Assets.getBitmapData("img/UI/Play2.png"), Assets.getBitmapData("img/UI/Play3.png"), start);
		
		startButton.x = myStage.stageWidth /2 - (startButton.width /2);
		startButton.y = myStage.stageHeight / 2 - (startButton.height / 2) - (startButton.height * buttonCount);
		addChild(startButton);
		buttonCount++;
		
		//Leaderboard button
		var leaderBoardButton : Button = new Button(Assets.getBitmapData("img/UI/Highscore1.png"), Assets.getBitmapData("img/UI/Highscore2.png"), Assets.getBitmapData("img/UI/Highscore3.png"), leaderBoard);
		
		leaderBoardButton.x = myStage.stageWidth /2 - (leaderBoardButton.width /2);
		leaderBoardButton.y = myStage.stageHeight / 2 - (leaderBoardButton.height / 2  - ( leaderBoardButton.height * buttonCount));
		addChild(leaderBoardButton);
		buttonCount++;
		
		//Quit button
		var quitButton : Button = new Button(Assets.getBitmapData("img/UI/Exit1.png"), Assets.getBitmapData("img/UI/Exit2.png"), Assets.getBitmapData("img/UI/Exit3.png"), quit);
		
		quitButton.x = myStage.stageWidth /2 - (quitButton.width /2);
		quitButton.y = myStage.stageHeight / 2 - (quitButton.height / 2  - ( quitButton.height * buttonCount));
		addChild(quitButton);
		buttonCount++;
		
		
	}
	
	//Starts the game to GameScreen
	function start(){
		trace("Start level");
		Main.getInstance().screenManager.loadScreen(ScreenType.Game);
	}
	
	//Goes to LeaderboardScreen
	function leaderBoard(){
		Main.getInstance().screenManager.loadScreen(ScreenType.Leaderboard);
	}
	
	//Close the game
	function quit(){
		trace("Quit game");
		System.exit(0);
	}
}