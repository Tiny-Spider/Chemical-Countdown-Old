package;

import util.Point;
/**
 * ...
 * @author Mark
 */
class PathfinderTest 
{

	public function new() 
	{
		var map:Array<Array<Bool>> = new Array<Array<Bool>>();
		
		map = [for (x in 0...7)[for (y in 0...6) true]];
	
		map[3][4] = false;
		map[3][3] = false;
		map[3][2] = false;
		map[3][1] = false;
		map[3][0] = false;
		map[4][1] = false;
		
		var startPoint:Point = new Point(0, 0);
		var endPoint:Point = new Point(6, 3);
		
		var pathfinder:Pathfinder = new Pathfinder(startPoint, endPoint, map);
		var path:Array<Point> = pathfinder.findPath();
		
		trace("Path Length: " + path.length);
		
		for (x in 0...map.length) {
			var h:String = "";
			
			for (y in 0...map[x].length) {
				if (startPoint.x == x && startPoint.y == y) {
					h += "S ";
				} else if (endPoint.x == x && endPoint.y == y) {
					h += "E ";
				} else if (Lambda.exists(path, function(p):Bool { return p.x == x && p.y == y; })) {
					h += ". ";
				} else {
					h += map[x][y] ? "O " : "X ";
				}
				
			}	
				trace(h);
		}
	}
	
}