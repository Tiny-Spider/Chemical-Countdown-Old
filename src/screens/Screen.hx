package screens;

import openfl.display.Sprite;
import screens.ScreenManager.ScreenType;
import openfl.display.Stage;
import openfl.Lib;



/**
 * Base Screen Class
 */
class Screen extends Sprite
{
	public var screenType:ScreenType;
	public var myStage: Stage;

	public function new() 
	{
		super();
		
		if (Main.getInstance().numChildren != 0){
			Main.getInstance().removeChildren();
		}
		
		myStage = Lib.current.stage;
		Main.getInstance().addChild(this);
	}
	
	public function onLoad(){
		
	}
	
	public function onDestroy(){
		
	}
}