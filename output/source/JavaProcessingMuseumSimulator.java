import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class JavaProcessingMuseumSimulator extends PApplet {

public void setup		(){

	List<ObjectMuseum> floorObjectList			= Arrays.asList(new ObjectMuseum(new Name("FLR_TES", "Floor Test")		, "XXX_XXX", "FLR", "XXX"));
	List<ObjectMuseum> roomObjectList			= Arrays.asList(

		new ObjectMuseum(new Name("ROM_TES", "Room Test")		, "FLR_TES", "ROM", "XXX"),
		new ObjectMuseum(new Name("ROM_TET", "Room Tett")		, "FLR_TES", "ROM", "XXX")

	);
	List<ObjectMuseum> exhibitionObjectList		= Arrays.asList(new ObjectMuseum(new Name("EXH_TES", "Exhibition Test")	, "ROM_TES", "EXH", "XXX"));
	floorObjectList				.get(0).SetParentChildObjectList	(roomObjectList 			);
	roomObjectList				.get(0).SetParentObject				(floorObjectList			);
	roomObjectList				.get(0).SetParentChildObjectList	(exhibitionObjectList		);
	roomObjectList				.get(1).SetParentObject				(floorObjectList			);
	roomObjectList				.get(1).SetParentChildObjectList	(exhibitionObjectList		);
	exhibitionObjectList		.get(0).SetParentObject				(roomObjectList				);

	/*
	exhibitionObjectList		.get(0).RemoveChildObjectList		(roomObjectList				);
	exhibitionObjectList		.get(0).SetParentNameAltString		("ROM_TET"					);
	exhibitionObjectList		.get(0).SetParentObject 			(roomObjectList				);
	exhibitionObjectList		.get(0).SetParentChildObjectList	(roomObjectList				);
	*/

	exhibitionObjectList 		.get(0).DetermineParentVoid			(roomObjectList, "ROM_TET"	);

	println(

		exhibitionObjectList	.get(0).parentObject.nameAltString

	);
	/*
	ObjectMuseum testFloorObject		= new ObjectMuseum(new Name("FLR_TES", "Floor Test")		, "XXX_XXX", "FLR", "XXX");	
	ObjectMuseum testRoomObject			= new ObjectMuseum(new Name("ROM_TES", "Room Test")			, "FLR_TES", "ROM", "XXX");	
	ObjectMuseum testExhibitionObject 	= new ObjectMuseum(new Name("EXH_TES", "Exhibition Test")	, "ROM_TES", "EXH", "XXX");
	*/

}
class   Name                        {

    String          nameAltString   = "";
    String          nameFullString  = "";
    Name                            (String _nameAltString, String _nameFullString){

        nameAltString               = _nameAltString;
        nameFullString              = _nameFullString;

    }

};


/*A class for museum object.
The museum objects within this application are things that can interract with visitor.
For example floor, room, and exhibition.*/
class   ObjectMuseum                            {

    List<ObjectMuseum>  childObjectList         = new ArrayList<ObjectMuseum>();    /*This list contains all object that is sub - ordinate of this object..*/

    List<ObjectMuseum>  floorObjectList         = new ArrayList<ObjectMuseum>();    /*This list contains all possible floor object.*/
    List<ObjectMuseum>  roomObjectList          = new ArrayList<ObjectMuseum>();    /*This list contains all possible room object.*/
    List<ObjectMuseum>  exhibitionObjectList    = new ArrayList<ObjectMuseum>();    /*This list contains all possible exhibition object.*/

    int                 indexGlobalInt          = -1;                               /*This is an index number of the location of this object in its respective list.*/
    int                 indexLocalInt           = -1;                               /*This is an index number of the location of this object within its parent child object list.*/

    Name                nameObject              = null;                             /*Name object that contains the alternative name and the full name of this object.*/
    String              nameAltString           = "";                               /*This variable is intended solely to store the alternative name of this object.*/
    String              nameFullString          = "";                               /*This variable is intended solely to store the full name of this object.*/

    ObjectMuseum        parentObject            = null;                             /*The object parent of this object, which means this object should be inside the parent object's child object list.*/
    String              parentNameAltString     = "";                               /*The alternative name of the parent object.*/
    
    String              typeString              = "";                               /*The type of this object (the only possible values are "FLR", "ROM", and "EXH").*/

    List<String>        tagStringList           = new ArrayList<String>();          /*The tags for whit museum object.*/

    int                 visitorCurrentInt       = 0;                                /*This museum object current visitor.*/
    int                 visitorTotalInt         = 0;                                /*This museum objecy total visitor.*/

    /*These are some user interfaces related variables.*/
    boolean             activeBoolean           = false;

    ObjectMuseum                                (

        Name                                    _nameObject,
        String                                  _parentNameAltString,
        String                                  _typeString,
        String...                               _tagStringList

    ){

        /*We put in the name object from the first argument of this class.
        The name object is an object that contains only two variables,
            the alternative name of an object and the full name of an object
        For processing within this whoel application we used the alternative name.*/
        nameObject                              = _nameObject;
        nameAltString                           = nameObject.nameAltString;
        nameFullString                          = nameObject.nameFullString;

        /*We put the alternative name of the parent here.
        For example the anternative name of an exhibition object must be
            an object with type string of "ROM" which mean the parent object
            is an room object.*/
        parentNameAltString                     = _parentNameAltString;

        /*This is the type of this object.
        The only possible input will be,
            "FLR" if this object is a room object,
            "ROM" if this object is a room object,
            "EXH" if this object is an exhibition object.*/
        typeString                              = _typeString;

        for(String tagString : _tagStringList){ tagStringList.add(tagString); }

        /*SetIndexGlobalInt();*/
        /*SetIndexLocalInt();*/

    }

    /*A set of functions to move this object into a new parent object.*/
    public void DetermineParentVoid(

        List<ObjectMuseum>  _targetObjectList       , 
        String              _parentNameAltString

    ){

        RemoveChildObjectList       (_targetObjectList      );
        SetParentNameAltString      (_parentNameAltString   );
        SetParentObject             (_targetObjectList      );
        SetParentChildObjectList    (_targetObjectList      );

    }

    /*A function to remove this object from child object of its parent.*/
    public List<ObjectMuseum> RemoveChildObjectList(List<ObjectMuseum> _targetObjectList)      {

        for(int i = 0; i < parentObject.childObjectList.size(); i ++){

            if(parentObject.childObjectList.get(i).nameAltString.equals(nameAltString)){ parentObject.childObjectList.remove(i); }

        }

        return _targetObjectList;

    }

    /*A function to add the children of this object into childObjectList.*/
    public List<ObjectMuseum> SetParentChildObjectList(List<ObjectMuseum> _targetObjectList)   {

        if(childObjectList.size() > 0){ childObjectList.clear(); }                                                                  /*Clear the previous child object array.*/

        for(int i = 0;          i < _targetObjectList.size(); i ++){                                                                /*Itarete through all the object list to find whether or not there is a museum object that refers this object as its parent.*/

            if(nameAltString    == _targetObjectList.get(i).parentNameAltString){ childObjectList.add(_targetObjectList.get(i)); }  /*If the parent object from the _targetObjectList is the same with this object name then add the object into this object child object list.*/

        }

        return                  childObjectList;

    }

    /*A function to set this object parent.*/
    public ObjectMuseum SetParentObject(List<ObjectMuseum> _targetObjectList)                  {

        /*Iterate through all parent object list to find this object parent object.*/
        for(int i = 0; i < _targetObjectList.size(); i ++){

            if(parentNameAltString == _targetObjectList.get(i).nameAltString){ parentObject = _targetObjectList.get(i); break; }

        }

        return parentObject;

    }

    /*Set the parent alternative name String.*/
    public String SetParentNameAltString(String _parentNameAltString)                          {

        parentNameAltString     = _parentNameAltString;
        return                  parentNameAltString;

    }

};
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "JavaProcessingMuseumSimulator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
