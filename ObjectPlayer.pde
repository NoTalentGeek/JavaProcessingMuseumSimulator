import java.util.*;

/*Create an internal class to be put in the list for easiness.
This is because List in Java must be homogenous.*/
class TagCounter{

	String 	tagNameString = "";
	int 	tagCounterInt = -1;

	TagCounter(){}
	void 	SetTagNameStringVoid	(String _tagNameString)	{ tagNameString = _tagNameString; }
	void 	SetTagCounterIntVoid	(int _tagCounterInt)	{ tagCounterInt = _tagCounterInt; }
	int 	GetTagCounterInt		(){ return tagCounterInt; }
	String 	GetTagNameString		(){ return tagNameString; }

}

class ObjectPlayer{

	String 				exhibitionCurrentString		= "";
	List<String> 		exhibitionTargetStringList 	= new ArrayList<String>();
	List<String> 		exhibitionVisitedStringList	= new ArrayList<String>();
	List<TagCounter>	exhibitionTagCounterList 	= new ArrayList<TagCounter>();

	List<ObjectPlayer>	playerSiblingObjectList 	= new ArrayList<ObjectPlayer>();
	int 				playerSiblingIndexInt		= -1;

	int 				timeCurrentExhibitionInt 	= -1;
	int 				timeTotalInt 				= -1;

	/*Constructor.*/
	ObjectPlayer(String	_exhibitionStartString)				{

		ExhibitionMoveObject(_exhibitionStartString);

	}

	/*A function to either add the tag or increase the tag value in this player.*/
	void AddTagCounterVoid(

		ObjectMuseum _exhibitionCurrentObject

	){

		for(int i = 0; i < _exhibitionCurrentObject.tagStringList.size(); i ++){

			/*Create new tag counter to count how many tags are in the user preference.*/
			TagCounter 	tagCounter 		= new TagCounter();
						tagCounter 		.SetTagNameStringVoid(_exhibitionCurrentObject.tagStringList.get(i));

			boolean 	newBool			= true;		/*Whether the tag is new to the array or there is already existing one.*/
            int 		indexInt		= -1;    	/*If there is the corresponding tag already in the array return its index with this variable, otherwise it keeps -1.*/

            /*Iterate through all tag those already gathered to find if there any tag that
            	is already registered in this player.*/
            for(int j = 0; j < exhibitionTagCounterList.size(); j ++){

            	if(

            		exhibitionTagCounterList.get(j).GetTagNameString().equals(

            			tagCounter.GetTagNameString()

            		)

            	){

            		newBool 			= false;
            		indexInt			= j;

            	}

            }

            /*If the tag received is new then set the initial tag value to 1 and
            	add the tag to the tag counter.*/
            if 		(newBool == true ){

            	tagCounter 					.SetTagCounterIntVoid(1);
            	exhibitionTagCounterList 	.add(tagCounter);

            }
            /*If the tag received is alredy filled in before then increase the tag counter.*/
            else if (newBool == false){

            	exhibitionTagCounterList.get(indexInt).SetTagCounterIntVoid(tagCounter.GetTagCounterInt() + 1);

            }

		}

	}

	/*A function to add or remove this object from parent child object.*/
	void AddRemoveChildVoid(boolean _isAdd)					{

		ObjectMuseum exhibitionCurrentObject 				= FindObject(exhibitionCurrentString, exhibitionObjectList);
		if 		(_isAdd == true )							{ exhibitionCurrentObject.childPlayerObjectList.add(this); 		}
		else if (_isAdd == false)							{ exhibitionCurrentObject.childPlayerObjectList.remove(this); 	}

	}

	/*A function to return the position of this player in the player sibling list*/
	int SetPlayerSiblingIndexInt(

		List<ObjectPlayer> _playerSiblingObjectList

	){

		playerSiblingIndexInt = -1;
		for(int i = 0; i < _playerSiblingObjectList.size(); i ++){ if(_playerSiblingObjectList.get(i) == this){ playerSiblingIndexInt = i; } }
		return playerSiblingIndexInt;

	}

	/*A function to automatically add other player of which in the same exhibition.*/
	List<ObjectPlayer> SetSiblingObjectList()				{

		playerSiblingObjectList = new ArrayList<ObjectPlayer>();

		for(int i = 0; i < playerObjectList.size(); i ++){

			if(playerObjectList.get(i).exhibitionCurrentString.equals(exhibitionCurrentString)){

				playerSiblingObjectList.add(playerObjectList.get(i));

			}

		}

		/*Set the new index of this player object.*/
		playerSiblingIndexInt = SetPlayerSiblingIndexInt(playerSiblingObjectList);

		return playerSiblingObjectList;

	}

	/*A function to move this player into new exhibition and add the tags to the tag coutner list.*/
	ObjectMuseum ExhibitionMoveObject(

		String _targetNameAltString

	){

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

		AddTagCounterVoid 				(exhibitionCurrentObject);
		AddRemoveChildVoid 				(true);
		
		/*For everytime a player move to another exhibition iterate through all player to re - add the siblings.*/
		for(int i = 0; i < playerObjectList.size(); i ++){ playerObjectList.get(i).SetSiblingObjectList(); }

		return exhibitionCurrentObject;

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

}