package;

/**
 * ...
 * @author Mark
 */
class PathfinderOld
{
	private var test:Array<Array<Int>> = [
			[ 0,  1,  1,  1,  1],
			[ 0,  0,  1,  0,  0],
			[ 0,  0,  1,  0,  1],
			[ 0,  1,  1,  0,  1],
			[ 0,  0,  0,  0,  1]
										 ];

	public var points:Array<PointNode> = new Array<PointNode>();
	public var field:Array<Array<Int>> = new Array<Array<Int>>();

	public function new()
	{
		var target:PointNode = solve(4, 1, test);

		if (target == null)
		{
			trace("Could not find path");
		}
		else
		{
			while (target.parent != null)
			{
				trace("X: " + target.x + " Y: " + target.y);

				target = target.parent;
			}
		}
	}

	public function solve(targetX:Int, targetY:Int, field:Array<Array<Int>>):PointNode
	{
		this.field = field;

		points.push(new PointNode(0, 0, null));

		while (points.length > 0)
		{
			var point:PointNode = points[0];
			points.remove(point);

			if (point.x == targetX && point.y == targetY)
			{
				trace("Exit is reached!");
				return point;
			}

			if (isFree(point.x + 1, point.y))
			{
				this.field[point.x][point.y] = 2;
				
				var nextP:PointNode = new PointNode(point.x + 1, point.y, point);
				points.push(nextP);
			}

			if (isFree(point.x - 1, point.y))
			{
				this.field[point.x][point.y] = 2;
				
				var nextP:PointNode = new PointNode(point.x - 1, point.y, point);
				points.push(nextP);
			}

			if (isFree(point.x, point.y + 1))
			{
				this.field[point.x][point.y] = 2;
				
				var nextP:PointNode = new PointNode(point.x, point.y + 1, point);
				points.push(nextP);
			}

			if (isFree(point.x, point.y - 1))
			{
				this.field[point.x][point.y] = 2;
				
				var nextP:PointNode = new PointNode(point.x, point.y - 1, point);
				points.push(nextP);
			}
		}

		return null;
	}

	public function isFree(x:Int, y:Int):Bool
	{
		return (x >= 0 && x < field.length) && (y >= 0 && y < field[x].length) && field[x][y] == 0;
	}
}

class PointNode
{
	public var parent:PointNode;
	public var x:Int;
	public var y:Int;

	public function new(x:Int, y:Int, parent:PointNode)
	{
		this.x = x;
		this.y = y;
		this.parent = parent;
	}
}