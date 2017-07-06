package;

import sys.db.Sqlite;
import sys.db.ResultSet;
import sys.db.Connection;

/**
 * Local leaderboard class
 */
class Leaderboards 
{
	var connection:Connection;
	
	public function new() 
	{
		openConnection();
		
		var resultSet:ResultSet = connection.request("SELECT * FROM highscores");
		
		for (row in resultSet){
			trace(row.name);
		}
		
	}
	
	function openConnection(){
		connection = Sqlite.open("data/database.db");
	}
	
	function closeConnection(){
		connection.close();
	}

	
}