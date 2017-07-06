package levels;

import openfl.utils.Dictionary;
import util.Point;

/**
 * ...
 * @author Mark
 */
class LevelManager 
{
	private var levels:Array<LevelData> = new Array<LevelData>();

	private var levelOneBackground:Array<Array<Int>> = [
		[ 0,  1,  1,  1,  1,  1,  2],
		[ 3,  4,  4,  4,  4,  4,  5],
		[ 3,  4,  4,  4,  4,  4,  5],
		[ 3,  4,  4,  4,  4,  4,  5],
		[ 6,  7,  7,  7,  7,  7,  8]
		];
	
	private var levelOneForeground:Array<Array<Int>> = [
		[14, 14, 14, 14, 14, 14, -1],
		[-1, -1, -1, -1, -1, -1, -1],
		[-1, 18, -1, 19, -1, -1, -1],
		[-1, -1, -1, -1, -1, -1, -1],
		[-1,  9, 10, 11, 12, 13, -1]
		];
		
	private var levelTwoBackground:Array<Array<Int>> = [
		[ 0,  1,  1,  1,  2],
		[ 3,  4,  4,  4,  5],
		[ 3,  4,  4,  4,  5],
		[ 3,  4,  4,  4,  5],
		[ 6,  7,  7,  7,  8]
		];
	
	private var levelTwoForeground:Array<Array<Int>> = [
		[-1, 12, -1,  9, -1],
		[18, -1, -1, -1, 19],
		[14, 14, 14, -1, -1],
		[-1, -1, -1, -1, -1],
		[10, -1, 13, -1, 11]
		];
	
	public function new() 
	{
		levels.push(new LevelData(5.0, 20, new Point(0, 0), new Point(0, 1), levelOneBackground, levelOneForeground));
		levels.push(new LevelData(3.0, 20, new Point(0, 2), new Point(2, 0), levelTwoBackground, levelTwoForeground));
	}
	
	public function getLevel(id:Int) 
	{
		return id < levels.length ? levels[id] : null;
	}
	
}