import java.util.*;

class ObjectPlayer{

	List<ObjectMuseum> floorObjectList 			= new ArrayList<ObjectMuseum>();
	List<ObjectMuseum> roomObjectList 			= new ArrayList<ObjectMuseum>();
	List<ObjectMuseum> exhibitionObjectList 	= new ArrayList<ObjectMuseum>();
	List<ObjectPlayer> playerObjectList 		= new ArrayList<ObjectPlayer>();

	String 			exhibitionCurrentString		= "";
	List<String> 	exhibitionTargetStringList 	= new ArrayList<String>();
	List<String> 	exhibitionVisitedStringList	= new ArrayList<String>();
	List<String> 	exhibitionTagStringList 	= new ArrayList<String>();

	int 			timeCurrentExhibitionInt 	= -1;
	int 			timeTotalInt 				= -1;

	/*Constructor.*/
	ObjectPlayer(

		List<ObjectMuseum> 	_floorObjectList		,
		List<ObjectMuseum> 	_roomObjectList			,
		List<ObjectMuseum> 	_exhibitionObjectList	,
		List<ObjectPlayer> 	_playerObjectList		,
		String 				_exhibitionStartString

	){

		floorObjectList			= _floorObjectList;
		roomObjectList 			= _roomObjectList;
		exhibitionObjectList 	= _exhibitionObjectList;
		playerObjectList 		= _playerObjectList;

		/*Pending exhibition move function.*/

	}

}