import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
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

/*Determine global variable.s.*/
List<ObjectMuseum>      floorObjectList         = new ArrayList<ObjectMuseum>();
List<ObjectMuseum>      roomObjectList          = new ArrayList<ObjectMuseum>();
List<ObjectMuseum>      exhibitionObjectList    = new ArrayList<ObjectMuseum>();
List<ObjectPlayer>      playerObjectList        = new ArrayList<ObjectPlayer>();

public void setup		(){

	floorObjectList        = Arrays.asList(

        new ObjectMuseum(new Name("FLR_001", "First Floor"                        ), "XXX_XXX", "FLR", "TAG_XXX"),
        new ObjectMuseum(new Name("FLR_002", "Second Floor"                       ), "XXX_XXX", "FLR", "TAG_XXX"),
        new ObjectMuseum(new Name("FLR_003", "Third Floor"                        ), "XXX_XXX", "FLR", "TAG_XXX"),
        new ObjectMuseum(new Name("FLR_004", "Fourth Floor"                       ), "XXX_XXX", "FLR", "TAG_XXX")

    );
	roomObjectList         = Arrays.asList(

        new ObjectMuseum(new Name("ROM_AFK", "Room Afrika"                        ), "FLR_001", "ROM", "TAG_XXX"),
        new ObjectMuseum(new Name("ROM_AME", "Room America"                       ), "FLR_001", "ROM", "TAG_XXX"),
        new ObjectMuseum(new Name("ROM_ASI", "Room Asia"                          ), "FLR_001", "ROM", "TAG_XXX"),
        new ObjectMuseum(new Name("ROM_EUR", "Room Europe"                        ), "FLR_001", "ROM", "TAG_XXX")

    );
	exhibitionObjectList   = Arrays.asList(

        new ObjectMuseum(new Name("EXH_CAO", "Exhibition Cameroon"                ), "ROM_AFK", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_EGY", "Exhibition Egypt"                   ), "ROM_AFK", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_ETH", "Exhibition Ethiopia"                ), "ROM_AFK", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_NIG", "Exhibition Nigeria"                 ), "ROM_AFK", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_BRA", "Exhibition Brazil"                  ), "ROM_AME", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_CAN", "Exhibition Canada"                  ), "ROM_AME", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_MEX", "Exhibition Mexico"                  ), "ROM_AME", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_USA", "Exhibition United States Of America"), "ROM_AME", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_CAM", "Exhibition Cambodia"                ), "ROM_ASI", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_IND", "Exhibition India"                   ), "ROM_ASI", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_JAP", "Exhibition Japan"                   ), "ROM_ASI", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_SIN", "Exhibition Singapore"               ), "ROM_ASI", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_BEL", "Exhibition Belgium"                 ), "ROM_EUR", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_FRA", "Exhibition France"                  ), "ROM_EUR", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_GER", "Exhibition Germany"                 ), "ROM_EUR", "EXH", "TAG_XXX"),
        new ObjectMuseum(new Name("EXH_NED", "Exhibition The Netherlands"         ), "ROM_EUR", "EXH", "TAG_XXX")

    );

    for(int i = 0; i < floorObjectList.size()           ; i ++){

        floorObjectList         .get(i).SetChildObjectList  (roomObjectList);

    }
    for(int i = 0; i < roomObjectList.size()            ; i ++){

        roomObjectList          .get(i).SetParentObject     (floorObjectList);
        roomObjectList          .get(i).SetChildObjectList  (exhibitionObjectList);

    }
    for(int i = 0; i < exhibitionObjectList.size()      ; i ++){

        exhibitionObjectList    .get(i).SetParentObject     (roomObjectList);

    }

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

    List<ObjectMuseum>  childObjectList         = new ArrayList<ObjectMuseum>();    /*This list contains all possible exhibition object.*/
    List<ObjectPlayer>  childPlayerObjectList   = new ArrayList<ObjectPlayer>(); 

    int                 indexGlobalInt          = -1;                               /*This is an index number of the location of this object in its respective list.*/
    int                 indexLocalInt           = -1;                               /*This is an index number of the location of this object within its parent child object list.*/

    Name                nameObject              = null;                             /*Name object that contains the alternative name and the full name of this object.*/
    String              nameAltString           = "";                               /*This variable is intended solely to store the alternative name of this object.*/
    String              nameFullString          = "";                               /*This variable is intended solely to store the full name of this object.*/

    ObjectMuseum        parentObject            = null;                             /*The object parent of this object, which means this object should be inside the parent object's child object list.*/
    String              parentNameAltString     = "";                               /*The alternative name of the parent object.*/
    
    String              typeString              = "";                               /*The type of this object (the only possible values are "FLR", "ROM", and "EXH").*/

    List<String>        tagStringList           = new ArrayList<String>();          /*The tags for whit museum object.*/

    boolean             fullBoolean             = false;                            /*Whether this museum object is full or not.*/
    int                 fullThresholdInt        = -1;
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
        SetChildObjectList          (_targetObjectList      );

    }

    /*A function to remove this object from child object of its parent.*/
    public List<ObjectMuseum> RemoveChildObjectList(List<ObjectMuseum> _targetObjectList)      {

        for(int i = 0; i < parentObject.childObjectList.size(); i ++){

            if(parentObject.childObjectList.get(i).nameAltString.equals(nameAltString)){ parentObject.childObjectList.remove(i); }

        }

        return _targetObjectList;

    }

    /*A function to add the children of this object into childObjectList.*/
    public List<ObjectMuseum> SetChildObjectList(List<ObjectMuseum> _targetObjectList)         {

        if(childObjectList.size() > 0){ childObjectList.clear(); }                                                                  /*Clear the previous child object array.*/

        for(int i = 0;          i < _targetObjectList.size(); i ++){                                                                /*Itarete through all the object list to find whether or not there is a museum object that refers this object as its parent.*/

            if(nameAltString    == _targetObjectList.get(i).parentNameAltString){ childObjectList.add(_targetObjectList.get(i)); }  /*If the parent object from the _targetObjectList is the same with this object name then add the object into this object child object list.*/

        }

        return                  childObjectList;

    }

    /*A function to return object from any object list.*/
    public ObjectMuseum FindObject(

        List<ObjectMuseum>  _targetObjectList       , 
        String              _nameAltString

    ){

        ObjectMuseum objectMuseum = null;
        for(int i = 0; i < _targetObjectList.size(); i ++){

            if(_targetObjectList.get(i).nameAltString.equals(_nameAltString)){ objectMuseum = _targetObjectList.get(i); }

        }
        return objectMuseum;

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

    /*A function to find this object index in its array list (not parent nor child object list).*/
    public int FindIndexInt(List<ObjectMuseum> _targetObjectList)                              {

        int indexInt            = -1;
        for(int i = 0; i < _targetObjectList.size(); i ++){

            if(_targetObjectList.get(i).nameAltString.equals(nameAltString)){ indexInt = i; break; }

        }

        return indexInt;

    }

    /*A function to set the threshold to determine whether this museum object is full or not.*/
    public int SetFullThresholdInt(int _fullThresholdInt)                                      {

        fullThresholdInt            = _fullThresholdInt;

        if      (fullThresholdInt   <= visitorCurrentInt)  { fullBoolean = true;  }
        else if (fullThresholdInt   >  visitorCurrentInt)  { fullBoolean = false; }

        return          fullThresholdInt;
        
    }
};


