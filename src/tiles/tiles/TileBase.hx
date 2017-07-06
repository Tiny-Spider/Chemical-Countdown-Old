package tiles.tiles;
import levels.Level;
import openfl.display.Tile;
import util.Point;

/**
 * A base for tiles
 */
class TileBase extends Tile
{
	public var isWalkable:Bool = true;
	
	private var level:Level;
	
	public function new(x:Float, y:Float, type:Int, level:Level, isWalkable:Bool) 
	{
		super(type, x, y);
		
		this.level = level;
		this.isWalkable = isWalkable;
	}
	
	public function update() { };
	
	public function getX():Int {
		return Math.floor(x / TileManager.tileSize);
	}
	
	public function getY():Int {
		return Math.floor(y / TileManager.tileSize);
	}
	
	public function getPoint():Point {
		return new Point(getX(), getY());
	}
	
	public function createNew(level:Level):TileBase {
		var tile = new TileBase (x, y, id, level, isWalkable);
		tile.matrix = matrix.clone ();
		tile.tileset = tileset;
		return tile;
	}
}