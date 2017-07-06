package src;

/**
 * ...
 * @author Gin
 */
class Score 
{
	public static inline var scoreCorrectDisposal = 10;
	public static inline var scoreIncorrectDisposal = -5;
	
	private static var instance : Score;
	
	public var score : Int = 0;
	
	private var callback : Void -> Void;
	
	public function new() 
	{
		instance = this;
	}
	
	//Returns the instance of Score
	public static function getInstance():Score
	{
		return instance;
	}
	
	//Resets the score
	public function resetScore(){
		score = 0;
		if (callback != null){
			callback();
		}
		
	}
	
	//Changes the score by x amount
	public function changeScore(amount : Int){
		score += amount;
		if (callback != null){
			callback();
		}
	}
	
	//Sets the new callback when score gets updated.
	public function setCallBack(callback:Void->Void){
		this.callback = callback;
	}
	
	
}