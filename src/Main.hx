package;

import levels.LevelManager;
import openfl.Lib;
import openfl.display.Tilemap;
import tiles.TileManager;

import openfl.display.FPS;
import openfl.display.Sprite;

import screens.Screen;
import screens.ScreenManager;
import screens.ScreenTitle;

import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

import src.Score;

/**
 * Main class of the program
 */
class Main extends Sprite
{
	private static var instance:Main;
	private static var tileManager:TileManager;
	private static var levelManager:LevelManager;

	public var screenManager:ScreenManager;
	public var leaderBoards:Leaderboards;

	public var score : Score;
	
	//Sound
	public var audioOn : Bool = true;
	public var musicChannel : SoundChannel = new SoundChannel();
	public var musicTransform : SoundTransform = new SoundTransform();

	public function new()
	{
		super();

		instance = this;

		score = new Score();

		tileManager = new TileManager();
		levelManager = new LevelManager();

		screenManager = new ScreenManager();
		leaderBoards = new Leaderboards();

		LoadScreen();
	}

	public static function getInstance():Main
	{
		return instance;
	}

	public static function getTileManager():TileManager
	{
		return tileManager;
	}

	public static function getLevelManager():LevelManager
	{
		return levelManager;
	}

	public function LoadScreen()
	{
		screenManager.loadScreen(ScreenType.Title);
	}
}
