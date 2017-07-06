package tiles.tiles;

import items.ItemChemical;
import DisposalType;
import levels.Level;
import src.Score;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.Assets;

/**
 * ...
 * @author Mark
 */
class TileDisposal extends TileBase implements IInteractable
{
	private var disposalType:DisposalType;

	public function new(x:Float, y:Float, type:Int, level:Level, disposalType:DisposalType)
	{
		super(x, y, type, level, false);

		this.disposalType = disposalType;
	}

	public function getDisposalType():DisposalType
	{
		return disposalType;
	}

	public function interact(player:Player)
	{
		if (Std.is(player.getItem(), ItemChemical))
		{
			var item:ItemChemical = cast(player.takeItem(), ItemChemical);
			var soundTransform = new SoundTransform(20);
			if (item.getChemical().disposalType == disposalType)
			{
				
				Score.getInstance().changeScore(Score.scoreCorrectDisposal);
				var sound:Sound = Assets.getSound("audio/correct_disposal.wav");
				sound.play(soundTransform);
			}
			else
			{
				Score.getInstance().changeScore(Score.scoreIncorrectDisposal);
				var sound:Sound = Assets.getSound("audio/incorrect_disposal.wav");
				sound.play(soundTransform);
			}
		}
	}

	public override function createNew(level:Level):TileBase
	{
		var tile = new TileDisposal (x, y, id, level, disposalType);
		tile.matrix = matrix.clone ();
		tile.tileset = tileset;
		return tile;
	}
}