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

		/*PENDING: exhibition move function.*/

	}

	/*A function to find an object from an array.*/
	ObjectMuseum FindObject(

		String 				_targetNameAltString	,
		List<ObjectMuseum> 	_targetObjectList

	){



	}

	String ExhibitionMoveString(

		String				_targetNameAltString	,
		List<ObjectMuseum>	_floorObjectMuseum		,
		List<ObjectMuseum>	_roomObjectMuseum		,
		List<ObjectMuseum> 	_exhibitionObjectMuseum

	){

		/*If this player has a parent (means that this is not the first move).
		PENDING: Missing function to remove this player from the
			old exhibition (exhibition before this player moved).*/
		if(exhibitionCurrentString != ""){

			/*PENDING: Remove this player from this exhibition.*/

		}

	}

}