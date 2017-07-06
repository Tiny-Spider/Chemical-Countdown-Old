package;
import items.Item;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;
import tiles.tiles.TileBase;
import util.Point;
import tiles.TileManager;
import motion.Actuate;
import motion.easing.Linear;
import tiles.tiles.IInteractable;
import openfl.media.Sound;

/**
 * ...
 * @author Mark
 */
class Player extends Sprite
{
	private var playerSprite:Bitmap;
	private var item:Item;
	private var moveSpeed:Float = 0.3;
	private var currentDirection:Direction = Direction.UP;

	// Pathfinding
	private var path:Array<Point>;
	private var nextPoint:Point;
	private var interact:TileBase;
	private var navigating:Bool = false;
	
	public var onItemSwitch:Item -> Void;

	public function new()
	{
		super();

		playerSprite = new Bitmap(Assets.getBitmapData("img/player/down.png"));

		playerSprite.height = TileManager.tileSize;
		playerSprite.width = TileManager.tileSize;

		addChild(playerSprite);
	}

	// Set or updates the path the player has to move
	public function setPath(path:Array<Point>, interact:TileBase)
	{
		this.interact = interact;
		this.path = path;
		this.path.reverse();

		if (!navigating)
		{
			navigateNextPoint();
		}
	}

	// Move the character to the next point in the path
	private function navigateNextPoint()
	{
		// If there is no path or path is empty, end navigation
		if (path == null || path.length <= 0)
		{
			navigating = false;

			// See if we can still interact with something
			if (interact != null && Std.is(interact, IInteractable))
			{
				// Update the direction
				var direction:Direction = Point.getDirectionBetween(getPoint(), interact.getPoint());
				setDirection(direction);

				// Interact with the tile
				var interactable:IInteractable = cast(interact, IInteractable);
				interactable.interact(this);
			}

			return;
		}

		nextPoint = path.pop();

		// See if we can move to the next point
		if (nextPoint != null)
		{
			navigating = true;

			// Update direction
			var direction:Direction = Point.getDirectionBetween(getPoint(), nextPoint);
			setDirection(direction);

			// Get coords in world space
			var x:Int = nextPoint.x * TileManager.tileSize;
			var y:Int = nextPoint.y * TileManager.tileSize;

			// Move towards next point in linear fashion, and call navigateNextPoint after reaching destination
			Actuate.tween(this, moveSpeed, { x:x, y:y }).ease(Linear.easeNone).onComplete(navigateNextPoint);
		}
	}

	public function getItem():Item
	{
		return item;
	}

	public function takeItem():Item
	{
		var item:Item = this.item;
		this.item = null;
		
		onItemSwitch(this.item);
		
		
		
		return item;
	}

	public function setItem(item:Item)
	{
		this.item = item;
		
		if (item != null) {
			item.setVisible(false);
		}
		
		onItemSwitch(this.item);
		var sound:Sound = Assets.getSound("audio/button/BUTTON Very Bright Click (mono).wav");
		sound.play();
	}

	public function getX():Int
	{
		return Math.floor(x / TileManager.tileSize);
	}

	public function getY():Int
	{
		return Math.floor(y / TileManager.tileSize);
	}

	public function getPoint():Point
	{
		return new Point(getX(), getY());
	}

	public function getNextPoint():Point
	{
		return nextPoint != null ? nextPoint : getPoint();
	}
	
	public function setPosition(point:Point) {
		x = point.x * TileManager.tileSize;
		y = point.y * TileManager.tileSize;
	}

	private function setDirection(direction:Direction)
	{
		if (currentDirection != direction)
		{
			var directionString = Std.string(direction).toLowerCase();

			playerSprite.bitmapData = Assets.getBitmapData('img/player/$directionString.png');

			currentDirection = direction;
		}
	}
}