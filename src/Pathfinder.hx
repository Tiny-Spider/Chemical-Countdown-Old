package;

import util.Point;

/**
 * An custom Haxe A* implementation
 * @author Mark
 */
class Pathfinder 
{
	private var width:Int;
	private var height:Int;
	private var nodes:Array<Array<Node>>;
	private var startNode:Node;
	private var endNode:Node;

	public function new(startPoint:Point, endPoint:Point, map:Array<Array<Bool>>)
	{
		initializeNodes(map, endPoint);
		
		//trace(nodes.length);
		//trace(nodes[0].length);
		
		startNode = nodes[startPoint.x][startPoint.y];
		startNode.state = NodeState.OPEN;
		endNode = nodes[endPoint.x][endPoint.y];
	}

	public function findPath():Array<Point>
	{
		// The start node is the first entry in the 'open' list
		var path:Array<Point> = new Array<Point>();
		var success:Bool = search(startNode);
		
		if (success)
		{
			// If a path was found, follow the parents from the end node to build a list of points
			var node:Node = endNode;
			while (node.parentNode != null)
			{
				path.push(node.point);
				node = node.parentNode;
			}

			// Reverse the list so it's in the correct order when returned
			path.reverse();
		}

		return path;
	}

	private function initializeNodes(map:Array<Array<Bool>>, endPosition:Point)
	{
		width = map.length;
		height = map[0].length;
		nodes = [for (x in 0...width)[for (y in 0...height) new Node(x, y, map[x][y], endPosition)]];
	}

	private function search(currentNode:Node):Bool
	{
		// Set the current node to CLOSED since it cannot be traversed more than once
		currentNode.state = NodeState.CLOSED;
		var nextNodes:Array<Node> = getAdjacentWalkableNodes(currentNode);
		
		// Sort by F-value so that the shortest possible routes are considered first
		nextNodes.sort(function(a, b):Int {
		    if (a.F < b.F) return -1;
		    else if (a.F > b.F) return 1;
		    return 0;
		});
		
		for (nextNode in nextNodes)
		{
			// Check whether the end node has been reached
			if (endNode != null && nextNode.point.equals(endNode.point))
			{
				return true;
			}
			else
			{
				// If not, check the next set of nodes
				if (search(nextNode))
					return true;
			}
		}

		// The method returns false if this path leads to be a dead end
		return false;
	}

	private function getAdjacentWalkableNodes(fromNode:Node):Array<Node>
	{
		var walkableNodes:Array<Node> = new Array<Node>();
		var nextPoints:Array<Point> = fromNode.point.getAdjacent();

		for (point in nextPoints)
		{
			var x:Int = point.x;
			var y:Int = point.y;

			// Stay within the grid's boundaries
			if (x < 0 || x >= width || y < 0 || y >= height)
				continue;

			var node:Node = nodes[x][y];
			
			// Ignore non-walkable nodes
			if (!node.isWalkable)
				continue;

			// Ignore already-closed nodes
			if (node.state == NodeState.CLOSED)
				continue;

			// Already-open nodes are only added to the list if their G-value is lower going via this route.
			if (node.state == NodeState.OPEN)
			{
				var traversalCost:Float = Point.distance(node.point, node.parentNode.point);
				var gTemp:Float = fromNode.G + traversalCost;
				
				if (gTemp < node.G)
				{
					node.parentNode = fromNode;
					walkableNodes.push(node);
				}
			}
			else
			{
				// If it's untested, set the parent and mark it OPEN
				node.parentNode = fromNode;
				node.state = NodeState.OPEN;
				walkableNodes.push(node);
			}
		}

		return walkableNodes;
	}
}

class Node {
    public var point:Point;
    public var isWalkable:Bool;
    public var G:Float;
    public var H:Float;
	public var F(get, null):Float;
    public var state:NodeState = NodeState.UNTESTED;
    @:isVar public var parentNode(default, set):Node;
	
    function get_F():Float {
		return G + H;
    }
	
	function set_parentNode(value:Node) { 
		G = value.G + Point.distance(point, value.point);
		parentNode = value;
		
		return value;
	}
	
	public function new(x:Int, y:Int, isWalkable:Bool, endPoint:Point)
	{
		point = new Point(x, y);
		this.isWalkable = isWalkable;
		this.H = Point.distance(point, endPoint);
		this.G = 0;
	}

	public function toString():String
	{
		return point.x + ", " + point.y + ":" + state;
	}
}
 
enum NodeState { UNTESTED; OPEN; CLOSED; }