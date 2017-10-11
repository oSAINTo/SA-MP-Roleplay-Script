//---------------------------------------------------------
//
// Rivershell v2 by Kye - 2006-2013
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

// Global stuff and defines for our gamemode.

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

#define OBJECTIVE_VEHICLE_GREEN 		2
#define OBJECTIVE_VEHICLE_BLUE 			1
#define TEAM_GREEN 						1
#define TEAM_BLUE 						2
#define OBJECTIVE_COLOR 				0xE2C063FF
#define TEAM_GREEN_COLOR 				0x77CC77FF
#define TEAM_BLUE_COLOR 				0x7777DDFF
#define CAPS_TO_WIN 					5
#define ALLOW_RESPAWN_AFTER_N_SECONDS  	20

#define SPECTATE_STATE_NONE           	0
#define SPECTATE_STATE_PLAYER           1
#define SPECTATE_STATE_FIXED            2

#define SPECTATE_MODE_NONE           	0
#define SPECTATE_MODE_PLAYER           	1
#define SPECTATE_MODE_VEHICLE           2

new gObjectiveReached = 0; // Stops the winner logic reentering itself.
new gObjectiveGreenPlayer=(-1); // Tracks which green player has the vehicle.
new gObjectiveBluePlayer=(-1); // Tracks which blue player has the vehicle.

// number of times the vehicle has been captured by each team
new gGreenTimesCapped=0;
new gBlueTimesCapped=0;

// forward declarations for the PAWN compiler (not really needed, but there for the sake of clarity)
forward SetPlayerToTeamColor(playerid);
forward SetupPlayerForClassSelection(playerid);
forward SetPlayerTeamFromClass(playerid,classid);
forward ExitTheGameMode();

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Rivershell by Kye 2006-2013\n");
	print("----------------------------------\n");
}
//---------------------------------------------------------

public SetPlayerToTeamColor(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN) {
		SetPlayerColor(playerid, TEAM_GREEN_COLOR); // green
	} else if(gTeam[playerid] == TEAM_BLUE) {
	    SetPlayerColor(playerid, TEAM_BLUE_COLOR); // blue
	}
}
//---------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	// Set the player's orientation when they're selecting a class.
	SetPlayerPos(playerid,1984.4445,157.9501,55.9384);
    SetPlayerCameraPos(playerid,1984.4445,160.9501,55.9384);
	SetPlayerCameraLookAt(playerid,1984.4445,157.9501,55.9384);
	SetPlayerFacingAngle(playerid,0.0);
}

//---------------------------------------------------------

public SetPlayerTeamFromClass(playerid,classid)
{
	// Set their team number based on the class they selected.
	if(classid == 0 || classid == 1) {
	    SetPlayerTeam(playerid, TEAM_GREEN);
		gTeam[playerid] = TEAM_GREEN;
	}
	else if(classid == 2 || classid == 3) {
	    SetPlayerTeam(playerid, TEAM_BLUE);
	    gTeam[playerid] = TEAM_BLUE;
	}
}

//---------------------------------------------------------

public ExitTheGameMode()
{
    PlaySoundForAll(1186, 0.0, 0.0, 0.0); // Stops the music
	//printf("Exiting Game Mode");
    GameModeExit();
}

//---------------------------------------------------------

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid;

	if(newstate == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		
		if(gTeam[playerid] == TEAM_GREEN && vehicleid == OBJECTIVE_VEHICLE_GREEN)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~y~boat ~w~back to the ~r~spawn!",3000,5);
		    SetPlayerCheckpoint(playerid, 2135.7368, -179.8811, -0.5323, 10.0);
		    gObjectiveGreenPlayer = playerid;
		}
		
		if(gTeam[playerid] == TEAM_BLUE && vehicleid == OBJECTIVE_VEHICLE_BLUE)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~y~boat ~w~back to the ~r~spawn!",3000,5);
		    SetPlayerCheckpoint(playerid, 2329.4226, 532.7426, 0.5862, 10.0);
		    gObjectiveBluePlayer = playerid;
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(playerid == gObjectiveGreenPlayer) {
		    gObjectiveGreenPlayer = (-1);
		    SetPlayerToTeamColor(playerid);
	  		DisablePlayerCheckpoint(playerid);
		}
		
		if(playerid == gObjectiveBluePlayer) {
		    gObjectiveBluePlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		    DisablePlayerCheckpoint(playerid);
		}
	}

    return 1;
}

