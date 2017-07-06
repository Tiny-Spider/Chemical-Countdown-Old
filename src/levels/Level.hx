package levels;

import items.Item;
import items.ItemChemical;
import levels.LevelData;
import openfl.display.Sprite;
import openfl.events.Event;
import tiles.TileMapCustom;
import tiles.tiles.TileBase;
import util.FPS_Mem;
import openfl.events.MouseEvent;
import util.Point;
import tiles.tiles.IInteractable;
import tiles.tiles.TileDisposal;
import motion.Actuate;
import tiles.tiles.TileConveyorbelt;
import tiles.TileManager;
import openfl.Lib;
import src.Score;

/**
 * Level class contains the world
 */
class Level extends Sprite
{
	
	public static inline var scale_X = 0.5;
	public static inline var scale_Y = 0.5;
	
	public var tileMapBackground:TileMapCustom;
	public var tileMapForeground:TileMapCustom;
	
	public var player:Player;
	
	private var mapWidth:Int;
	private var mapHeight:Int;

	private var levelData:LevelData;
	private var mapData:Array<Array<Bool>>;

	public function new(levelData:LevelData)
	{
		super();

		this.levelData = levelData;
		
		// Map settings
		mapWidth = levelData.backgroundData[0].length;
		mapHeight = levelData.backgroundData.length;

		// Tilemaps
		tileMapBackground = new TileMapCustom(mapWidth, mapHeight, this);
		tileMapForeground = new TileMapCustom(mapWidth, mapHeight, this);

		tileMapBackground.create(levelData.backgroundData);
		tileMapForeground.create(levelData.foregroundData);

		addChild(tileMapBackground);
		addChild(tileMapForeground);

		// Create pathfinding data from foreground
		mapData = tileMapForeground.createPathfindMap();

		// Player
		player = new Player();
		player.setPosition(levelData.playerSpawnPoint);
		
		addChild(player);

		// Listener for player movement
		addEventListener(MouseEvent.CLICK, onClick);
		
		// Spawn potions
		Actuate.timer(levelData.potionSpawnSpeed).onRepeat(insertRandomItem).repeat(levelData.potionAmount);
	}
	
	public function centerLevel() {
		this.scaleX = scale_X;
		this.scaleY = scale_Y;
		
		x = (Lib.current.stage.stageWidth / 2.0) - (((mapWidth * TileManager.tileSize) / 2.0) * scaleX) + 100; //TEMP +100 for item UI
		y = (Lib.current.stage.stageHeight / 2.0) - (((mapHeight * TileManager.tileSize) / 2.0) * scaleY) + 20;
	}

	private function onClick(e:MouseEvent)
	{
		// Convert mouse coords to Point and try get Tile at that point
		var point:Point = tileMapForeground.mouseToPoint(mouseX, mouseY);
		var tile:TileBase = tileMapForeground.getTile(point);
		var interact:TileBase = null;

		// If target tile is not walkable
		if (tile != null && !tile.isWalkable)
		{
			// See if we can interact with it
			if (Std.is(tile, IInteractable))
			{
				interact = tile;
			}

			var direction:Direction = Point.getDirectionBetween(point, player.getPoint());
			point = getNextOpenPoint(point, direction);
		}

		// Create path and set it on the player
		var path:Array<Point> = new Pathfinder(player.getNextPoint(), point, mapData).findPath();
		player.setPath(path, interact);

		trace('Clicked Tile: $tile');
	}
	
	private function insertRandomItem() {
		var item:Item = new ItemChemical(new ChemicalManager().getRandomChemical());
		var tile:TileBase = tileMapForeground.getTile(levelData.potionSpawnPoint);
		
		// See if it is conveyorbelt
		if (Std.is(tile, TileConveyorbelt)) {
			var conveyor:TileConveyorbelt = cast(tile, TileConveyorbelt);
			
			// Try to spawn the item otherwise punish the player
			if (conveyor.addItem(item, levelData.potionSpawnPoint)) {
				addChild(item);
			} else {
				Score.getInstance().changeScore( -30);
			}
		}
	}

	// Get a nearby open tile, otherwise return the input (which will fail the pathfinding)
	private function getNextOpenPoint(centerPoint:Point, direction:Direction):Point
	{
		for (point in Point.getAdjacentDirectionalPoints(centerPoint, direction))
		{
			if (mapData[point.x][point.y])
			{
				return point;
			}
		}

		return centerPoint;
	}
}