/*Create an internal class to be put in the list for easiness.
This is because List in Java must be homogenous.*/
class TagCounter{

    List<Integer>   tagCounterIntList   = new ArrayList<Integer>();
    String          tagNameString       = "";
    int             tagCounterInt       = -1;

    TagCounter(){}
    public void    SetTagNameStringVoid    (String _tagNameString) { tagNameString = _tagNameString; }
    public void    SetTagCounterIntVoid    (int _tagCounterInt)    {

        tagCounterInt       = _tagCounterInt;
        tagCounterIntList   = new ArrayList<Integer>();
        tagCounterIntList   .add(tagCounterInt);

    }
    public int     GetTagCounterInt        (){ return tagCounterInt; }
    public String  GetTagNameString        (){ return tagNameString; }

}

class ObjectPlayer{

    String              exhibitionCurrentString     = "";
    List<String>        exhibitionTargetStringList  = new ArrayList<String>();
    List<String>        exhibitionVisitedStringList = new ArrayList<String>();
    List<TagCounter>    exhibitionTagCounterList    = new ArrayList<TagCounter>();

    int                 playerIndex                 = 0;

    List<ObjectPlayer>  playerSiblingObjectList     = new ArrayList<ObjectPlayer>();
    int                 playerSiblingIndexInt       = -1;

    int                 timeCurrentExhibitionInt    = 0;

    /*Constructor.*/
    ObjectPlayer(

        int     _playerIndex            ,
        String  _exhibitionStartString

    ){ playerIndex = _playerIndex; ExhibitionMoveObject(_exhibitionStartString); }

