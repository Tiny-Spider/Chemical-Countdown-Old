package screens;

import screens.ScreenManager.ScreenType;

/**
 * Manages all screens
 */
class ScreenManager 
{
	public var currentScreen : Screen;
	public var lastScreen : Screen;
	
	public function new() 
	{
		currentScreen = new Screen();
		
		
	}
	
	public function loadScreen(screenType : ScreenType){
		lastScreen = currentScreen;
		
		switch(screenType){
			case ScreenType.Title:
				currentScreen = new ScreenTitle();
			case ScreenType.Game:
				currentScreen = new ScreenGame();
			case ScreenType.Leaderboard:
				currentScreen = new ScreenLeaderboard();
			default:
				trace("No screen");
		}
		
		lastScreen.onDestroy();
	}
	
	public function loadLastScreen(){
		loadScreen(lastScreen.screenType);
	}
	
}

enum ScreenType {
	Title;
	Menu;
	Game;
	Leaderboard;
}