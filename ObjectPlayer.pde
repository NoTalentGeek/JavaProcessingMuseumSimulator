import java.util.*;

class ObjectPlayer{

	/*Constructor.*/
	ObjectPlayer(

		List<ObjectMuseum> 	_floorObjectList		,
		List<ObjectMuseum> 	_roomObjectList			,
		List<ObjectMuseum> 	_exhibitionObjectList	,
		List<ObjectPlayer> 	_playerObjectList		,
		String 				_exhibitionStartString

	){

		List<ObjectMuseum> floorObjectList 			= _floorObjectList;
		List<ObjectMuseum> roomObjectList 			= _roomObjectList;
		List<ObjectMuseum> exhibitionObjectList 	= _exhibitionObjectList;
		List<ObjectPlayer> playerObjectList 		= _playerObjectList;

		String 			exhibitionCurrentString		= "";
		List<String> 	exhibitionTargetStringList 	= new ArrayList<String>();
		List<String> 	exhibitionVisitedStringList	= new ArrayList<String>();
		List<String> 	exhibitionTagStringList 	= new ArrayList<String>();

		int 			timeCurrentExhibitionInt 	= -1;
		int 			timeTotalInt 				= -1;

	}

}