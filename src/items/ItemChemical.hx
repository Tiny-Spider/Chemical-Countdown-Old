package items;

import items.Item;
import openfl.display.Bitmap;
import openfl.utils.Assets;
import tiles.TileManager;

/**
 * ...
 * @author Mark
 */
class ItemChemical extends Item
{
	private var chemical:Chemical;

	public function new(chemical:Chemical) 
	{
		super();
		
		this.chemical = chemical;
		
		displayName = chemical.name;
		displayImage = chemical.image;
		
		tileImage = new Bitmap(displayImage);
		
		tileImage.height = TileManager.tileSize /2;
		tileImage.width = TileManager.tileSize /2;
		
		setVisible(true);
	}
	
	public function getChemical():Chemical {
		return chemical;
	}
	
}