//---------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("Rivershell");
	
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	SetWorldTime(17);
	SetWeather(11);
	UsePlayerPedAnims();
	EnableVehicleFriendlyFire();
	SetNameTagDrawDistance(110.0);
	DisableInteriorEnterExits();

	// Green classes
	AddPlayerClass(162,2117.0129,-224.4389,8.15,0.0,31,100,29,200,34,10);
	AddPlayerClass(157,2148.6606,-224.3336,8.15,347.1396,31,100,29,200,34,10);

 	// Blue classes
	AddPlayerClass(154,2352.9873,580.3051,7.7813,178.1424,31,100,29,200,34,10);
	AddPlayerClass(138,2281.1504,567.6248,7.7813,163.7289,31,100,29,200,34,10);

	// Objective vehicles
    CreateVehicle(453, 2184.7156, -188.5401, -0.0239, 0.0000, 114, 1, 100); // gr reefer
    CreateVehicle(453, 2380.0542, 535.2582, -0.0272, 178.4999, 79, 7, 100); // bl reefer

  	// Green Dhingys
	CreateVehicle(473, 2096.0833, -168.7771, 0.3528, 4.5000, 114, 1, 100);
	CreateVehicle(473, 2103.2510, -168.7598, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2099.4966, -168.8216, 0.3528, 2.8200, 114, 1, 100);
	CreateVehicle(473, 2107.1143, -168.7798, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2111.0674, -168.7609, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2114.8933, -168.7898, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2167.2217, -169.0570, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2170.4294, -168.9724, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2173.7952, -168.9217, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2177.0386, -168.9767, 0.3528, 3.1800, 114, 1, 100);
	CreateVehicle(473, 2161.5786, -191.9538, 0.3528, 89.1000, 114, 1, 100);
	CreateVehicle(473, 2161.6394, -187.2925, 0.3528, 89.1000, 114, 1, 100);
	CreateVehicle(473, 2161.7610, -183.0225, 0.3528, 89.1000, 114, 1, 100);
	CreateVehicle(473, 2162.0283, -178.5106, 0.3528, 89.1000, 114, 1, 100);
	// Green Mavericks
	CreateVehicle(487, 2088.7905, -227.9593, 8.3662, 0.0000, 114, 1, 100);
	CreateVehicle(487, 2204.5991, -225.3703, 8.2400, 0.0000, 114, 1, 100);

	// Blue Dhingys
	CreateVehicle(473, 2370.3198, 518.3151, 0.1240, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2362.6484, 518.3978, 0.0598, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2358.6550, 518.2167, 0.2730, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2366.5544, 518.2680, 0.1080, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2354.6321, 518.1960, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2350.7449, 518.1929, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2298.8977, 518.4470, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2295.6118, 518.3963, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2292.3237, 518.4249, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2289.0901, 518.4363, 0.3597, 180.3600, 79, 7, 100);
	CreateVehicle(473, 2304.8232, 539.7859, 0.3597, 270.5998, 79, 7, 100);
	CreateVehicle(473, 2304.6936, 535.0454, 0.3597, 270.5998, 79, 7, 100);
	CreateVehicle(473, 2304.8245, 530.3308, 0.3597, 270.5998, 79, 7, 100);
	CreateVehicle(473, 2304.8142, 525.7471, 0.3597, 270.5998, 79, 7, 100);
	
	// Blue Mavericks
	CreateVehicle(487, 2260.2637, 578.5220, 8.1223, 182.3401, 79, 7, 100);
	CreateVehicle(487, 2379.9792, 580.0323, 8.0178, 177.9601, 79, 7, 100);
	
	// Green Base Section
	CreateMapObject(9090, 2148.64, -222.88, -20.60, 0.00, 0.00, 179.70);
	// Green resupply hut
	CreateMapObject(12991, 2140.83, -235.13, 7.13, 0.00, 0.00, -89.94);

	// Blue Base Section
	CreateMapObject(9090, 2317.09, 572.27, -20.97, 0.00, 0.00, 0.00);
	// Blue resupply hut
	CreateMapObject(12991, 2318.73, 590.96, 6.75, 0.00, 0.00, 89.88);
	
	// General mapping
	CreateMapObject(12991, 2140.83, -235.13, 7.13,   0.00, 0.00, -89.94);
	CreateMapObject(19300, 2137.33, -237.17, 46.61,   0.00, 0.00, 180.00);
	CreateMapObject(12991, 2318.73, 590.96, 6.75,   0.00, 0.00, 89.88);
	CreateMapObject(19300, 2325.41, 587.93, 47.37,   0.00, 0.00, 180.00);
	CreateMapObject(12991, 2140.83, -235.13, 7.13,   0.00, 0.00, -89.94);
	CreateMapObject(12991, 2318.73, 590.96, 6.75,   0.00, 0.00, 89.88);
	CreateMapObject(12991, 2140.83, -235.13, 7.13,   0.00, 0.00, -89.94);
	CreateMapObject(12991, 2318.73, 590.96, 6.75,   0.00, 0.00, 89.88);
	CreateMapObject(18228, 1887.93, -59.78, -2.14,   0.00, 0.00, 20.34);
	CreateMapObject(17031, 1990.19, 541.37, -22.32,   0.00, 0.00, 0.00);
	CreateMapObject(18227, 2000.82, 494.15, -7.53,   11.70, -25.74, 154.38);
	CreateMapObject(17031, 1992.35, 539.80, -2.97,   9.12, 30.66, 0.00);
	CreateMapObject(17031, 1991.88, 483.77, -0.66,   -2.94, -5.22, 12.78);
	CreateMapObject(17029, 2070.57, -235.87, -6.05,   -7.20, 4.08, 114.30);
	CreateMapObject(17029, 2056.50, -228.77, -19.67,   14.16, 19.68, 106.56);
	CreateMapObject(17029, 2074.00, -205.33, -18.60,   16.02, 60.60, 118.86);
	CreateMapObject(17029, 2230.39, -242.59, -11.41,   5.94, 7.56, 471.24);
	CreateMapObject(17029, 2252.53, -213.17, -20.81,   18.90, -6.30, -202.38);
	CreateMapObject(17029, 2233.04, -234.08, -19.00,   21.84, -8.88, -252.06);
	CreateMapObject(17027, 2235.05, -201.49, -11.90,   -11.94, -4.08, 136.32);
	CreateMapObject(17029, 2226.11, -237.07, -2.45,   8.46, 2.10, 471.24);
	CreateMapObject(4368, 2433.79, 446.26, 4.67,   -8.04, -9.30, 61.02);
	CreateMapObject(4368, 2031.23, 489.92, -13.20,   -8.04, -9.30, -108.18);
	CreateMapObject(17031, 2458.36, 551.10, -6.95,   0.00, 0.00, 0.00);
	CreateMapObject(17031, 2465.37, 511.35, -7.70,   0.00, 0.00, 0.00);
	CreateMapObject(17031, 2474.80, 457.71, -5.17,   0.00, 0.00, 172.74);
	CreateMapObject(17031, 2466.03, 426.28, -5.17,   0.00, 0.00, 0.00);
	CreateMapObject(791, 2310.45, -229.38, 7.41,   0.00, 0.00, 0.00);
	CreateMapObject(791, 2294.00, -180.15, 7.41,   0.00, 0.00, 60.90);
	CreateMapObject(791, 2017.50, -305.30, 7.29,   0.00, 0.00, 60.90);
	CreateMapObject(791, 2106.45, -279.86, 20.05,   0.00, 0.00, 60.90);
	CreateMapObject(706, 2159.13, -263.71, 19.22,   356.86, 0.00, -17.18);
	CreateMapObject(706, 2055.75, -291.53, 13.98,   356.86, 0.00, -66.50);
	CreateMapObject(791, 1932.65, -315.88, 6.77,   0.00, 0.00, -35.76);
	CreateMapObject(790, 2429.40, 575.79, 10.42,   0.00, 0.00, 3.14);
	CreateMapObject(790, 2403.40, 581.56, 10.42,   0.00, 0.00, 29.48);
	CreateMapObject(791, 2083.44, 365.48, 13.19,   356.86, 0.00, -1.95);
	CreateMapObject(791, 2040.15, 406.02, 13.33,   356.86, 0.00, -1.95);
	CreateMapObject(791, 1995.36, 588.10, 7.50,   356.86, 0.00, -1.95);
	CreateMapObject(791, 2126.11, 595.15, 5.99,   0.00, 0.00, -35.82);
	CreateMapObject(791, 2188.35, 588.90, 6.04,   0.00, 0.00, 0.00);
	CreateMapObject(791, 2068.56, 595.58, 5.99,   0.00, 0.00, 52.62);
	CreateMapObject(698, 2385.32, 606.16, 9.79,   0.00, 0.00, 34.62);
	CreateMapObject(698, 2309.29, 606.92, 9.79,   0.00, 0.00, -54.54);
	CreateMapObject(790, 2347.14, 619.77, 9.94,   0.00, 0.00, 3.14);
	CreateMapObject(698, 2255.28, 606.94, 9.79,   0.00, 0.00, -92.76);
	CreateMapObject(4298, 2121.37, 544.12, -5.74,   -10.86, 6.66, 3.90);
	CreateMapObject(4368, 2273.18, 475.02, -15.30,   4.80, 8.10, 266.34);
	CreateMapObject(18227, 2232.38, 451.61, -30.71,   -18.54, -6.06, 154.38);
	CreateMapObject(17031, 2228.15, 518.87, -16.51,   13.14, -1.32, -20.10);
	CreateMapObject(17031, 2230.42, 558.52, -18.38,   -2.94, -5.22, 12.78);
	CreateMapObject(17031, 2228.97, 573.62, 5.17,   17.94, -15.60, -4.08);
	CreateMapObject(17029, 2116.67, -87.71, -2.31,   5.94, 7.56, 215.22);
	CreateMapObject(17029, 2078.66, -83.87, -27.30,   13.02, -53.94, -0.30);
	CreateMapObject(17029, 2044.80, -36.91, -9.26,   -13.74, 27.90, 293.76);
	CreateMapObject(17029, 2242.41, 426.16, -15.43,   -21.54, 22.26, 154.80);
	CreateMapObject(17029, 2220.06, 450.07, -34.78,   -1.32, 10.20, -45.84);
	CreateMapObject(17029, 2252.49, 439.08, -19.47,   -41.40, 20.16, 331.86);
	CreateMapObject(17031, 2241.41, 431.93, -5.62,   -2.22, -4.80, 53.64);
	CreateMapObject(17029, 2141.10, -81.30, -2.41,   5.94, 7.56, 39.54);
	CreateMapObject(17031, 2277.07, 399.31, -1.65,   -2.22, -4.80, -121.74);
	CreateMapObject(17026, 2072.75, -224.40, -5.25,   0.00, 0.00, -41.22);

 	// Ramps
	CreateMapObject(1632, 2131.97, 110.24, 0.00,   0.00, 0.00, 153.72);
	CreateMapObject(1632, 2124.59, 113.69, 0.00,   0.00, 0.00, 157.56);
	CreateMapObject(1632, 2116.31, 116.44, 0.00,   0.00, 0.00, 160.08);
	CreateMapObject(1632, 2113.22, 108.48, 0.00,   0.00, 0.00, 340.20);
	CreateMapObject(1632, 2121.21, 105.21, 0.00,   0.00, 0.00, 340.20);
	CreateMapObject(1632, 2127.84, 102.06, 0.00,   0.00, 0.00, 334.68);
	CreateMapObject(1632, 2090.09, 40.90, 0.00,   0.00, 0.00, 348.36);
	CreateMapObject(1632, 2098.73, 39.12, 0.00,   0.00, 0.00, 348.36);
	CreateMapObject(1632, 2107.17, 37.94, 0.00,   0.00, 0.00, 348.36);
	CreateMapObject(1632, 2115.88, 36.47, 0.00,   0.00, 0.00, 348.36);
	CreateMapObject(1632, 2117.46, 45.86, 0.00,   0.00, 0.00, 529.20);
	CreateMapObject(1632, 2108.98, 46.95, 0.00,   0.00, 0.00, 529.20);
	CreateMapObject(1632, 2100.42, 48.11, 0.00,   0.00, 0.00, 526.68);
	CreateMapObject(1632, 2091.63, 50.02, 0.00,   0.00, 0.00, 526.80);

	return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid,0x888888FF);
	GameTextForPlayer(playerid,"~r~SA-MP: ~w~Rivershell",2000,5);
	RemoveNeededBuildingsForPlayer(playerid);

	return 1;
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	SetPlayerTeamFromClass(playerid,classid);
	
	if(classid == 0 || classid == 1) {
		GameTextForPlayer(playerid,"~g~GREEN ~w~TEAM",1000,5);
	} else if(classid == 2 || classid == 3) {
	    GameTextForPlayer(playerid,"~b~BLUE ~w~TEAM",1000,5);
	}
	
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
  	// Wait a bit before allowing them to respawn. Switch to spectate mode.
	if( GetPVarInt(playerid, "LastDeathTick") != 0 &&
	    GetTickCount() - GetPVarInt(playerid, "LastDeathTick") < (ALLOW_RESPAWN_AFTER_N_SECONDS * 1000) )
	{
	    SendClientMessage(playerid, 0xFFAAEEEE, "Waiting to respawn....");
	    TogglePlayerSpectating(playerid, 1);
	    
	    // If the last killer id is valid, we should try setting it now to avoid any camera lag switching to spectate.
    	new LastKillerId = GetPVarInt(playerid, "LastKillerId");

    	if( IsPlayerConnected(LastKillerId) &&
			(GetPlayerState(LastKillerId) == PLAYER_STATE_ONFOOT ||
			 GetPlayerState(LastKillerId) == PLAYER_STATE_DRIVER ||
			 GetPlayerState(LastKillerId) == PLAYER_STATE_PASSENGER) )
		{
	    	SpectatePlayer(playerid, LastKillerId);
	    	SetPVarInt(playerid, "SpectateState", SPECTATE_STATE_PLAYER);
		}
		
		return 1;
	}
		
	SetPlayerToTeamColor(playerid);

	if(gTeam[playerid] == TEAM_GREEN) {
	    GameTextForPlayer(playerid,
		   "Defend the ~g~GREEN ~w~team's ~y~Reefer~n~~w~Capture the ~b~BLUE ~w~team's ~y~Reefer",
		   6000,5);
	}
	else if(gTeam[playerid] == TEAM_BLUE) {
	    GameTextForPlayer(playerid,
		   "Defend the ~b~BLUE ~w~team's ~y~Reefer~n~~w~Capture the ~g~GREEN ~w~team's ~y~Reefer",
		   6000,5);
	}
	
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 100.0);
    SetPlayerWorldBounds(playerid, 2500.0, 1850.0, 631.2963, -454.9898);
    
    SetPVarInt(playerid, "SpectateState", SPECTATE_STATE_NONE);
    SetPVarInt(playerid, "SpectateMode", SPECTATE_MODE_NONE);

	return 1;
}

