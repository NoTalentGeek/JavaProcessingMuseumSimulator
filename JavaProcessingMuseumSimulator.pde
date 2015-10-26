/*Determine global variables.*/
int                     playerAmountInt         = 30;
List<Tag>               tagObjectList           = new ArrayList<Tag>();
List<ObjectMuseum>      floorObjectList         = new ArrayList<ObjectMuseum>();
List<ObjectMuseum>      roomObjectList          = new ArrayList<ObjectMuseum>();
List<ObjectMuseum>      exhibitionObjectList    = new ArrayList<ObjectMuseum>();
List<ObjectPlayer>      playerObjectList        = new ArrayList<ObjectPlayer>();
class Name                                      {

    String          nameAltString   = "";
    String          nameFullString  = "";
    Name(
        String _nameAltString   , 
        String _nameFullString
    ){

        nameAltString               = _nameAltString;
        nameFullString              = _nameFullString;

    }

};

class Tag                                       {

    Name            tagName         = null;
    String          nameAltString   = "";
    String          nameFullString  = "";
    Tag(Name _nameObject)                       {

        tagName             = _nameObject;
        nameAltString       = tagName.nameAltString;
        nameFullString      = tagName.nameFullString;

    }

}

void setup()                                    {

	/*Create the tag list.*/
	tagObjectList 			= Arrays.asList(
	
		new Tag(new Name("Agreeable"  	, "TAG_AGR")),
		new Tag(new Name("Brave"		, "TAG_BRA")),
		new Tag(new Name("Calm"			, "TAG_CAL")),
		new Tag(new Name("Delightful"	, "TAG_DEL")),
		new Tag(new Name("Eager"		, "TAG_EAG")),
		new Tag(new Name("Faithful"		, "TAG_FAI")),
		new Tag(new Name("Gentle"		, "TAG_GEN")),
		new Tag(new Name("Happy"		, "TAG_HAP")),
		new Tag(new Name("Jolly"		, "TAG_JOL")),
		new Tag(new Name("Kind"			, "TAG_KIN")),
		new Tag(new Name("Lively"		, "TAG_LIV")),
		new Tag(new Name("Nice"			, "TAG_NIC")),
		new Tag(new Name("Obedient"		, "TAG_OBE")),
		new Tag(new Name("Proud"		, "TAG_PRO")),
		new Tag(new Name("Relieved"		, "TAG_REL")),
		new Tag(new Name("Silly"		, "TAG_SIL")),
		new Tag(new Name("Thankful"		, "TAG_THA")),
		new Tag(new Name("Victorious"	, "TAG_VIC")),
		new Tag(new Name("Witty"		, "TAG_WIT")),
		new Tag(new Name("Zealous"		, "TAG_ZEA"))
	
	);

	floorObjectList        	= Arrays.asList(

        new ObjectMuseum(new Name("FLR_001", "First Floor"                        ), "XXX_XXX", "FLR", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("FLR_002", "Second Floor"                       ), "XXX_XXX", "FLR", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("FLR_003", "Third Floor"                        ), "XXX_XXX", "FLR", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("FLR_004", "Fourth Floor"                       ), "XXX_XXX", "FLR", AssignRandomTagList(tagObjectList))

    );
	roomObjectList         	= Arrays.asList(

        new ObjectMuseum(new Name("ROM_AFK", "Room Afrika"                        ), "FLR_001", "ROM", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("ROM_AME", "Room America"                       ), "FLR_001", "ROM", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("ROM_ASI", "Room Asia"                          ), "FLR_001", "ROM", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("ROM_EUR", "Room Europe"                        ), "FLR_001", "ROM", AssignRandomTagList(tagObjectList))

    );
	exhibitionObjectList   	= Arrays.asList(

        new ObjectMuseum(new Name("EXH_CAO", "Exhibition Cameroon"                ), "ROM_AFK", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_EGY", "Exhibition Egypt"                   ), "ROM_AFK", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_ETH", "Exhibition Ethiopia"                ), "ROM_AFK", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_NIG", "Exhibition Nigeria"                 ), "ROM_AFK", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_BRA", "Exhibition Brazil"                  ), "ROM_AME", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_CAN", "Exhibition Canada"                  ), "ROM_AME", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_MEX", "Exhibition Mexico"                  ), "ROM_AME", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_USA", "Exhibition United States Of America"), "ROM_AME", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_CAM", "Exhibition Cambodia"                ), "ROM_ASI", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_IND", "Exhibition India"                   ), "ROM_ASI", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_JAP", "Exhibition Japan"                   ), "ROM_ASI", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_SIN", "Exhibition Singapore"               ), "ROM_ASI", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_BEL", "Exhibition Belgium"                 ), "ROM_EUR", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_FRA", "Exhibition France"                  ), "ROM_EUR", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_GER", "Exhibition Germany"                 ), "ROM_EUR", "EXH", AssignRandomTagList(tagObjectList)),
        new ObjectMuseum(new Name("EXH_NED", "Exhibition The Netherlands"         ), "ROM_EUR", "EXH", AssignRandomTagList(tagObjectList))

    );

    for(int i = 0; i < floorObjectList.size()           ; i ++) { floorObjectList.get(i).SetChildObjectList  (roomObjectList); }
    for(int i = 0; i < roomObjectList.size()            ; i ++) {

        roomObjectList          .get(i).SetParentObject     (floorObjectList);
        roomObjectList          .get(i).SetChildObjectList  (exhibitionObjectList);

    }
    for(int i = 0; i < exhibitionObjectList.size()      ; i ++) { exhibitionObjectList.get(i).SetParentObject(roomObjectList); }
    for(int i = 0; i < playerAmountInt; i ++)                   {

        ObjectPlayer objectPlayer 	= new ObjectPlayer(i, exhibitionObjectList.get((int)(Math.floor((Math.random()*exhibitionObjectList.size()) + 0))).nameAltString);
        playerObjectList			.add(objectPlayer);

    }

}

