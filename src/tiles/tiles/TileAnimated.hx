package tiles.tiles;
import levels.Level;
import openfl.display.Tile;
import tiles.tiles.TileBase;

/**
 * An animated tile
 */
class TileAnimated extends TileBase
{
	private var types:Array<Int>;
	private var frameTime:Int;

	private var typeIndex = 0;
	private var currentFrameTime:Int = 0;
	
	public function new(x:Float, y:Float, frameTime:Int, types:Array<Int>, level:Level, isWalkable:Bool)
	{
		super(x, y, types[typeIndex], level, isWalkable);

		this.frameTime = frameTime;
		this.types = types;
	}

	public override function update()
	{
		currentFrameTime++;

		if (currentFrameTime >= frameTime)
		{
			typeIndex = (typeIndex + 1) % (types.length - 1);
			currentFrameTime = 0;

			id = types[typeIndex];
		}
	}
	
	public override function createNew(level:Level):TileBase {
		var tile = new TileAnimated (x, y, frameTime, types, level, isWalkable);
		tile.matrix = matrix.clone ();
		tile.tileset = tileset;
		return tile;
	}
}