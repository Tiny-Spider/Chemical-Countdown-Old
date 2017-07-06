package;

import lime.Assets;

/**
 * ...
 * @author Gin
 */
class ChemicalManager
{
	private var chemicalList:Array<Chemical> = new Array<Chemical>();
	private static var instance : ChemicalManager;
	
	
	public function new()
	{
		instance = this;
		createChemicalList();
	}
	
	//Returns the instance of ChemicalManager
	public static function getInstance():ChemicalManager{
		return instance;
	}
	
	//temp Creates the chemical list
	private function createChemicalList()
	{
		//chemicalList.push(new Chemical("Sulphuric Acid", RED, TRIANGLE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Hydrochloric Acid", RED, ROUND, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Nitric Acid", RED, SQUARE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Sodium Hydroxide", GREEN, TRIANGLE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("potassium Hydroxide", GREEN, ROUND, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Lithium Hydroxide", GREEN, SQUARE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Ethanol",BLUE,TRIANGLE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Methanol",BLUE,ROUND, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Acetone",BLUE,SQUARE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Chlorine",PURPLE,TRIANGLE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Fluorine",PURPLE,ROUND, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Bromine",PURPLE,SQUARE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Sodium Chloride",YELLOW,TRIANGLE, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Silver Nitrate",YELLOW,ROUND, DisposalType.ACIDIC));
		//chemicalList.push(new Chemical("Mercuric Chloride", YELLOW, SQUARE, DisposalType.ACIDIC));
		
		chemicalList.push(new Chemical("Sulphuric Acid", RED, TRIANGLE, DisposalType.ACIDIC,"img/chemicals/flask_triangle_red.png"));
		chemicalList.push(new Chemical("Hydrochloric Acid", RED, ROUND, DisposalType.ACIDIC,"img/chemicals/flask_round_red.png"));
		chemicalList.push(new Chemical("Nitric Acid", RED, SQUARE, DisposalType.ACIDIC, "img/chemicals/flask_rectangle_red.png"));
		chemicalList.push(new Chemical("Sodium Hydroxide", GREEN, TRIANGLE, DisposalType.ACIDIC,"img/chemicals/flask_triangle_green.png"));
		chemicalList.push(new Chemical("Potassium Hydroxide", GREEN, ROUND, DisposalType.ACIDIC,"img/chemicals/flask_round_green.png"));
		chemicalList.push(new Chemical("Lithium Hydroxide", GREEN, SQUARE, DisposalType.ACIDIC,"img/chemicals/flask_rectangle_green.png"));
		chemicalList.push(new Chemical("Ethanol",BLUE,TRIANGLE, DisposalType.ACIDIC,"img/chemicals/flask_triangle_blue.png"));
		chemicalList.push(new Chemical("Methanol",BLUE,ROUND, DisposalType.ACIDIC,"img/chemicals/flask_round_blue.png"));
		chemicalList.push(new Chemical("Acetone",BLUE,SQUARE, DisposalType.ACIDIC,"img/chemicals/flask_rectangle_blue.png"));
		chemicalList.push(new Chemical("Chlorine",PURPLE,TRIANGLE, DisposalType.ACIDIC,"img/chemicals/flask_triangle_purple.png"));
		chemicalList.push(new Chemical("Fluorine",PURPLE,ROUND, DisposalType.ACIDIC,"img/chemicals/flask_round_purple.png"));
		chemicalList.push(new Chemical("Bromine",PURPLE,SQUARE, DisposalType.ACIDIC,"img/chemicals/flask_rectangle_purple.png"));
		chemicalList.push(new Chemical("Sodium Chloride",YELLOW,TRIANGLE, DisposalType.ACIDIC,"img/chemicals/flask_triangle_yellow.png"));
		chemicalList.push(new Chemical("Silver Nitrate",YELLOW,ROUND, DisposalType.ACIDIC,"img/chemicals/flask_round_yellow.png"));
		chemicalList.push(new Chemical("Mercuric Chloride",YELLOW,SQUARE, DisposalType.ACIDIC,"img/chemicals/flask_rectangle_yellow.png"));
	}
	
	//Returns a random chemical
	public function getRandomChemical():Chemical
	{
		return chemicalList[Math.floor(Math.random() * chemicalList.length)];
	}
}

enum ChemicalShape
{
	TRIANGLE;
	ROUND;
	SQUARE;
}

enum ChemicalColor
{
	RED;
	BLUE;
	GREEN;
	YELLOW;
	PURPLE;
}