void draw()											{}

/*A function to return an array of object tag to be put in the museum object, randomly.*/
Tag[] AssignRandomTagList(List<Tag> _tagObjectList)	{

	/*Temporary tag object list to be returned later on this function.*/
	List<Tag> assignTagObjectList 					= new ArrayList<Tag>();
	
	/*This function need to be atleast gives three tags to a museum object.
	After three tags is insie the List then we can randomly add another tag with
		random chance.
	The thing is that every tag added the chance of another tag will be added/pushed
		is lower.*/
	float randomChanceFloat							= 1f;
	while(

		(assignTagObjectList.size() <= 3) ||
		(Math.random() < randomChanceFloat)

	){

		/*Need to make sure the inputted random tag is not something that is already in the museum object
		Create a temporary tag object to hold.*/
		int randomIndexInt	= (int)((Math.random()*_tagObjectList.size()) + 0);
		Tag tagObject 		= _tagObjectList.get(randomIndexInt);
		
		/*Keep looping over and over until the random index is not a tag that is already in the list.*/
		for(int i = 0; i < assignTagObjectList.size(); i ++){

			/*If the random tag is already inside the museum object then we need to iterate again to get new random tag
				generated.*/
			while(assignTagObjectList.get(i) == tagObject){
				
				randomIndexInt	= (int)((Math.random()*_tagObjectList.size()) + 0);
				tagObject 		= _tagObjectList.get(randomIndexInt);
				
			}

		}
		
		/*If the assignTagObjectList has three or more elements then we need to start reducing the changce.*/
		if(assignTagObjectList.size() > 3){ randomChanceFloat -= 0.1f; }
		
		/*Add/push a tag object into the temporary list.*/
		assignTagObjectList.add(tagObject);

	}
	
	/*Before returning the value, the object here is still in List, hence we need to convert it to array.
	Thus, it can be used in params.*/
	Tag[] assignTagObjectArray 						= new Tag[assignTagObjectList.size()];
	for(int i = 0; i < assignTagObjectArray.length; i ++){ assignTagObjectArray[i] = assignTagObjectList.get(i); }
	
	return assignTagObjectArray;

}
