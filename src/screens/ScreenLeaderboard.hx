package screens;

import openfl.Assets;
import openfl.Lib;
import openfl.display.Stage;
import openfl.text.TextField;
import screens.ScreenManager.ScreenType;
import openfl.media.Sound;
import openfl.media.SoundTransform;

/**
 * Leaderboard Screen
 */
class ScreenLeaderboard extends Screen
{

	public function new() 
	{
		super();
		trace("Leaderboardscreen loaded");
		screenType = ScreenType.Leaderboard;
		onLoad();
	}
	
	public override function onLoad(){
		var backButton : Button = new Button(Assets.getBitmapData("img/UI/Back1.png"), Assets.getBitmapData("img/UI/Back2.png"), Assets.getBitmapData("img/UI/Back3.png"), back);
		
		backButton.x = -75;
		backButton.y = 0 + Lib.current.stage.stageHeight - backButton.height;
		addChild(backButton);
		
	}
	
	//Back button returns to last screen.
	function back(){
		Main.getInstance().screenManager.loadLastScreen();
	}
	
}