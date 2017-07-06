package levels;
import util.Point;

/**
 * ...
 * @author Mark
 */
class LevelData 
{
	public var potionSpawnSpeed:Float;
	public var potionAmount:Int;
	public var potionSpawnPoint:Point;
	public var playerSpawnPoint:Point;
	public var backgroundData:Array<Array<Int>>;
	public var foregroundData:Array<Array<Int>>;

	public function new(potionSpawnSpeed:Float, potionAmount:Int, potionSpawnPoint:Point, playerSpawnPoint:Point, backgroundData:Array<Array<Int>>, foregroundData:Array<Array<Int>>) 
	{
		this.potionSpawnSpeed = potionSpawnSpeed;
		this.potionAmount = potionAmount;
		this.potionSpawnPoint = potionSpawnPoint;
		this.playerSpawnPoint = playerSpawnPoint;
		this.backgroundData = backgroundData;
		this.foregroundData = foregroundData;
	}
	
}