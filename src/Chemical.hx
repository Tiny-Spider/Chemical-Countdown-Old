package;

import flash.display.Bitmap;
import ChemicalManager.ChemicalColor;
import ChemicalManager.ChemicalShape;
import DisposalType;
import openfl.display.BitmapData;
import openfl.Assets;

/**
 * ...
 * @author Gin
 */
class Chemical
{
	public var image:BitmapData;
	public var name:String;
	public var color:ChemicalColor;
	public var shape:ChemicalShape;
	public var disposalType:DisposalType;

	public function new(name:String, color:ChemicalColor, shape:ChemicalShape, disposalType:DisposalType , imgPath:String)
	{
		this.name = name;
		this.color = color;
		this.shape = shape;
		this.disposalType = disposalType;
		
		image = Assets.getBitmapData(imgPath);
	}
}