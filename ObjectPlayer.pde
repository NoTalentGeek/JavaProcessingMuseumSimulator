import java.util.*;

/*Create an internal class to be put in the list for easiness.
This is because List in Java must be homogenous.*/
class TagCounter{

    List<Integer>   tagCounterIntList   = new ArrayList<Integer>();
    String          tagNameString       = "";
    int             tagCounterInt       = -1;

    TagCounter(){}
    void    SetTagNameStringVoid    (String _tagNameString) { tagNameString = _tagNameString; }
    void    SetTagCounterIntVoid    (int _tagCounterInt)    {

        tagCounterInt       = _tagCounterInt;
        tagCounterIntList   = new ArrayList<Integer>();
        tagCounterIntList   .add(tagCounterInt);

    }
    int     GetTagCounterInt        (){ return tagCounterInt; }
    String  GetTagNameString        (){ return tagNameString; }

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
    void AddTagCounterVoid(

        ObjectMuseum _exhibitionCurrentObject

    ){

        for(int i = 0; i < _exhibitionCurrentObject.tagMuseumNameAltStringList.size(); i ++){

            /*Create new tag counter to count how many tags are in the user preference.*/
            TagCounter  tagCounter      = new TagCounter();
                        tagCounter      .SetTagNameStringVoid(_exhibitionCurrentObject.tagMuseumNameAltStringList.get(i));

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
    void AddRemoveChildVoid(boolean _isAdd)                 {

        ObjectMuseum exhibitionCurrentObject                = FindObject(exhibitionObjectList, exhibitionCurrentString);
        if      (_isAdd == true )                           { exhibitionCurrentObject.childPlayerObjectList.add(this);      }
        else if (_isAdd == false)                           { exhibitionCurrentObject.childPlayerObjectList.remove(this);   }

    }

    void AIAutoVoid()                                       {

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
    int SetPlayerSiblingIndexInt(

        List<ObjectPlayer> _playerSiblingObjectList

    ){

        playerSiblingIndexInt = -1;
        for(int i = 0; i < _playerSiblingObjectList.size(); i ++){ if(_playerSiblingObjectList.get(i) == this){ playerSiblingIndexInt = i; } }
        return playerSiblingIndexInt;

    }

    /*A function to automatically add other player of which in the same exhibition.*/
    List<ObjectPlayer> SetSiblingObjectList()               {

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
    List<String> SetExhibitionTargetStringList()      {

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

            for(int j = 0; j < exhibitionTargetObject.tagMuseumNameAltStringList.size(); j ++){

                for(int k = 0; k < tempTagStringArray.length; k ++){

                    if(exhibitionTargetObject.tagMuseumNameAltStringList.get(j) == tempTagStringArray[k]){ tagSameCountInt ++; }

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
    ObjectMuseum ExhibitionMoveObject(

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
    ObjectMuseum FindObject(

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