//---------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid)
{
 	new playervehicleid = GetPlayerVehicleID(playerid);
 	
 	if(gObjectiveReached) return;
 	
	if(playervehicleid == OBJECTIVE_VEHICLE_GREEN && gTeam[playerid] == TEAM_GREEN)
	{   // Green OBJECTIVE REACHED.
	    gGreenTimesCapped++;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    
	    if(gGreenTimesCapped==CAPS_TO_WIN) {
	        GameTextForAll("~g~GREEN ~w~team wins!",3000,5);
			gObjectiveReached = 1;	PlaySoundForAll(1185, 0.0, 0.0, 0.0);
 			SetTimer("ExitTheGameMode", 6000, 0); // Set up a timer to exit this mode.
		} else {
		    GameTextForAll("~g~GREEN ~w~team captured the ~y~boat!",3000,5);
		    SetVehicleToRespawn(OBJECTIVE_VEHICLE_GREEN);
		}
	    return;
	}
	else if(playervehicleid == OBJECTIVE_VEHICLE_BLUE && gTeam[playerid] == TEAM_BLUE)
	{   // Blue OBJECTIVE REACHED.
	    gBlueTimesCapped++;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    
	    if(gBlueTimesCapped==CAPS_TO_WIN) {
	        GameTextForAll("~b~BLUE ~w~team wins!",3000,5);
	        gObjectiveReached = 1;	PlaySoundForAll(1185, 0.0, 0.0, 0.0);
			SetTimer("ExitTheGameMode", 6000, 0); // Set up a timer to exit this mode.
		} else {
		    GameTextForAll("~b~BLUE ~w~team captured the ~y~boat!",3000,5);
		    SetVehicleToRespawn(OBJECTIVE_VEHICLE_BLUE);
		}
	    return;
	}
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
        if(gTeam[killerid] != gTeam[playerid]) {
	    	// Valid kill
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
     	}
		else {
		    // Team kill
		    SendDeathMessage(killerid,playerid,reason);
		}
	}
	
	SetPVarInt(playerid, "LastDeathTick", GetTickCount());
	SetPVarInt(playerid, "LastKillerId", killerid);

 	return 1;
}

