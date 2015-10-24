import java.util.*;

class TagCounter{

	String 	tagNameString = "";
	int 	tagCounterInt = -1;
	TagCounter(String _tagNameString, int _tagCounterInt){

		tagNameString = _tagNameString;
		tagCounterInt = _tagCounterInt;

	}

}

class ObjectPlayer{

	String 			exhibitionCurrentString		= "";
	List<String> 	exhibitionTargetStringList 	= new ArrayList<String>();
	List<String> 	exhibitionVisitedStringList	= new ArrayList<String>();

	/*We need to go deeper,
	We need to create a list of a list.
	The second stage list first element will be a String filled with tag name.
	The second stage list second element will be an int filled with tag counter*/
	List<List<String>> 
					exhibitionTagStringList		= new ArrayList<List<String>>();


	int 			timeCurrentExhibitionInt 	= -1;
	int 			timeTotalInt 				= -1;

	/*Constructor.*/
	ObjectPlayer(String	_exhibitionStartString)				{

		/*PENDING: exhibition move function.*/

	}

	/*A function to add or remove this object from parent child object.*/
	void AddRemoveChildVoid(boolean _isAdd)					{

		ObjectMuseum exhibitionCurrentObject 				= FindObject(exhibitionCurrentString, exhibitionObjectList);
		if 		(_isAdd == true )							{ exhibitionCurrentObject.childObjectList.add(this); 	}
		else if (_isAdd == false)							{ exhibitionCurrentObject.childObjectList.remove(this); }

	}

	/*A function to find an object from an array.*/
	ObjectMuseum FindObject(

		String 				_targetNameAltString	,
		List<ObjectMuseum> 	_targetObjectList

	){

		ObjectMuseum objectMuseum = null;
		for(int i = 0; i < _targetObjectList.size(); i ++){

			if(_targetObjectList.get(i).nameAltString.equals(_targetNameAltString)){

				objectMuseum = _targetObjectList.get(i);

			}

		}

		return objectMuseum;

	}

	String ExhibitionMoveString(String _targetNameAltString)	{

		/*Variable to hold currently visited museum object.*/
		ObjectMuseum exhibitionCurrentObject 	= null;
		ObjectMuseum roomCurrentObject 			= null;
		ObjectMuseum floorCurrentObject 		= null;

		/*If this player has a parent (means that this is not the first move).
		So that, this if statement is only when the player is first time
			initiated.*/
		if(exhibitionCurrentString != ""){

			/*Remove this player from the current child list of the parent,
				before we move this player into another exhibition.*/
			AddRemoveChildVoid(false);

			exhibitionCurrentObject		= FindObject(exhibitionCurrentString							, exhibitionObjectList	);
			roomCurrentObject			= FindObject(exhibitionCurrentObject	.parentNameAltString	, roomObjectList		);
			floorCurrentObject 			= FindObject(roomCurrentObject			.parentNameAltString	, floorObjectList		);
			exhibitionCurrentObject		.visitorCurrentInt --;
			roomCurrentObject			.visitorCurrentInt --;
			floorCurrentObject			.visitorCurrentInt --;

		}

		exhibitionCurrentString 		= _targetNameAltString;				/*Chanhe the String for current exhibition.*/
		exhibitionVisitedStringList		.add(exhibitionCurrentString);		/*Add the current exhibition to visited exhibition list.*/
		
		/*Re - instantiated all newly visited museum objects.*/
		exhibitionCurrentObject			= FindObject(exhibitionCurrentString							, exhibitionObjectList	);
		roomCurrentObject				= FindObject(exhibitionCurrentObject	.parentNameAltString	, roomObjectList		);
		floorCurrentObject 				= FindObject(roomCurrentObject			.parentNameAltString	, floorObjectList		);

		/*Add total number museum visit.*/
		exhibitionCurrentObject			.visitorCurrentInt	++;
		roomCurrentObject				.visitorCurrentInt	++;
		floorCurrentObject				.visitorCurrentInt	++;
		exhibitionCurrentObject			.visitorTotalInt	++;
		roomCurrentObject				.visitorTotalInt	++;
		floorCurrentObject				.visitorTotalInt	++;

		/*PROTOTYPE: Here you need to create a function to add tags into player's preferences.
		PENDING: After you made the prototype here please make it into a function to make
			this source code easier to read.*/
		for(int i = 0; i < exhibitionCurrentObject.tagStringList.size(), i ++){



		}

		return _targetNameAltString;

	}

}