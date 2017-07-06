package items;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.BitmapData;

/**
 * ...
 * @author Mark
 */
class Item extends Sprite
{
	public var displayName:String = "";
	public var displayImage:BitmapData = null;
	
	private var tileImage:Bitmap;

	public function new()
	{
		super();
	}

	public function setVisible(visible:Bool)
	{
		if (tileImage == null) return;

		visible ? addChild(tileImage) : removeChild(tileImage);
	}

}