//---------------------------------

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	// As the vehicle streams in, player team dependant params are applied. They can't be
	// applied to vehicles that don't exist in the player's world.
	
    if(vehicleid == OBJECTIVE_VEHICLE_BLUE) {
        if(gTeam[forplayerid] == TEAM_GREEN) {
			SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,forplayerid,1,1); // objective; locked
		}
		else if(gTeam[forplayerid] == TEAM_BLUE) {
		    SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,forplayerid,1,0); // objective; unlocked
		}
	}
	else if(vehicleid == OBJECTIVE_VEHICLE_GREEN) {
        if(gTeam[forplayerid] == TEAM_BLUE) {
			SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,forplayerid,1,1); // objective; locked
		}
		else if(gTeam[forplayerid] == TEAM_GREEN) {
		    SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,forplayerid,1,0); // objective; unlocked
		}
	}
	
	return 1;
	//printf("GameMode: VehicleStreamIn(%d,%d)",vehicleid,forplayerid);
}

//---------------------------------

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
	//printf("GameMode: VehicleStreamOut(%d,%d)",vehicleid,forplayerid);
}

//---------------------------------

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsPlayerNPC(playerid)) return 1;

	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) {
	    if(GetPVarInt(playerid, "LastDeathTick") == 0) {
			TogglePlayerSpectating(playerid, 0);
			return 1;
		}
	    // Allow respawn after an arbitrary time has passed
	    if(GetTickCount() - GetPVarInt(playerid, "LastDeathTick") > (ALLOW_RESPAWN_AFTER_N_SECONDS * 1000)) {
		    TogglePlayerSpectating(playerid, 0);
			return 1;
		}
		HandleSpectating(playerid);
		return 1;
	}
	
	// Check the resupply huts
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2140.83, -235.13, 7.13) || IsPlayerInRangeOfPoint(playerid, 2.5, 2318.73, 590.96, 6.75)) {
		    DoResupply(playerid);
		}
	}
	
	return 1;
}

