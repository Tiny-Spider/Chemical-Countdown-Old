package screens;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import screens.ScreenManager.ScreenType;
import openfl.display.Stage;
import openfl.Lib;

/**
 * 
 */
class ScreenGameMenu extends Sprite
{
	public var myStage: Stage;
	var screen : Screen;

	public function new(_screen: Screen) 
	{
		super();
		screen = _screen;
		
		myStage = Lib.current.stage;
		Main.getInstance().addChild(this);
		onLoad();
	}
	
	function onLoad(){
		var buttonCount : Int = 0;
		//var sprite : Sprite = new Sprite();
		//addChild(sprite);
		
		var background : Bitmap = new Bitmap(Assets.getBitmapData("img/UI/InGameMenu.png"));
		background.x = (myStage.stageWidth / 2) - (background.width / 2);
		background.y = (myStage.stageHeight / 2) - (background.height / 2);
		
		addChild(background);
		
		//Resume button
		var newButton : Button = new Button(Assets.getBitmapData("img/UI/Resume1.png"), Assets.getBitmapData("img/UI/Resume2.png"), Assets.getBitmapData("img/UI/Resume3.png"), resume);
		
		newButton.x = (myStage.width /2) - (newButton.width /2) - 35;
		newButton.y = (background.y + 100) + ((newButton.height *1)* buttonCount);
		addChild(newButton);
		buttonCount++;
		
		//Restart button
		newButton = new Button(Assets.getBitmapData("img/UI/Restart1.png"), Assets.getBitmapData("img/UI/Restart2.png"), Assets.getBitmapData("img/UI/Restart3.png"), resume);
		
		newButton.x = (myStage.width /2) - (newButton.width /2) - 35;
		newButton.y = (background.y + 100) + ((newButton.height *1)* buttonCount);
		addChild(newButton);
		buttonCount++;
		
		//Exit button
		newButton = new Button(Assets.getBitmapData("img/UI/Exit1.png"), Assets.getBitmapData("img/UI/Exit2.png"), Assets.getBitmapData("img/UI/Exit3.png"), quit);
		
		newButton.x = (myStage.width /2) - (newButton.width /2) - 35;
		newButton.y = (background.y + 100) + ((newButton.height *1)* buttonCount);
		addChild(newButton);
		buttonCount++;
	}
	
	//Closes the InGameMenu screen
	function resume(){
		screen.removeChild(this);
		trace(cast(screen, ScreenGame).inGameMenuOpen);
		cast(screen, ScreenGame).inGameMenuOpen = false;
		trace(cast(screen, ScreenGame).inGameMenuOpen);
	}
	
	//Restarts the level.
	function restart(){
		//Restart level here.
	}
	
	//Returns to the main menu.
	function quit(){
		Main.getInstance().screenManager.loadScreen(ScreenType.Title);
	}
}