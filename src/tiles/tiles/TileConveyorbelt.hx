package tiles.tiles;

import items.Item;
import levels.Level;
import motion.Actuate;
import motion.easing.Linear;
import openfl.display.Tile;
import util.Point;
import util.Point.Direction;

/**
 * ...
 * @author Mark
 */
class TileConveyorbelt extends TileAnimated implements IInteractable
{
	private var currentItem:Item;
	private var moveSpeed:Float = 1.5;
	private var itemState:ItemState = ItemState.EMPTY;
	private var previousPoint:Point;

	public function new(x:Float, y:Float, frameTime:Int, types:Array<Int>, level:Level)
	{
		super(x, y, frameTime, types, level, false);
	}

	public function addItem(item:Item, point:Point):Bool
	{
		var id:Int = getX();
		
		if (currentItem == null)
		{
			//trace('addItem ($id): $item currentId: $currentItem');
			currentItem = item;

			currentItem.x = x - (TileManager.tileSize / 2.0);
			currentItem.y = y;// + (TileManager.tileSize / 2.0);

			enterItem();
			previousPoint = point;
			
			return true;
		}
		
		return false;
	}

	public function hasItem():Bool
	{
		return currentItem != null;
	}

	public function interact(player:Player)
	{
		if (currentItem != null && player.getItem() == null)
		{
			player.setItem(currentItem);

			Actuate.stop(currentItem, null, false, false);
			
			currentItem = null;
		}
	}

	public override function update()
	{
		super.update();

		if (itemState == ItemState.HOLD)
		{
			exitItem();
		}
	}

	private function enterItem()
	{
		itemState = ItemState.ENTERING;

		var targetX:Float = x;// + (TileManager.tileSize / 2.0);
		var targetY:Float = y;// + (TileManager.tileSize / 2.0);
		
		var id:Int = getX();
		
		//trace('ENTER ($id): x:$x - y:$y : targetX:$targetX - targetY:$targetY');
		
		Actuate.tween(currentItem, moveSpeed, { x:targetX, y:targetY }).ease(Linear.easeNone).onComplete(holdItem);
	}

	private function holdItem()
	{
		itemState = ItemState.HOLD;
		exitItem();
	}

	private function exitItem()
	{
		for (point in getPoint().getAdjacent())
		{
			if (currentItem == null) {
				return;
			}
			
			var tile:TileBase = level.tileMapForeground.getTile(point);

			if (tile != null && !tile.getPoint().equals(previousPoint) && Std.is(tile, TileConveyorbelt))
			{
				var conveyorbelt:TileConveyorbelt = cast(tile, TileConveyorbelt);

				if (conveyorbelt.hasItem())
				{
					continue;
				}

				itemState = ItemState.EXITING;

				var targetX:Float = x + (TileManager.tileSize / 2.0);
				var targetY:Float = y;// + (TileManager.tileSize / 2.0);
				
				var id:Int = getX();
		
				//trace('EXIT ($id): x:$x - y:$y : targetX:$targetX - targetY:$targetY');

				Actuate.tween(currentItem, moveSpeed, { x:targetX, y:targetY }).ease(Linear.easeNone).onComplete(pushItem, [conveyorbelt]);
				
				return;
			}
		}
	}

	private function pushItem(conveyorbelt:TileConveyorbelt)
	{
		var id:Int = getX();
		var newId:Int = conveyorbelt.getX();
		//trace('pushItem ($id > $newId): $currentItem');
		conveyorbelt.addItem(currentItem, getPoint());

		currentItem = null;
		itemState = ItemState.EMPTY;
	}
	
	public override function createNew(level:Level):TileBase
	{
		var tile = new TileConveyorbelt (x, y, frameTime, types, level);
		tile.matrix = matrix.clone ();
		tile.tileset = tileset;
		return tile;
	}
}

	enum ItemState
	{
		ENTERING;
		HOLD;
		EXITING;
		EMPTY;
	}