//---------------------------------

PlaySoundForAll(soundid, Float:x, Float:y, Float:z)
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}

//---------------------------------

CreateMapObject(modelid, Float:fX, Float:fY, Float:fZ, Float:fRX, Float:fRY, Float:fRZ)
{
	return CreateObject(modelid, fX, fY, fZ, fRX, fRY, fRZ, 500.0);
}

//---------------------------------

RemoveNeededBuildingsForPlayer(playerid)
{
	if(GetPVarInt(playerid,"BuildingsRemoved") == 0) {
   		RemoveBuildingForPlayer(playerid, 9090, 2317.0859, 572.2656, -20.9688, 10.0);
		RemoveBuildingForPlayer(playerid, 9091, 2317.0859, 572.2656, -20.9688, 10.0);
		RemoveBuildingForPlayer(playerid, 13483, 2113.5781, -96.7344, 0.9844, 0.25);
		RemoveBuildingForPlayer(playerid, 12990, 2113.5781, -96.7344, 0.9844, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2119.8203, -84.4063, -0.0703, 0.25);
		RemoveBuildingForPlayer(playerid, 1369, 2104.0156, -105.2656, 1.7031, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2122.3750, -83.3828, 0.4609, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2119.5313, -82.8906, -0.1641, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2120.5156, -79.0859, 0.2188, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2119.4688, -69.7344, 0.2266, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2119.4922, -73.6172, 0.1250, 0.25);
		RemoveBuildingForPlayer(playerid, 935, 2117.8438, -67.8359, 0.1328, 0.25);
		SetPVarInt(playerid,"BuildingsRemoved",1);
	}
}