    /*A function to either add the tag or increase the tag value in this player.*/
    public void AddTagCounterVoid(

        ObjectMuseum _exhibitionCurrentObject

    ){

        for(int i = 0; i < _exhibitionCurrentObject.tagStringList.size(); i ++){

            /*Create new tag counter to count how many tags are in the user preference.*/
            TagCounter  tagCounter      = new TagCounter();
                        tagCounter      .SetTagNameStringVoid(_exhibitionCurrentObject.tagStringList.get(i));

            boolean     newBool         = true;     /*Whether the tag is new to the array or there is already existing one.*/
            int         indexInt        = -1;       /*If there is the corresponding tag already in the array return its index with this variable, otherwise it keeps -1.*/

            /*Iterate through all tag those already gathered to find if there any tag that
                is already registered in this player.*/
            for(int j = 0; j < exhibitionTagCounterList.size(); j ++){

                if(

                    exhibitionTagCounterList.get(j).GetTagNameString().equals(

                        tagCounter.GetTagNameString()

                    )

                ){

                    newBool             = false;
                    indexInt            = j;

                }

            }

            /*If the tag received is new then set the initial tag value to 1 and
                add the tag to the tag counter.*/
            if      (newBool == true ){

                tagCounter                  .SetTagCounterIntVoid(1);
                exhibitionTagCounterList    .add(tagCounter);

            }
            /*If the tag received is alredy filled in before then increase the tag counter.*/
            else if (newBool == false){

                exhibitionTagCounterList.get(indexInt).SetTagCounterIntVoid(tagCounter.GetTagCounterInt() + 1);

            }

        }

        /*Sort the object in the list based on tag counter int.*/
        Collections.sort(exhibitionTagCounterList, new Comparator<TagCounter>(){

                public int compare(TagCounter _tagCounter1Object, TagCounter _tagCounter2Object) {
                
                    return _tagCounter1Object.tagCounterIntList.get(0).compareTo(_tagCounter2Object.tagCounterIntList.get(0));
                
                }

            }

        );

    }

    /*A function to add or remove this object from parent child object.*/
    public void AddRemoveChildVoid(boolean _isAdd)                 {

        ObjectMuseum exhibitionCurrentObject                = FindObject(exhibitionObjectList, exhibitionCurrentString);
        if      (_isAdd == true )                           { exhibitionCurrentObject.childPlayerObjectList.add(this);      }
        else if (_isAdd == false)                           { exhibitionCurrentObject.childPlayerObjectList.remove(this);   }

    }

    public void AIAutoVoid()                                       {

        /*Check wether this player has already visited most exhibitions in the museum.
        I checked the whether the exhibition visited has the same amount of length with total exhibition length.
        It is not necessary for this player to have all exhibitions visited due to there is a chance that this player
            visited same exhibitions twice or more.*/
        if(exhibitionObjectList.size()                      >= exhibitionVisitedStringList.size()){

            /*Increase the amount of time of this player in the current exhibition the visitor visits.
            The more time this player spent time in the exhibition the more chance the visitor will move to the
                new exhibition.
            PENDING: Change the time increment per second add and per frame.*/
            timeCurrentExhibitionInt                        ++;

            if(Math.random() > (1 - (timeCurrentExhibitionInt/100))){

                /*Move player to the new exhibition.*/
                int     randomIndexInt          = (int)(Math.floor((Math.random()*exhibitionTargetStringList.size()) + 0));
                ExhibitionMoveObject            (exhibitionTargetStringList.get(randomIndexInt));
                timeCurrentExhibitionInt        = 0;                                                                            /*Reset timer.*/

            }

        }

    }

    /*A function to return the position of this player in the player sibling list*/
    public int SetPlayerSiblingIndexInt(

        List<ObjectPlayer> _playerSiblingObjectList

    ){

        playerSiblingIndexInt = -1;
        for(int i = 0; i < _playerSiblingObjectList.size(); i ++){ if(_playerSiblingObjectList.get(i) == this){ playerSiblingIndexInt = i; } }
        return playerSiblingIndexInt;

    }

