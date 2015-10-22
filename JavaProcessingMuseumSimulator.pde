void setup		(){

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