//---------------------------------

SpectatePlayer(playerid, specplayerid)
{
	if(GetPlayerState(specplayerid) == PLAYER_STATE_ONFOOT) {
		if(GetPVarInt(playerid, "SpectateMode") != SPECTATE_MODE_PLAYER) {
	    	PlayerSpectatePlayer(playerid, specplayerid);
	    	SetPVarInt(playerid, "SpectateMode", SPECTATE_MODE_PLAYER);
		}
	}
	else if( GetPlayerState(specplayerid) == PLAYER_STATE_DRIVER ||
			 GetPlayerState(specplayerid) == PLAYER_STATE_PASSENGER )
	{
	    if(GetPVarInt(playerid, "SpectateMode") != SPECTATE_MODE_VEHICLE) {
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
			SetPVarInt(playerid, "SpectateMode", SPECTATE_MODE_VEHICLE);
		}
	}
}

//---------------------------------

SpectateFixedPosition(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN) {
	    SetPlayerCameraPos(playerid, 2221.5820, -273.9985, 61.7806);
		SetPlayerCameraLookAt(playerid, 2220.9978, -273.1861, 61.4606);
	}
	else {
 		SetPlayerCameraPos(playerid, 2274.8467, 591.3257, 30.1311);
		SetPlayerCameraLookAt(playerid, 2275.0503, 590.3463, 29.9460);
	}
}