    /*A function to automatically add other player of which in the same exhibition.*/
    public List<ObjectPlayer> SetSiblingObjectList()               {

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

    /*A function to determine target exhibition.*/
    public List<String> SetExhibitionTargetStringList()      {

        exhibitionTargetStringList  = new ArrayList<String>();

        /*Stage one sort.
        Stage one sort is to remove the currently visited exhibition from the target exhibition index.
        So that the player have no chance on visiting the exhibition that he/she  currently visits.*/
        for(int i = 0; i < exhibitionObjectList.size(); i ++){

            /*Compare the current exihibition with the object exhibitiob array.
            After that remove the object exhibition that is the current exhibition and put the rest
                of the exhibition in the target exhibition array string.*/
            if(

                !(exhibitionObjectList.get(i).nameAltString.equals(exhibitionCurrentString))

            ){

                exhibitionTargetStringList.add(

                    exhibitionObjectList.get(i).nameAltString

                );

            }

        }

        /*Stage two sort.
        Remove all exhibition target that is full of visitor.*/
        for(int i = 0; i < exhibitionObjectList.size(); i ++){

            if(

                 (exhibitionObjectList.get(i).fullBoolean       == true)                                               &&
                !(exhibitionCurrentString                       .equals(exhibitionObjectList.get(i).nameAltString))

            ){
                
                exhibitionTargetStringList                      .remove(exhibitionObjectList.get(i).nameAltString);
                if(exhibitionTargetStringList.size() == 3)      { return exhibitionTargetStringList; }

            }

        }

        /*Stage three sort.
        Stage three sort is to make the exhibition that has been visited before has 90% chance to make into target exhibition.
        For example the visitor is now in the Exhibition C as he/she used to visits Exhibition A and Exhibition B before,
            the system now will let Exhibition A and Exhibition B to have 10% chance to be not removed from the target
            exhibition array.*/
        for(int i = 0; i < exhibitionVisitedStringList.size(); i ++){

            for(int j = 0; j < exhibitionTargetStringList.size(); j ++){

                /*Compare the target exhibitions with all visited exhibition.
                If it matches then the corresponding exhibition has 90% chance to be deleted
                    from target exhibition array.*/
                if(exhibitionTargetStringList.get(j).equals(exhibitionVisitedStringList.get(i))){

                    if(Math.random() < 0.90f){

                        exhibitionTargetStringList.remove(exhibitionTargetStringList.get(j));
                        j --;

                    }

                    /*After each splice make sure to have the exhibition target length to be 3.
                    If not 3 elements in the target exhibition array, then return the last 3 elements
                        of target exhibition array ever exist.*/
                    if(exhibitionTargetStringList.size() == 3)  { return exhibitionTargetStringList; }

                }

            }

        }

        /*Stage four sort.
        So now this application compare the the most visited tags from this player profile (take three most visited tags)
            and compared to the exhibition tag.
        Each exhibition has 3 tags so,
            if nothing match the exhibition is excluded from from the target exhibition array,
            if one tag is match the exhibition has 66% chance of being removed from the target exhibition array,
            if two tags are match the exhibition has 33% chance of being removed from the target exhibition array,
            if three tags are match the exhibition will stay in the target exhibition array.*/
        String tempTagStringArray[] = new String[3];
        for(int i = 0; i < tempTagStringArray.length            ; i ++){ tempTagStringArray[i] = exhibitionTagCounterList.get(i).GetTagNameString(); }
        for(int i = 0; i < exhibitionTargetStringList.size()    ; i ++){

            ObjectMuseum    exhibitionTargetObject  = FindObject(exhibitionObjectList, exhibitionTargetStringList.get(i));
            int             tagSameCountInt         = 0;

            for(int j = 0; j < exhibitionTargetObject.tagStringList.size(); j ++){

                for(int k = 0; k < tempTagStringArray.length; k ++){

                    if(exhibitionTargetObject.tagStringList.get(j) == tempTagStringArray[k]){ tagSameCountInt ++; }

                }

            }
            
            if      (tagSameCountInt == 0)          {                            exhibitionTargetStringList.remove(exhibitionTargetStringList.get(i)); i --; }
            else if (tagSameCountInt == 1)          { if(Math.random() < 0.66f){ exhibitionTargetStringList.remove(exhibitionTargetStringList.get(i)); i --; } }
            else if (tagSameCountInt == 2)          { if(Math.random() < 0.33f){ exhibitionTargetStringList.remove(exhibitionTargetStringList.get(i)); i --; } }
            else if (tagSameCountInt == 3)          {  }

            /*After each splice make sure to have the exhibition target length to be 3.
            If not 3 elements in the target exhibition array, then return the last 3 elements
                of target exhibition array ever exist.*/
            if(exhibitionTargetStringList.size() == 3)  { return exhibitionTargetStringList; }

        }

        ObjectMuseum    exhibitionCurrentObject     = FindObject(exhibitionObjectList, exhibitionCurrentString);
        String          roomCurrentString           = exhibitionCurrentObject.parentNameAltString;
        ObjectMuseum    roomCurrentObject           = FindObject(roomObjectList, roomCurrentString);
        String          floorCurrentString          = roomCurrentObject.parentNameAltString;
        ObjectMuseum    floorCurrentObject          = FindObject(floorObjectList, floorCurrentString);

        /*Stage five sort.
        The fourth sort is to make the exhibition target that are not in the same floor or room of which player's
            current exhibition to have 50% chance of stay.*/
        for(int i = 0; i < exhibitionTargetStringList.size(); i ++){

            ObjectMuseum    exhibitionTargetObject  = FindObject(exhibitionObjectList, exhibitionTargetStringList.get(i));
            String          roomTargetString        = exhibitionTargetObject.parentNameAltString;
            ObjectMuseum    roomTargetObject        = FindObject(roomObjectList, roomTargetString);
            String          floorTargetString       = roomTargetObject.parentNameAltString;
            ObjectMuseum    floorTargetObject       = FindObject(floorObjectList, floorTargetString);

            if(roomCurrentString    != roomTargetString ){

                if(Math.random() < 0.20f){ exhibitionTargetStringList.remove(exhibitionTargetStringList.get(i)); i --; }
                else{

                    if(floorCurrentString != floorTargetString){ if(Math.random() < 0.50f){ exhibitionTargetStringList.remove(exhibitionTargetStringList.get(i)); i --; } }

                }

            }
            
            /*After each splice make sure to have the exhibition target length to be 3.
            If not 3 elements in the target exhibition array, then return the last 3 elements
                of target exhibition array ever exist.*/
            if(exhibitionTargetStringList.size() == 3)  { return exhibitionTargetStringList; }

        }

        return                      exhibitionTargetStringList;

    }

    /*A function to move this player into new exhibition and add the tags to the tag coutner list.*/
    public ObjectMuseum ExhibitionMoveObject(

        String _targetNameAltString

    ){

        /*Variable to hold currently visited museum object.*/
        ObjectMuseum exhibitionCurrentObject    = null;
        ObjectMuseum roomCurrentObject          = null;
        ObjectMuseum floorCurrentObject         = null;

        /*If this player has a parent (means that this is not the first move).
        So that, this if statement is only when the player is first time
            initiated.*/
        if(exhibitionCurrentString != ""){

            /*Remove this player from the current child list of the parent,
                before we move this player into another exhibition.*/
            AddRemoveChildVoid(false);

            exhibitionCurrentObject     = FindObject(exhibitionObjectList   , exhibitionCurrentString                           );
            roomCurrentObject           = FindObject(roomObjectList         , exhibitionCurrentObject   .parentNameAltString    );
            floorCurrentObject          = FindObject(floorObjectList        , roomCurrentObject         .parentNameAltString    );
            exhibitionCurrentObject     .visitorCurrentInt --;
            roomCurrentObject           .visitorCurrentInt --;
            floorCurrentObject          .visitorCurrentInt --;

        }

        exhibitionCurrentString         = _targetNameAltString;             /*Chanhe the String for current exhibition.*/
        exhibitionVisitedStringList     .add(exhibitionCurrentString);      /*Add the current exhibition to visited exhibition list.*/
        
        /*Re - instantiated all newly visited museum objects.*/
        exhibitionCurrentObject         = FindObject(exhibitionObjectList   , exhibitionCurrentString                           );
        roomCurrentObject               = FindObject(roomObjectList         , exhibitionCurrentObject   .parentNameAltString    );
        floorCurrentObject              = FindObject(floorObjectList        , roomCurrentObject         .parentNameAltString    );

        /*Add total number museum visit.*/
        exhibitionCurrentObject         .visitorCurrentInt  ++;
        roomCurrentObject               .visitorCurrentInt  ++;
        floorCurrentObject              .visitorCurrentInt  ++;
        exhibitionCurrentObject         .visitorTotalInt    ++;
        roomCurrentObject               .visitorTotalInt    ++;
        floorCurrentObject              .visitorTotalInt    ++;

        AddTagCounterVoid               (exhibitionCurrentObject);
        AddRemoveChildVoid              (true);
        
        /*For everytime a player move to another exhibition iterate through all player to re - add the siblings.*/
        for(int i = 0; i < playerObjectList.size(); i ++){

            playerObjectList.get(i).SetSiblingObjectList();
            playerObjectList.get(i).SetExhibitionTargetStringList();

        }

        return exhibitionCurrentObject;

    }

    /*A function to find an object from an array.*/
    public ObjectMuseum FindObject(

        List<ObjectMuseum>  _targetObjectList       ,
        String              _targetNameAltString

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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "JavaProcessingMuseumSimulator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
