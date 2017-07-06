package util;

import haxe.EnumTools.EnumValueTools;

/**
 * ...
 * @author Mark
 */
class Point
{
	public var x:Int;
	public var y:Int;

	public function new(x:Int, y:Int)
	{
		this.x = x;
		this.y = y;
	}

	public function getAdjacent():Array<Point>
	{
		return Point.getAdjacentPoints(this);
	}

	public function equals(point:Point):Bool
	{
		return point.x == x && point.y == y;
	}

	public static function distance(fromPoint:Point, toPoint:Point):Float
	{
		var deltaX:Float = toPoint.x - fromPoint.x;
		var deltaY:Float = toPoint.y - fromPoint.y;

		return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
	}

	// Get adjacent points next to location (in order of Direction)
	public static function getAdjacentPoints(centerPoint:Point):Array<Point>
	{
		return [
			new Point(centerPoint.x,   centerPoint.y-1),
			new Point(centerPoint.x,   centerPoint.y+1),
			new Point(centerPoint.x-1, centerPoint.y  ),
			new Point(centerPoint.x+1, centerPoint.y  )
		];
	}

	// Get adjacent points next to location but prioritises nearest direction first 
	public static function getAdjacentDirectionalPoints(centerPoint:Point, direction:Direction):Array<Point>
	{
		var startIndex:Int = EnumValueTools.getIndex(direction);
		var points:Array<Point> = getAdjacentPoints(centerPoint);
		var newPoints:Array<Point> = new Array<Point>();
		
		for (index in 0...4) {
			newPoints.push(points[(index + startIndex) % 4]);
		}
		
		return newPoints;
	}

	public static function getDirectionBetween(fromPoint:Point, toPoint:Point):Direction
	{
		if (fromPoint.y > toPoint.y)
		{
			return Direction.UP;
		}
		else if (fromPoint.y < toPoint.y)
		{
			return Direction.DOWN;
		}
		else if (fromPoint.x < toPoint.x)
		{
			return Direction.RIGHT;
		}
		else if (fromPoint.x > toPoint.x)
		{
			return Direction.LEFT;
		}

		return Direction.UP;
	}
}

enum Direction
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}