//---------------------------------

HandleSpectating(playerid)
{
    new LastKillerId = GetPVarInt(playerid, "LastKillerId");
    
    // Make sure the killer player is still active in the world
	if( IsPlayerConnected(LastKillerId) &&
		(GetPlayerState(LastKillerId) == PLAYER_STATE_ONFOOT ||
		 GetPlayerState(LastKillerId) == PLAYER_STATE_DRIVER ||
		 GetPlayerState(LastKillerId) == PLAYER_STATE_PASSENGER) )
	{
	    SpectatePlayer(playerid, LastKillerId);
	    SetPVarInt(playerid, "SpectateState", SPECTATE_STATE_PLAYER);
	}
	else
	{
		// Else switch to the fixed position camera
	    if(GetPVarInt(playerid, "SpectateState") != SPECTATE_STATE_FIXED) {
			SpectateFixedPosition(playerid);
			SetPVarInt(playerid, "SpectateState", SPECTATE_STATE_FIXED);
		}
	}
}

//---------------------------------

DoResupply(playerid)
{
	new iLastResupplyTime = GetPVarInt(playerid, "LastResupply");
	if(iLastResupplyTime == 0 || (GetTickCount() - iLastResupplyTime) > 30000) {
	    SetPVarInt(playerid, "LastResupply", GetTickCount());
	    ResetPlayerWeapons(playerid);
	    GivePlayerWeapon(playerid,31,100);
	    GivePlayerWeapon(playerid,29,200);
     	GivePlayerWeapon(playerid,34,10);
     	SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 100.0);
     	GameTextForPlayer(playerid,"Resupplied", 2000, 5);
     	PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	}
}

//---------------------------------

