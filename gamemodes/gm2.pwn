/*  SA-MP Roleplay Script
 *
 *  Script by Saint(Disloyal)
 *
 *	Script began: August 11th, 2017
 *  Last update: September 12th, 2017
 *	
 *	
 *	
 * 
 *
 */

#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <streamer>
#include <foreach>
#include <sscanf2>
#include <evi>

#define function:%0(%1) forward %0(%1); public %0(%1)

#undef MAX_PLAYERS
	#define MAX_PLAYERS  (50)
	
native gpci(playerid, serial[], len);

//Database establisher:
new ourConnection; 

#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

#define SQL_HOSTNAME "127.0.0.1"
#define SQL_USERNAME "root"
#define SQL_DATABASE "dba"
#define SQL_PASSWORD ""

//Database establisher end of.
main ()  
	{ }
	
/*	z - minor bug fixes
	y - small updates/new features
	x - big new features
*/

#define SCRIPT_REV "Rev 1.5.10.4"
	
//Max defines:
#define MAX_PROPERTY (200)

#define MAX_BUSINESS (200)
#define MAX_BUSINESS_PRODUCTS (500)

#define MAX_FACTIONS (30)
#define MAX_FACTION_RANKS (21)

#define MAX_PLAYER_VEHICLES (6)

#define MAX_XMR_CATEGORY (40)
#define MAX_XMR_CATEGORY_STATIONS (60)

#define MAX_RECORD_SHOW (6)
#define MAX_ZONE_NAME (28)

//Dialogs:
#define DIALOG_DEFAULT (0)
#define DIALOG_CONFIRM_SYS (1)

#define DIALOG_REGISTER (2)
#define DIALOG_LOGIN (3)
#define DIALOG_CHARS (4)

#define DIALOG_REPORT (5)

#define DIALOG_FACTION_CONFIG (6)
#define DIALOG_FACTION_NAME (7)
#define DIALOG_FACTION_ABBREV (8)
#define DIALOG_FACTION_ALTER_R (9)
#define DIALOG_FACTION_ALTER_J (10)
#define DIALOG_FACTION_ALTER_C (11)
#define DIALOG_FACTION_CHATCOLOR (12)
#define DIALOG_FACTION_RANKS (13)
#define DIALOG_FACTION_RANKEDIT (14)
#define DIALOG_FACTION_ALTER_T (15)

#define DIALOG_VEHICLE_WEAPONS (16)
#define DIALOG_HOUSE_WEAPONS (17)

#define DIALOG_XMR_CATEGORIES (18)
#define DIALOG_XMR_STATIONS (19)

#define DIALOG_POLICE_SKINS (20)

#define DIALOG_BUY_LIST (21)

#define DIALOG_DEALERSHIP (22)
#define DIALOG_DEALERSHIP_SELECT (23)
#define DIALOG_DEALERSHIP_APPEND (24)

#define DIALOG_DEALERSHIP_APPEND_ALARM (25)
#define DIALOG_DEALERSHIP_APPEND_LOCK (26)
#define DIALOG_DEALERSHIP_APPEND_IMMOB (27)

#define DIALOG_DEALERSHIP_APPEND_COLORMENU (28)
#define DIALOG_DEALERSHIP_APPEND_COLOR1 (29)
#define DIALOG_DEALERSHIP_APPEND_COLOR2 (30)
#define DIALOG_DEALERSHIP_PURCHASE (31)

#define DIALOG_SELECT_HOUSE (32)

#define DIALOG_MDC (33)
#define DIALOG_MDC_NAME (34)
#define DIALOG_MDC_NAME_QUEUE (35)

#define DIALOG_MDC_PLATE (36)
#define DIALOG_MDC_PLATE_QUEUE (37)
#define DIALOG_MDC_PLATE_LIST (38)
#define DIALOG_MDC_FINISH_QUEUE (39)

#define DIALOG_SECRETWORD_CREATE (40)
#define DIALOG_SECRETWORD_INPUT (41)

//Colors:
#define COLOR_RED (0xFF6347FF)
#define COLOR_REDEX (0xF81414FF)

#define COLOR_GREEN (0x0D7304FF)
#define COLOR_DARKGREEN (0x33AA33FF)

#define COLOR_YELLOW (0xFFE104FF)
#define COLOR_YELLOWEX (0xFFFF00FF)

#define COLOR_GRAD1	(0xCCE6E6FF)
#define COLOR_GRAD2	(0xE2FFFFFF)

#define COLOR_WHITE (0xFFFFFFFF)
#define COLOR_GREY 	(0xAFAFAFFF)

#define COLOR_EMOTE	(0xC2A2DAFF)
#define COLOR_REPORT (0xFFFF91FF)

#define COLOR_FADE1 (0xE6E6E6E6)
#define COLOR_FADE2 (0xC8C8C8C8)
#define COLOR_FADE3 (0xAAAAAAAA)
#define COLOR_FADE4 (0x8C8C8C8C)
#define COLOR_FADE5 (0x6E6E6E6E)

#define COLOR_COP (0x8D8DFFFF)
#define COLOR_DEPT (0xF07A7AFF)

#define COLOR_ACTION (0xF8E687FF)
#define COLOR_SAMP	(0xADC3E7FF)

#define COLOR_RADIO	(0xFFEC8BFF)
#define COLOR_RADIOEX (0xB5AF8FFF)

#define COLOR_PMRECEIVED (0xFFDC18FF)
#define COLOR_PMSENT (0xEEE854FF)

#define COLOR_CYAN (0x00FFFFFF)
#define COLOR_PINK	(0xFF8282FF)

//Client messages:
#define SendUsageMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "USAGE: "%1) 
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "ERROR: "%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "SERVER: "%1) 	
	
//Faction types:	
#define FACTION_TYPE_ILLEGAL (1)
#define FACTION_TYPE_POLICE (2)
#define FACTION_TYPE_MEDICAL (3)
#define FACTION_TYPE_DOC (4)

//Property types:
#define PROPERTY_TYPE_HOUSE (1)
#define PROPERTY_TYPE_APTCOMPLEX (2)
#define PROPERTY_TYPE_APTROOM (3)

//Business types:
#define BUSINESS_TYPE_RESTAURANT (1)
#define BUSINESS_TYPE_AMMUNATION (2)
#define BUSINESS_TYPE_CLUB (3)
#define BUSINESS_TYPE_BANK (4)
#define BUSINESS_TYPE_GENERAL (5)
#define BUSINESS_TYPE_DEALERSHIP (6)
#define BUSINESS_TYPE_DMV (7) 

//Player states:
#define PLAYER_STATE_ALIVE (1)
#define PLAYER_STATE_WOUNDED (2)
#define PLAYER_STATE_DEAD (3)

//Body parts:
#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

//Spawn points:
#define SPAWN_POINT_AIRPORT (0)
#define SPAWN_POINT_PROPERTY (1)
#define SPAWN_POINT_FACTION (2)

//Global variables:
new bool:oocEnabled = false, globalWeather = 2; 
new dmv_vehicles[4]; 

//Enumerators:
enum P_MASTER_ACCOUNTS
{
	mDBID,
	mAccName[60],
	
	mForumName[60],
	bool:mLoggedin
}

new e_pAccountData[MAX_PLAYERS][P_MASTER_ACCOUNTS]; 
new characterLister[MAX_PLAYERS][4][MAX_PLAYER_NAME + 1]; 

enum P_ACCOUNT_DATA
{
	pDBID,
	bool:pLoggedin,

	pAdmin, 
	bool:pAdminDuty,
	
	pLastSkin,
	
	pLevel,
	pEXP,
	
	Float: pLastPos[3],
	pLastInterior,
	pLastWorld,
	
	pAge[20],
	pOrigin[60],
	
	pStory[60],
	pStoryTwo[60],
	
	pMoney,
	pBank,
	pPaycheck,
	
	pPhone,
	bool:pPhoneOff,
	bool:pPhonespeaker,
	
	pPhoneline,
	pCalling, 
	
	pActiveIP[60], 
	pLastOnline[90],
	pLastOnlineTime,
	
	bool:pAdminjailed, 
	pAdminjailTime,
	
	bool:pOfflinejailed,
	pOfflinejailedReason[128],
	
	bool:pMuted,	
	pSpectating,
	
	pFaction,
	pFactionRank,
	bool:pFactionChat,
	pFactionInvite,
	pFactionInvitedBy,
	
	pOwnedVehicles[MAX_PLAYER_VEHICLES],
	bool:pVehicleSpawned,
	pVehicleSpawnedID,
	pDuplicateKey,
	
	bool:pWeaponsSpawned,
	pWeaponsImmune,
	pWeapons[4], 
	pWeaponsAmmo[4],
	
	bool:pUnscrambling,
	pUnscramblerTime,
	pUnscrambleTimer,
	pUnscrambleID,
	pScrambleSuccess,
	pScrambleFailed,
	
	bool:pPoliceDuty,
	bool:pMedicDuty,
	
	pTimeplayed,
	
	pInsideProperty,
	pInsideBusiness,
	pAtDealership,
	
	pMaskID[2],
	bool:pMasked,
	
	pLastDamagetime,
	
	bool:pRelogging,
	pRelogCount,
	Text3D:pRelogTD,
	pRelogTimer,
	
	pPauseCheck,
	pPauseTime,
	
	pAddObject,
	pEditingObject,
	
	pHandcuffed,
	
	pGascan,
	bool:pHasMask,
	
	bool:pHasRadio,
	pRadio[3],
	pMainSlot,
	
	pRespawnTime,
	pDeathFix,
	
	pSpawnPoint,
	pSpawnPointHouse,
	
	bool:pTaser,
	
	pWeaponsLicense,
	pDriversLicense,
	
	pActiveListings,
	pPrisonTimes,
	pJailTimes
}

new PlayerInfo[MAX_PLAYERS][P_ACCOUNT_DATA];

new registerTime[MAX_PLAYERS], loginTime[MAX_PLAYERS], characterPickTime[MAX_PLAYERS];
new playerLastpay[MAX_PLAYERS], playerTaserAmmo[MAX_PLAYERS]; 

new 
	PlayerCheckpoint[MAX_PLAYERS], 
	playerWeaponsSave[MAX_PLAYERS][4], 
	playerWeaponsAmmoSave[MAX_PLAYERS][4]; 
	
new 
	bool:playerTextdraw[MAX_PLAYERS],
	Text3D:playerVehicleTextdraw[MAX_PLAYERS];

enum G_REPORT_INFO
{
	bool:rReportExists,
	rReportDetails[90], 
	rReportTime,
	rReportBy[32]
}

new ReportInfo[100][G_REPORT_INFO]; 
new playerReport[MAX_PLAYERS][128]; 

enum E_FACTION_INFO
{
	eFactionDBID,
	
	eFactionName[90],
	eFactionAbbrev[30], 
	
	Float: eFactionSpawn[3],
	eFactionSpawnInt,
	eFactionSpawnWorld,
	
	eFactionJoinRank,
	eFactionAlterRank,
	eFactionChatRank,
	eFactionTowRank,
	
	bool:eFactionChatStatus,
	eFactionChatColor,
	
	eFactionType	
}

new FactionInfo[MAX_FACTIONS][E_FACTION_INFO]; 
new FactionRanks[MAX_FACTIONS][MAX_FACTION_RANKS][60]; 
new playerEditingRank[MAX_PLAYERS];

enum E_VEHICLE_SYSTEM
{
	eVehicleDBID, 
	bool:eVehicleExists,
	
	eVehicleOwnerDBID,
	eVehicleFaction,
	
	eVehicleModel, 
	eVehicleColor1,
	eVehicleColor2,
	eVehiclePaintjob,
	
	Float:eVehicleParkPos[4],
	eVehicleParkInterior,
	eVehicleParkWorld,
	
	eVehiclePlates[32], 
	bool:eVehicleLocked,
	
	bool:eVehicleImpounded,
	Float:eVehicleImpoundPos[4], 
	
	eVehicleWeapons[6], //5;
	eVehicleWeaponsAmmo[6], //5;
	
	eVehicleFuel,
	eVehicleSirens,
	
	eVehicleLastDrivers[5], //4;
	eVehicleLastPassengers[5], //4;
	
	bool:eVehicleLights,
	bool:eVehicleEngineStatus,
	
	bool:eVehicleAdminSpawn,
	
	Text3D:eVehicleTowDisplay,
	eVehicleTowCount,
	
	bool:eVehicleHasXMR, 
	bool:eVehicleXMROn,
	eVehicleXMRURL[128],
	
	Float:eVehicleBattery,
	Float:eVehicleEngine, 
	eVehicleTimesDestroyed,
	
	eVehicleLockLevel,
	eVehicleAlarmLevel, 
	eVehicleImmobLevel,
	
	Text3D:eVehicleEnterTD,
	eVehicleEnterTimer,
	
	bool:eVehicleHasCarsign,
	Text3D:eVehicleCarsign,
	
	eVehicleRefillCount,
	Text3D:eVehicleRefillDisplay
}

new VehicleInfo[MAX_VEHICLES][E_VEHICLE_SYSTEM]; 

new
	lastVehicleSpawn[MAX_PLAYERS], 
	bool:playerTowingVehicle[MAX_PLAYERS], 
	playerTowTimer[MAX_PLAYERS]
;

new playerInsertID[MAX_PLAYERS];

new playerRefillingVehicle[MAX_PLAYERS], playerRefillTimer[MAX_PLAYERS]; 

enum E_UNSCRAMBLER_DATA
{
	eUnscrambleLevel,
	eScrambledWord[60],
	eUnscrambledWord[60]
}

new UnscrambleInfo[][E_UNSCRAMBLER_DATA] = 
{
	{1, "Nwe", "New"},
  {2, "Relseea", "Release"},
  {3, "Scritp", "Script"}
  //The values are the immobiliser level the word will show for. 
  //I recommend having them equally the same amount. Up to you. 
  // /unscramble usage. 
};

enum E_DROPPEDGUN_DATA
{
	bool:eWeaponDropped,
	eWeaponObject,
	eWeaponTimer,
	
	eWeaponWepID,
	eWeaponWepAmmo,
	
	Float:eWeaponPos[3],
	eWeaponInterior,
	eWeaponWorld,
	
	eWeaponDroppedBy
}

new WeaponDropInfo[200][E_DROPPEDGUN_DATA];

enum E_PROPERTY_DATA
{
	ePropertyDBID,
	ePropertyOwnerDBID,
	
	ePropertyType,
	ePropertyFaction,
	
	Float:ePropertyEntrance[3],
	ePropertyEntranceInterior,
	ePropertyEntranceWorld,
	
	Float:ePropertyInterior[3],
	ePropertyInteriorIntID,
	ePropertyInteriorWorld,
	
	ePropertyMarketPrice,
	ePropertyLevel,
	
	bool:ePropertyLocked,
	
	ePropertyCashbox,
	ePropertyWeapons[21],
	ePropertyWeaponsAmmo[21],
	
	Float:ePropertyPlacePos[3],
	
	bool:ePropertyHasBoombox,
	ePropertyBoomboxObject,
	
	Float: ePropertyBoomboxPos[3],
	Float: ePropertyBoomboxRot[3],
	
	bool:ePropertyBoomboxOn,
	ePropertyBoomboxURL
}

new PropertyInfo[MAX_PROPERTY][E_PROPERTY_DATA]; 

enum E_XMR_CATEGORY_DATA
{
	eXMRID,
	eXMRCategoryName[90]
}

enum E_XMR_CATEGORY_STATIONS_DATA
{
	eXMRStationID,
	eXMRCategory,
	
	eXMRStationName[90],
	eXMRStationURL[128]
}

new XMRCategoryInfo[MAX_XMR_CATEGORY][E_XMR_CATEGORY_DATA];
new XMRStationInfo[MAX_XMR_CATEGORY_STATIONS][E_XMR_CATEGORY_STATIONS_DATA]; 

new CatXMRHolder[MAX_PLAYERS], SubXMRHolder[MAX_PLAYERS]; 
new SubXMRHolderArr[MAX_PLAYERS][MAX_XMR_CATEGORY]; 

enum E_BUSINESS_DATA
{
	eBusinessDBID,
	eBusinessOwnerDBID,
	
	Float:eBusinessInterior[3], 
	eBusinessInteriorWorld,
	eBusinessInteriorIntID, 
	
	Float:eBusinessEntrance[3],
	
	eBusinessName[90], 
	
	eBusinessType, 
	eBusinessPickup, 
	
	bool:eBusinessLocked,
	eBusinessEntranceFee,
	
	eBusinessLevel,
	eBusinessMarketPrice,
	
	eBusinessCashbox,
	eBusinessProducts,
	
	eBusinessBankPickup,
	Float:eBusinessBankPickupLoc[3], 
	eBusinessBankPickupWorld
}

new BusinessInfo[MAX_BUSINESS][E_BUSINESS_DATA]; 

enum E_DEALERSHIP_DATA
{
	eDealershipType,
	eDealershipCategory,
	
	eDealershipModel[128],
	eDealershipModelID,
	
	eDealershipPrice
}

new CatDealershipHolder[MAX_PLAYERS], SubDealershipHolder[MAX_PLAYERS];
new SubDealershipHolderArr[MAX_PLAYERS][200];

new DealershipPlayerCar[MAX_PLAYERS], DealershipTotalCost[MAX_PLAYERS];
new DealershipAlarmLevel[MAX_PLAYERS], DealershipImmobLevel[MAX_PLAYERS];
new DealershipLockLevel[MAX_PLAYERS], DealershipXMR[MAX_PLAYERS];
new DealershipCarColors[MAX_PLAYERS][2], bool:PlayerPurchasingVehicle[MAX_PLAYERS]; 

enum
{	
	DEALERSHIP_CATEGORY_AIRCRAFTS,
	DEALERSHIP_CATEGORY_BOATS,
	DEALERSHIP_CATEGORY_BIKES,
	DEALERSHIP_CATEGORY_TWODOOR,
	DEALERSHIP_CATEGORY_FOURDOOR,
	DEALERSHIP_CATEGORY_CIVIL,
	DEALERSHIP_CATEGORY_HEAVY,
	DEALERSHIP_CATEGORY_VANS,
	DEALERSHIP_CATEGORY_SUV,
	DEALERSHIP_CATEGORY_MUSCLE,
	DEALERSHIP_CATEGORY_RACERS
}

new g_aDealershipData[][E_DEALERSHIP_DATA] = {
	{0, DEALERSHIP_CATEGORY_AIRCRAFTS, "Maverick", 487, 1500000},
	{1, DEALERSHIP_CATEGORY_BOATS, "Squallo", 446, 200000},
	{2, DEALERSHIP_CATEGORY_BIKES, "Bike", 509, 500},
	{2, DEALERSHIP_CATEGORY_BIKES, "BMX", 481, 500},
	{2, DEALERSHIP_CATEGORY_BIKES, "Mountain Bike", 510, 1000},
	{2, DEALERSHIP_CATEGORY_BIKES, "Faggio", 462, 8000},
	{2, DEALERSHIP_CATEGORY_BIKES, "FCR-900", 521, 130000},
	{2, DEALERSHIP_CATEGORY_BIKES, "Freeway", 463, 50000},
	{2, DEALERSHIP_CATEGORY_BIKES, "Sanchez", 468, 100000},
	{2, DEALERSHIP_CATEGORY_BIKES, "Wayfarer", 586, 50000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Alpha", 602, 250000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Blista Compact", 496, 60000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Bravura", 401, 9000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Buccaneer", 518, 25000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Cadrona", 527, 15000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Club", 589, 30000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Esperanto", 419, 25000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Euros", 587, 250000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Feltzer", 533, 90000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Fortune", 526, 40000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Hermes", 474, 100000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Hustler", 545, 70000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Majestic", 517, 45000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Manana", 410, 10000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Picador", 600, 35000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Previon", 436, 10000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Stallion", 439, 110000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Tampa", 549, 20000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Virgo", 491, 55000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Blade", 536, 50000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Broadway", 575, 59000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Remington", 534, 45000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Slamvan", 535, 75000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Tornado", 576, 65000},
	{3, DEALERSHIP_CATEGORY_TWODOOR, "Voodoo", 412, 40000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Admiral", 445, 40000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Glendale", 604, 35000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Elegant", 507, 60000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Greenwood", 492, 15000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Intruder", 546, 19000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Merit", 551, 50000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Nebula", 516, 20000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Oceanic", 467, 35000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Premier", 426, 100000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Primo", 547, 35000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Sentinel", 405, 90000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Stafford", 580, 120000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Stretch", 409, 250000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Sunrise", 550, 110000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Tahoma", 566, 55000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Vincent", 540, 40000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Washington", 421, 60000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Willard", 529, 15000},
	{4, DEALERSHIP_CATEGORY_FOURDOOR, "Savanna", 567, 80000},
	{5, DEALERSHIP_CATEGORY_CIVIL, "Bus", 431, 120000},
	{5, DEALERSHIP_CATEGORY_CIVIL, "Cabbie", 438, 45000},
	{5, DEALERSHIP_CATEGORY_CIVIL, "Taxi", 420, 35000},
	{5, DEALERSHIP_CATEGORY_CIVIL, "Towtruck", 525, 15000},
	{5, DEALERSHIP_CATEGORY_CIVIL, "Trashmaster", 408, 70000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Benson", 499, 50000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Boxville", 609, 30000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Combine Harvester", 532, 100000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "DFT-30", 578, 60000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Hotdog Truck", 588, 25000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Linerunner", 403, 150000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Mr. Whoopee", 423, 35000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Mule", 414, 40000}, 
	{6, DEALERSHIP_CATEGORY_HEAVY, "Packer", 443, 75000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Roadtrain", 515, 150000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Tanker", 514, 155000},
	{6, DEALERSHIP_CATEGORY_HEAVY, "Yankee", 456, 80000},
	{7, DEALERSHIP_CATEGORY_VANS, "Berkley's RC Van", 459, 50000},
	{7, DEALERSHIP_CATEGORY_VANS, "Bobcat", 422, 15000},
	{7, DEALERSHIP_CATEGORY_VANS, "Burrito", 482, 70000},
	{7, DEALERSHIP_CATEGORY_VANS, "Sadler", 605, 16000},
	{7, DEALERSHIP_CATEGORY_VANS, "Moonbeam", 418, 20000},
	{7, DEALERSHIP_CATEGORY_VANS, "Pony", 413, 15000},
	{7, DEALERSHIP_CATEGORY_VANS, "Rumpo", 440, 30000},
	{7, DEALERSHIP_CATEGORY_VANS, "Sadler", 543, 10000},
	{7, DEALERSHIP_CATEGORY_VANS, "Walton", 478, 40000},
	{7, DEALERSHIP_CATEGORY_VANS, "Yosemite", 554, 90000},
	{8, DEALERSHIP_CATEGORY_SUV, "Huntley", 579, 200000},
	{8, DEALERSHIP_CATEGORY_SUV, "Landstalker", 400, 120000},
	{8, DEALERSHIP_CATEGORY_SUV, "Perennial", 404, 60000},
	{8, DEALERSHIP_CATEGORY_SUV, "Rancher", 489, 35000},
	{8, DEALERSHIP_CATEGORY_SUV, "Regina", 479, 40000},
	{8, DEALERSHIP_CATEGORY_SUV, "Romero", 442, 50000},
	{8, DEALERSHIP_CATEGORY_SUV, "Solair", 458, 45000},
	{9, DEALERSHIP_CATEGORY_MUSCLE, "Buffalo", 402, 130000},
	{9, DEALERSHIP_CATEGORY_MUSCLE, "Clover", 542, 25000},
	{9, DEALERSHIP_CATEGORY_MUSCLE, "Phoenix", 603, 90000},
	{9, DEALERSHIP_CATEGORY_MUSCLE, "Sabre", 475, 50000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Banshee", 429, 60000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Bullet", 541, 350000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Cheetah", 415, 450000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Comet", 480, 120000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Elegy", 562, 85000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Flash", 565, 70000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Jester", 559, 40000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Stratum", 561, 50000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Sultan", 560, 250000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Super GT", 506, 130000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Uranus", 558, 69000},
	{10, DEALERSHIP_CATEGORY_RACERS, "Windsor", 555, 100000},
	{10, DEALERSHIP_CATEGORY_RACERS, "ZR-350", 477, 100000}
};

enum E_DAMAGE_INFO
{
	eDamageTaken,
	eDamageTime,
	
	eDamageWeapon,
	
	eDamageBodypart,
	eDamageArmor,
	
	eDamageBy
}

new DamageInfo[MAX_PLAYERS][100][E_DAMAGE_INFO]; 
new TotalPlayerDamages[MAX_PLAYERS];

enum E_LICENSETEST_INFO
{
	Float: eCheckpointX,
	Float: eCheckpointY,
	Float: eCheckpointZ,
	bool: eFinishLine
}

new LicensetestInfo[][E_LICENSETEST_INFO] = 
{
	{1237.5154, -1572.2375, 13.3828, false},
	{1186.1718, -1572.1316, 13.3828, false},
	{1122.9329, -1572.2052, 13.4022, false},
	{1046.1570, -1569.9575, 13.3828, false},
	{1050.3602, -1506.8011, 13.3906, false},
	{1065.1661, -1416.7653, 13.4577, false},
	{1183.5283, -1405.4906, 13.2156, false},
	{1261.6847, -1405.8959, 13.0086, false},
	{1332.1536, -1405.6932, 13.3703, false},
	{1324.8597, -1486.7848, 13.3828, false},
	{1295.2579, -1561.2516, 13.3906, true}
};

enum E_SAZONE_MAIN 
{
    SAZONE_NAME[28],
    Float:SAZONE_AREA[6]
}

//
static const VehicleColoursTableRGBA[256] =
{
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

static const g_aDealershipCategory[][] = {
	{"Aircrafts"},
	{"Boats"},
	{"Bikes"},
	{"2-Door & Compact cars"},
	{"4-Door & Luxury cars"},
	{"Civil Service"},
	{"Heavy & Utility Trucks"},
	{"Light trucks & Vans"},
	{"SUVs & Wagons"},
	{"Muscle Cars"},
	{"Street Racers"}
};

static const s_TopSpeed[212] = {
    157, 147, 186, 110, 133, 164, 110, 148, 100, 158, 129, 221, 168, 110, 105, 192, 154, 270,
    115, 149, 145, 154, 140, 99, 135, 270, 173, 165, 157, 201, 190, 130, 94, 110, 167, 0, 149,
    158, 142, 168, 136, 145, 139, 126, 110, 164, 270, 270, 111, 0, 0, 193, 270, 60, 135, 157,
    106, 95, 157, 136, 270, 160, 111, 142, 145, 145, 147, 140, 144, 270, 157, 110, 190, 190,
    149, 173, 270, 186, 117, 140, 184, 73, 156, 122, 190, 99, 64, 270, 270, 139, 157, 149, 140,
    270, 214, 176, 162, 270, 108, 123, 140, 145, 216, 216, 173, 140, 179, 166, 108, 79, 101, 270,
    270, 270, 120, 142, 157, 157, 164, 270, 270, 160, 176, 151, 130, 160, 158, 149, 176, 149, 60,
    70, 110, 167, 168, 158, 173, 0, 0, 270, 149, 203, 164, 151, 150, 147, 149, 142, 270, 153, 145,
    157, 121, 270, 144, 158, 113, 113, 156, 178, 169, 154, 178, 270, 145, 165, 160, 173, 146, 0, 0,
    93, 60, 110, 60, 158, 158, 270, 130, 158, 153, 151, 136, 85, 0, 153, 142, 165, 108, 162, 0, 0,
    270, 270, 130, 190, 175, 175, 175, 158, 151, 110, 169, 171, 148, 152, 0, 0, 0, 108, 0, 0
}; //Credits to Emmet (Extended Vehicle function)

new possibleVehiclePlates[][] = 
	{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
	
static const g_aPreloadLibs[][] =
{
	"AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
	"BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
	"CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
	"DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
	"FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
	"GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
	"GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
	"INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
	"KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
	"MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
	"MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
	"PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
	"POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
	"QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
	"ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
	"SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
	"SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
	"STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
	"SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
	"TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
	"WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};

static const gSAZones[][E_SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
        //      NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
        {"The Big Ear",                 {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
        {"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
        {"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
        {"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
        {"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
        {"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
        {"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
        {"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
        {"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
        {"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
        {"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
        {"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
        {"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
        {"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
        {"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
        {"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
        {"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
        {"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
        {"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
        {"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
        {"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
        {"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
        {"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
        {"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
        {"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
        {"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
        {"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
        {"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
        {"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
        {"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
        {"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
        {"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
        {"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
        {"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
        {"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
        {"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
        {"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
        {"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
        {"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
        {"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
        {"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
        {"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
        {"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
        {"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
        {"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
        {"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
        {"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
        {"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
        {"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
        {"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
        {"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
        {"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
        {"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
        {"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
        {"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
        {"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
        {"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
        {"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
        {"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
        {"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
        {"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
        {"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
        {"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
        {"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
        {"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
        {"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
        {"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
        {"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
        {"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
        {"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
        {"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
        {"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
        {"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
        {"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
        {"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
        {"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
        {"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
        {"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
        {"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
        {"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
        {"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
        {"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
        {"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
        {"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
        {"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
        {"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
        {"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
        {"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
        {"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
        {"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
        {"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
        {"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
        {"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
        {"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
        {"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
        {"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
        {"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
        {"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
        {"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
        {"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
        {"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
        {"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
        {"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
        {"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
        {"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
        {"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
        {"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
        {"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
        {"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
        {"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
        {"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
        {"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
        {"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
        {"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
        {"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
        {"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
        {"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
        {"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
        {"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
        {"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
        {"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
        {"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
        {"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
        {"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
        {"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
        {"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
        {"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
        {"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
        {"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
        {"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
        {"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
        {"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
        {"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
        {"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
        {"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
        {"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
        {"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
        {"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
        {"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
        {"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
        {"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
        {"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
        {"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
        {"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
        {"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
        {"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
        {"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
        {"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
        {"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
        {"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
        {"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
        {"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
        {"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
        {"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
        {"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
        {"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
        {"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
        {"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
        {"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
        {"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
        {"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
        {"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
        {"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
        {"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
        {"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
        {"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
        {"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
        {"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
        {"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
        {"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
        {"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
        {"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
        {"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
        {"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
        {"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
        {"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
        {"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
        {"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
        {"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
        {"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
        {"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
        {"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
        {"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
        {"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
        {"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
        {"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
        {"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
        {"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
        {"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
        {"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
        {"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
        {"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
        {"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
        {"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
        {"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
        {"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
        {"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
        {"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
        {"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
        {"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
        {"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
        {"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
        {"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
        {"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
        {"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
        {"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
        {"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
        {"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
        {"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
        {"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
        {"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
        {"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
        {"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
        {"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
        {"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
        {"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
        {"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
        {"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
        {"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
        {"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
        {"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
        {"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
        {"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
        {"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
        {"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
        {"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
        {"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
        {"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
        {"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
        {"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
        {"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
        {"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
        {"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
        {"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
        {"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
        {"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
        {"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
        {"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
        {"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
        {"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
        {"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
        {"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
        {"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
        {"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
        {"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
        {"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
        {"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
        {"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
        {"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
        {"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
        {"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
        {"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
        {"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
        {"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
        {"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
        {"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
        {"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
        {"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
        {"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
        {"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
        {"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
        {"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
        {"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
        {"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
        {"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
        {"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
        {"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
        {"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
        {"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
        {"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
        {"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
        {"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
        {"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
        {"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
        {"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
        {"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
        {"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
        {"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
        {"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
        {"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
        {"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
        {"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
        {"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
        {"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
        {"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
        {"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
        {"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
        {"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
        {"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
        {"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
        {"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
        {"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
        {"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
        {"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
        {"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
        {"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
        {"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
        {"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
        {"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
        {"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
        {"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
        {"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
        {"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
        {"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
        {"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
        {"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
        {"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
        {"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
        {"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
        {"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
        {"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
        {"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
        {"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
        {"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
        {"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
        {"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
        {"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
        {"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
        {"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
        {"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
        {"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
        {"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
        {"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
        {"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
        {"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
        {"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
        {"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
        {"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
        {"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
        {"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
        {"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
        {"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
        {"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
        {"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
        {"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
        {"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
        {"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
        {"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
        {"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
        {"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
        {"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
        {"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
        {"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
        {"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
        {"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
        {"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
        {"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
        {"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
        {"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
        {"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
        {"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
        {"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
        {"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
        {"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
        {"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
        {"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
        // Main Zones
        {"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
        {"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
        {"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
        {"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
        {"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
        {"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
        {"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
        {"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
        {"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

//Essential character variables:
new bool:playerMakingCharacter[MAX_PLAYERS], playerCharacterStep[MAX_PLAYERS];
new playerCharactersName[MAX_PLAYERS][MAX_PLAYER_NAME + 1]; 
new playerCharactersAge[MAX_PLAYERS][20], playerCharacterOrigin[MAX_PLAYERS][60]; 
new playerCharacterStory[MAX_PLAYERS][2][90]; 

//Player variables:
new playerLogin[MAX_PLAYERS] = 0, playerHouseSelect[MAX_PLAYERS][3]; 
new playerPhone[MAX_PLAYERS], playerText[MAX_PLAYERS];

new bool:PlayerTakingLicense[MAX_PLAYERS], PlayerLicenseTime[MAX_PLAYERS]; 
new PlayerLicensePoint[MAX_PLAYERS]; 
new PlayersLicenseVehicle[MAX_PLAYERS]; 

new Player911Type[MAX_PLAYERS], Player911Timer[2][MAX_PLAYERS]; 
new Player911Text[MAX_PLAYERS][3][128]; 

new PlayerMDCTimer[MAX_PLAYERS], PlayerMDCCount[MAX_PLAYERS];
new PlayerMDCName[MAX_PLAYERS][32], PlayerPlateSaver[MAX_PLAYERS][5][20]; 

new PlayerText:Unscrambler_PTD[MAX_PLAYERS][7]; 
new PlayerText:CarBought_PTD[MAX_PLAYERS][2]; 

//Dynamic areas:
new ImpoundLotArea; 

//Start of functions:
public OnGameModeInit()
{
	SetGameModeText(SCRIPT_REV); 
	ourConnection = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_DATABASE, SQL_PASSWORD);
	
	if(mysql_errno() != 0)	
		printf ("[DATABASE]: Connection failed to '%s'...", SQL_DATABASE);
		
	else printf ("[DATABASE]: Connection established to '%s'...", SQL_DATABASE);
	
	mysql_log(LOG_ERROR | LOG_WARNING);
	
	//Disabling single player entities:
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetNameTagDrawDistance(20.0);

	EnableStuntBonusForAll(0);
	
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	
	//Configure world:
	SetWeather(globalWeather); 
	
	new 
		hour, seconds, minute;
		
	gettime(hour, seconds, minute); 
	SetWorldTime(hour); 
  
	//Global timers:
	SetTimer("FunctionPlayers", 1000, true); 
	SetTimer("OnWeaponsUpdate", 1000, true);
	SetTimer("FunctionPaychecks", 1000, true);
	SetTimer("OnPlayerNearProperty", 3000, true);
	SetTimer("OnPlayerNearBusiness", 3000, true); 
	SetTimer("OnVehicleUpdate", 1500, true); 
	
	//Loading systems:
	mysql_tquery(ourConnection, "SELECT * FROM factions ORDER BY dbid ASC", "Query_LoadFactions"); 
	mysql_tquery(ourConnection, "SELECT * FROM vehicles WHERE VehicleFaction > 0", "Query_LoadVehicles"); 
	mysql_tquery(ourConnection, "SELECT * FROM properties ORDER BY PropertyDBID", "Query_LoadProperties");
	mysql_tquery(ourConnection, "SELECT * FROM xmr_categories ORDER BY XMRDBID ASC", "Query_LoadXMRCategories"); 
	mysql_tquery(ourConnection, "SELECT * FROM xmr_stations ORDER BY XMRStationDBID ASC", "Query_LoadXMRStations");
	mysql_tquery(ourConnection, "SELECT * FROM businesses ORDER BY BusinessDBID ASC", "Query_LoadBusinesses"); 
	
	//DMV vehicles:
	dmv_vehicles[0] = AddStaticVehicle(405, 1273.0470, -1557.0576, 13.5405, -91.0000, 1, 1); SetVehicleNumberPlate(dmv_vehicles[0], "DMV");
	dmv_vehicles[1] = AddStaticVehicle(405, 1273.0470, -1549.9562, 13.5405, -91.0000, 1, 1); SetVehicleNumberPlate(dmv_vehicles[1], "DMV");
	dmv_vehicles[2] = AddStaticVehicle(405, 1273.0470, -1542.8961, 13.5405, -91.0000, 1, 1); SetVehicleNumberPlate(dmv_vehicles[2], "DMV");
	dmv_vehicles[3] = AddStaticVehicle(405, 1273.0470, -1536.0962, 13.5405, -91.0000, 1, 1); SetVehicleNumberPlate(dmv_vehicles[3], "DMV");
	
	//Areas:
	ImpoundLotArea = CreateDynamicCircle(-1098.6909, -973.7175, 140.0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	foreach (new i : Player)
	{
		SetPlayerName(i, e_pAccountData[i][mAccName]);
		SaveCharacter(i); SaveCharacterPos(i);
	}
	
	//Saving systems:
	SaveFactions();
	SaveProperties();
	SaveBusinesses();
	
	//Closing database:
	mysql_close(ourConnection);
	return 1;
}

public OnPlayerConnect(playerid)
{
	ResetPlayer(playerid);
	PreloadAnimations(playerid); 
	
	SetPlayerColor(playerid, 0xAFAFAFFF); 
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE); 
	
	//Dualies;
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 899);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);

	new 
		existCheck[60]
	; 
	
	mysql_format(ourConnection, existCheck, sizeof(existCheck), "SELECT * FROM bannedlist WHERE IpAddress = '%e'", ReturnIP(playerid));
	mysql_tquery(ourConnection, existCheck, "CheckBanList", "i", playerid);
	// We'll check if their IP is linked to any players on the bannedlist.
	// A master account DBID ban will be checked once they login. 
	
	SetPlayerCamera(playerid);
	
	//Unscrambler Textdraws:
	Unscrambler_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 199.873275, 273.593383, "<UNSCRAMBLED_WORD>");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][0], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);

	Unscrambler_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 137.369461, 273.593383, "/unscramble");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][1], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][1], -490707969);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);

	Unscrambler_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 305.179687, 273.593383, "TO_UNSCRAMBLE_THE_WORD");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][2], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][2], -2147483393);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);

	Unscrambler_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 141.369705, 285.194091, "scrambledword");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][3], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);

	Unscrambler_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 137.902801, 296.924377, "YOU_HAVE");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][4], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][4], -2147483393);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);

	Unscrambler_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 184.539016, 297.024383, "001");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][5], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);

	Unscrambler_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 202.540191, 297.124389, "SECONDS_LEFT_TO_FINISh.");
	PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][6], 0.206330, 1.118813);
	PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][6], -2147483393);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
	
	//Plate Textdraw:
	CarBought_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 97.333351, 291.629669, "YOUR_NEW_PLATE_HAS_BEEN_SET");
	PlayerTextDrawLetterSize(playerid, CarBought_PTD[playerid][0], 0.248666, 1.259851);
	PlayerTextDrawAlignment(playerid, CarBought_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, CarBought_PTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, CarBought_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, CarBought_PTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, CarBought_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, CarBought_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, CarBought_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, CarBought_PTD[playerid][0], 0);

	CarBought_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 97.533348, 302.630340, "PLATEHERE");
	PlayerTextDrawLetterSize(playerid, CarBought_PTD[playerid][1], 0.248666, 1.259851);
	PlayerTextDrawAlignment(playerid, CarBought_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, CarBought_PTD[playerid][1], -490707969);
	PlayerTextDrawSetShadow(playerid, CarBought_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, CarBought_PTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, CarBought_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, CarBought_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, CarBought_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, CarBought_PTD[playerid][1], 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][rReportBy] == playerid)
		{
			ReportInfo[i][rReportExists] = false; 
			ReportInfo[i][rReportBy] = INVALID_PLAYER_ID;
		}
	}
	
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pFactionInvitedBy] == playerid)
		{
			PlayerInfo[i][pFactionInvite] = 0;
			PlayerInfo[i][pFactionInvitedBy] = INVALID_PLAYER_ID;
			SendClientMessage(i, COLOR_YELLOW, "Your faction invitation was disregarded. Your inviter disconnected.");
		}
	}

	new playerTime = NetStats_GetConnectedTime(playerid);
	new secondsConnection = (playerTime % (1000*60*60)) / (1000*60);
	// Converting their connection time into minutes;
	
	PlayerInfo[playerid][pLastOnlineTime] = secondsConnection;
	SaveCharacter(playerid); SaveCharacterPos(playerid);
	return 1; 
}

function:SetPlayerCamera(playerid)
{
	new rand = random(3);

	switch(rand)
	{
		case 0:
		{
   			SetPlayerCameraPos(playerid, 1249.3018, -1697.8046, 99.9554);
			SetPlayerCameraLookAt(playerid, 1249.6576, -1696.8656, 99.4902);
		}
		case 1:
		{
   			SetPlayerCameraPos(playerid, 2151.2539, -1894.5447, 85.3924);
			SetPlayerCameraLookAt(playerid, 2150.5833, -1893.8066, 84.6774);
		}
		case 2:
		{
   			SetPlayerCameraPos(playerid, 2169.0635, -1740.4182, 112.0308);
			SetPlayerCameraLookAt(playerid, 2170.0603, -1740.3655, 111.3108);
		}
	}
	return 1;
}

function:CheckBanList(playerid)
{	
	if(!cache_num_rows())
	{
		new existCheck[129];
	
		mysql_format(ourConnection, existCheck, sizeof(existCheck), "SELECT acc_dbid FROM masters WHERE acc_name = '%e'", ReturnName(playerid));
		mysql_tquery(ourConnection, existCheck, "LogPlayerIn", "i", playerid);
	}
	else
	{
		SendServerMessage(playerid, "Your IP \"%s\" is banned from our servers.", ReturnIP(playerid));
		SendServerMessage(playerid, "You may appeal your ban on our forums."); 
		return KickEx(playerid);
	}
	return 1;
}

function:LogPlayerIn(playerid)
{		
	if(!cache_num_rows())
	{	
		for(new i = 0; i < 3; i ++) { SendClientMessage(playerid, -1, " "); }
		
		SendClientMessageEx(playerid, COLOR_YELLOWEX, "The user (%s) you're connected with is not a registered master account.", ReturnName(playerid));
		SendClientMessage(playerid, -1, "You need to register this user to continue.");
		
		registerTime[playerid] = 1;
		
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server", "SERVER: You have 60 seconds to register!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Select", "Cancel");
		return 1;
	}
	
	loginTime[playerid] = 1; 

	SendClientMessageEx(playerid, COLOR_YELLOW, "Welcome to Beta Server, %s {FFFFFF}["SCRIPT_REV"]", ReturnName(playerid));
	return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server", "SERVER: You have 60 seconds to login!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Select", "Cancel");
}

function:OnSecretWordInput(playerid)
{
	if(!cache_num_rows())
	{
		SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You entered a bad security word. This was logged for security reasons.");
		KickEx(playerid);
		return 1;
	}
	
	new logquery[128];
	
	mysql_format(ourConnection, logquery, sizeof(logquery), "SELECT * FROM bannedlist WHERE MasterDBID = %i", e_pAccountData[playerid][mDBID]);
	mysql_tquery(ourConnection, logquery, "Query_CheckBannedAccount", "i", playerid); 

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(!PlayerCheckpoint[playerid])
	{	
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		DisablePlayerCheckpoint(playerid);
	}
	
	if(PlayerCheckpoint[playerid] == 1)
	{
		GameTextForPlayer(playerid, "~p~You have found it!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
	}
	
	if(PlayerTakingLicense[playerid])
	{
		if(PlayerCheckpoint[playerid] == 2)
		{
			StopDriverstest(playerid);
			SendClientMessageEx(playerid, COLOR_RED, "Congratulations %s, you've passed your test.", ReturnName(playerid, 0)); 
			
			PlayerInfo[playerid][pDriversLicense] = 1;
			SaveCharacter(playerid);
			
			PlayerCheckpoint[playerid] = 0; 
			return 1; 
		}
	
		if(PlayerLicensePoint[playerid] < sizeof LicensetestInfo)
		{
			SendClientMessage(playerid, COLOR_GREY, "License instructor says: Head to the next checkpoint."); 
			PlayerLicensePoint[playerid]++; 
			
			new 
				idx = PlayerLicensePoint[playerid]
			;
			
			SetPlayerCheckpoint(playerid, LicensetestInfo[idx][eCheckpointX], LicensetestInfo[idx][eCheckpointY], LicensetestInfo[idx][eCheckpointZ], 3.0);
			
			if(LicensetestInfo[idx][eFinishLine])
			{
				//StopDriverstest(playerid);
				PlayerCheckpoint[playerid] = 2;
			}
		}
	}
	
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case DIALOG_CONFIRM_SYS:
		{
			ConfirmDialog_Response(playerid, response);
			return 1;
		}
		case DIALOG_REGISTER:
		{
			if(!response)
			{
				SendClientMessage(playerid, COLOR_REDEX, "You were kicked for not registering.");
				return KickEx(playerid); 
			}
			
			new insert[256]; 
			
			if(strlen(inputtext) > 128 || strlen(inputtext) < 3)
				return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server", "SERVER: You have 60 seconds to register!\n\nYour password needs to be greater than 3 and less than 128 characters.\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Select", "Cancel");
				
			mysql_format(ourConnection, insert, sizeof(insert), "INSERT INTO masters (acc_name, acc_pass, register_date, register_ip) VALUES('%e', sha1('%e'), '%e', '%e')", ReturnName(playerid), inputtext, ReturnDate(), ReturnIP(playerid)); 
			mysql_tquery(ourConnection, insert, "OnPlayerRegister", "i", playerid);
		}
		case DIALOG_LOGIN:
		{
			if (!response)
			{
				SendClientMessage(playerid, COLOR_REDEX, "You were kicked for not logging in."); 
				return KickEx(playerid);
			}
			
			new continueCheck[211]; 
			
			mysql_format(ourConnection, continueCheck, sizeof(continueCheck), "SELECT acc_dbid, forum_name, secret_word, active_ip FROM masters WHERE acc_name = '%e' AND acc_pass = sha1('%e') LIMIT 1", 
				ReturnName(playerid), inputtext);
				
			mysql_tquery(ourConnection, continueCheck, "LoggingIn", "i", playerid);
			return 1;
		}
		case DIALOG_CHARS:
		{
			if (!response)
			{
				SendClientMessage(playerid, COLOR_REDEX, "You were kicked for not selecting a character.");
				return KickEx(playerid); 
			}
			
			if(strfind(characterLister[playerid][listitem], "[", false) != -1)
			{
				for(new i =0 ; i < 4; i++){ SendClientMessage(playerid, -1, " "); }
				SendClientMessage(playerid, COLOR_GREEN, "You selected an empty character slot.");
				
				SendClientMessage(playerid, -1, "This process will guide you through creating your character.");
				SendClientMessage(playerid, -1, "Please begin by typing your characters first and last name. i.e: {145F0B}Luke_Tang");
				SendClientMessage(playerid, -1, "Your characters name must be in Firstname_Lastname format with no numbers or special characters.");
				
				playerMakingCharacter[playerid] = true;
				playerCharacterStep[playerid] = 1; 
				return 1;
			}
			else
			{
				new 
					string[128], thread[128]
				;
				
				characterPickTime[playerid] = 0;
				
				playerMakingCharacter[playerid] = false;
				playerCharacterStep[playerid] = 0; 
				
				format(string, sizeof(string), "You selected the character {145F0B}%s{FFFFFF}.", characterLister[playerid][listitem]);
				SendClientMessage(playerid, -1, string);
				
				SetPlayerName(playerid, characterLister[playerid][listitem]); 
				
				mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM characters WHERE char_name = '%e' LIMIT 1", characterLister[playerid][listitem]);
				mysql_tquery(ourConnection, thread, "Query_SelectCharacter", "i", playerid); 
			}
			return 1;
		}
		case DIALOG_REPORT:
		{
			if (!response)
			{
				return SendServerMessage(playerid, "You cancelled your report.");
			}
			
			new idx;
	
			for (new i = 1; i < sizeof(ReportInfo); i ++)
			{
				if (ReportInfo[i][rReportExists] == false)
				{
					idx = i;
					break; 
				}
			}
			
			OnPlayerReport(playerid, idx, playerReport[playerid]); 
		}
		case DIALOG_FACTION_CONFIG:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: return ShowPlayerDialog(playerid, DIALOG_FACTION_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new name:", "Select", "<<"); 
					case 1: return ShowPlayerDialog(playerid, DIALOG_FACTION_ABBREV, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new abbreviation:", "Select", "<<"); 
					case 2: 
					{
						if(PlayerInfo[playerid][pFactionRank] != 1)
						{
							SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} This configuration is restricted to rank 1 only.");
							return ShowFactionConfig(playerid);
						}
						
						return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new alter rank:", "Select", "<<"); 
					}
					case 3: return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new join rank:", "Select", "<<");
					case 4: return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new chat rank:", "Select", "<<"); 
					case 5: return ShowPlayerDialog(playerid, DIALOG_FACTION_CHATCOLOR, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new chat color: (Example: 0x8D8DFFFF)", "Select", "<<");
					case 6: return ShowPlayerDialog(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions rank ID you want to alter. (1-20)", "Select", "<<");
					case 7:
					{
						if(PlayerInfo[playerid][pFactionRank] != 1)
							return SendErrorMessage(playerid, "The factions spawn may only be changed by rank 1.");
					
						new factionid = PlayerInfo[playerid][pFaction]; 
					
						GetPlayerPos(playerid, FactionInfo[factionid][eFactionSpawn][0], FactionInfo[factionid][eFactionSpawn][1], FactionInfo[factionid][eFactionSpawn][2]);
		
						FactionInfo[factionid][eFactionSpawnInt] = GetPlayerInterior(playerid);
					
						if(GetPlayerInterior(playerid) != 0)
							FactionInfo[factionid][eFactionSpawnWorld] = random(50000)+playerid+5; 
							
						else FactionInfo[factionid][eFactionSpawnWorld] = GetPlayerVirtualWorld(playerid);
						
						SendServerMessage(playerid, "Your factions spawn has been altered."); 
						return ShowFactionConfig(playerid);
					}
					case 8: return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions new tow rank:", "Select", "<<"); 
				}
			}
		}
		case DIALOG_FACTION_NAME:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) > 90 || strlen(inputtext) < 3)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions name must be less than 90 characters.\n\nEnter your factions new name:", "Select", "<<"); 
			
			format(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionName], 90, "%s", inputtext);
			SendServerMessage(playerid, "Your factions name is now: \"%s\".", inputtext);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_ABBREV:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) > 30 || strlen(inputtext) < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions name must be less than 30 characters and more than 1.\n\nEnter your factions new name:", "Select", "<<"); 
				
			format(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAbbrev], 30, "%s", inputtext);
			SendServerMessage(playerid, "Your factions abbreviation is now: \"%s\".", inputtext);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_ALTER_R:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new alter rank:", "Select", "<<"); 

			new rankid = strval(inputtext); 
			
			if(rankid > 20 || rankid < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions alter rank must be between 1-20.\n\nEnter your factions new alter rank:", "Select", "<<"); 
			
			FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank] = rankid;
			SendServerMessage(playerid, "Your factions alter rank is now: %i.", rankid);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_ALTER_J:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new join rank:", "Select", "<<"); 

			new rankid = strval(inputtext); 
			
			if(rankid > 20 || rankid < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions join rank must be between 1-20.\n\nEnter your factions new join rank:", "Select", "<<"); 
			
			FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJoinRank] = rankid;
			SendServerMessage(playerid, "Your factions join rank is now: %i.", rankid);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_ALTER_C:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new chat rank:", "Select", "<<"); 

			new rankid = strval(inputtext); 
			
			if(rankid > 20 || rankid < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions chat rank must be between 1-20.\n\nEnter your factions new chat rank:", "Select", "<<"); 
			
			FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatRank] = rankid;
			SendServerMessage(playerid, "Your factions chat rank is now: %i.", rankid);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_ALTER_T:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new tow rank:", "Select", "<<"); 
				
			new rankid = strval(inputtext); 
			
			if(rankid > 20 || rankid < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions chat rank must be between 1-20.\n\nEnter your factions new tow rank:", "Select", "<<");

			FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank] = rankid;
			SendServerMessage(playerid, "Your factions tow rank is now: %i.", rankid);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_CHATCOLOR:
		{
			if(!response)
				return ShowFactionConfig(playerid);
			
			FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor] = HexToInt(inputtext);
			SendServerMessage(playerid, "Your factions chat color was altered.");
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_FACTION_RANKS:
		{
			if(!response)
				return ShowFactionConfig(playerid);
				
			new rankid = strval(inputtext), str[128];
			
			if(rankid > 20 || rankid < 1)
				return ShowPlayerDialog(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions rank ID you want to alter. (1-20)", "Select", "<<");
				
			playerEditingRank[playerid] = rankid;
			
			format(str, sizeof(str), "You're editing your factions rank ID %i ('%s').\n\n{F81414}To remove this rank, set the name to \"NotSet\". Case sensitive.", rankid, FactionRanks[PlayerInfo[playerid][pFaction]][rankid]);
			return ShowPlayerDialog(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "Select", "<<"); 
		}
		case DIALOG_FACTION_RANKEDIT:
		{
			if(!response)
				return ShowFactionConfig(playerid);
				
			new str[128];
				
			if(strlen(inputtext) > 60 || strlen(inputtext) < 1)
			{
				format(str, sizeof(str), "Your rank should be less than 60 characters.\n\nYou're editing your factions rank ID %i ('%s').\n{F81414}To remove this rank, set the name to \"NotSet\". Case sensitive.", FactionRanks[PlayerInfo[playerid][pFaction]][playerEditingRank[playerid]], playerEditingRank[playerid]);
				return ShowPlayerDialog(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "Select", "<<"); 
			}
			
			SendServerMessage(playerid, "You edited faction rank %i (%s) to: \"%s\". ", playerEditingRank[playerid], FactionRanks[PlayerInfo[playerid][pFaction]][playerEditingRank[playerid]], inputtext);
			format(FactionRanks[PlayerInfo[playerid][pFaction]][playerEditingRank[playerid]], 60, "%s", inputtext);
			
			return ShowFactionConfig(playerid);
		}
		case DIALOG_VEHICLE_WEAPONS:
		{
			if(response)
			{
				new vehicleid = INVALID_VEHICLE_ID, str[128];
				
				if(!IsPlayerInAnyVehicle(playerid))
					vehicleid = GetNearestVehicle(playerid);
					
				else
					vehicleid = GetPlayerVehicleID(playerid);
					
				if(vehicleid == INVALID_VEHICLE_ID)
					return SendErrorMessage(playerid, "You're no longer in or near a vehicle."); 
					
				if(!VehicleInfo[vehicleid][eVehicleWeapons][listitem+1])
					return SendErrorMessage(playerid, "The weapon slot you selected is empty.");
				
				GivePlayerGun(playerid, VehicleInfo[vehicleid][eVehicleWeapons][listitem+1], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1]); 
				
				format(str, sizeof(str), "* %s takes a %s from the %s.", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][listitem+1]), 
					ReturnVehicleName(vehicleid)); 
					
				SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
				SendClientMessage(playerid, COLOR_EMOTE, str);
				
				VehicleInfo[vehicleid][eVehicleWeapons][listitem+1] = 0; 
				VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1] = 0; 
				
				SaveVehicle(vehicleid); SaveCharacter(playerid);
				return 1;
			}
		}
		case DIALOG_HOUSE_WEAPONS:
		{
			if(response)
			{
				new
					id = IsPlayerInProperty(playerid),
					str[128]
				;
				
				if(!PropertyInfo[id][ePropertyWeapons][listitem+1])
					return SendErrorMessage(playerid, "The weapon slot you selected is empty."); 
					
				GivePlayerGun(playerid, PropertyInfo[id][ePropertyWeapons][listitem+1], PropertyInfo[id][ePropertyWeaponsAmmo][listitem+1]);
				
				format(str, sizeof(str), "* %s takes a %s from the house.", ReturnName(playerid, 0), ReturnWeaponName(PropertyInfo[id][ePropertyWeapons][listitem+1])); 
				SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
				SendClientMessage(playerid, COLOR_EMOTE, str); 
				
				PropertyInfo[id][ePropertyWeapons][listitem+1] = 0; 
				PropertyInfo[id][ePropertyWeaponsAmmo][listitem+1] = 0; 
			
				SaveCharacter(playerid); SaveProperty(id);
				return 1;
			}
		}
		case DIALOG_XMR_CATEGORIES:
		{
			if(response)
			{
				new 
					liststr[500], 
					counter = 0
				;
					
				CatXMRHolder[playerid] = listitem+1;
				
				for(new i = 1; i < MAX_XMR_CATEGORY_STATIONS; i++)
				{
					if(CatXMRHolder[playerid] == XMRStationInfo[i][eXMRCategory])
					{
						format(liststr, sizeof(liststr), "%sID:%d - %s\n", liststr, XMRStationInfo[i][eXMRStationID], XMRStationInfo[i][eXMRStationName]);
					
						SubXMRHolderArr[playerid][counter] = i; 
						counter ++; 	
					}
				}
				
				strcat(liststr, "{FFE104}OFF - Click to turn off.\n"); 
				ShowPlayerDialog(playerid, DIALOG_XMR_STATIONS, DIALOG_STYLE_LIST, "Stations:", liststr, "Select", "<<"); 		
				return 1;
			}
		}
		case DIALOG_XMR_STATIONS:
		{
			if(response)
			{
				new 
					vehicleid = INVALID_VEHICLE_ID;
					
				if(IsPlayerInAnyVehicle(playerid))
					vehicleid = GetPlayerVehicleID(playerid);
			
				if(!strcmp(inputtext, "OFF - Click to turn off."))
				{
					PlayXMRStation(playerid, vehicleid, IsPlayerInProperty(playerid), true); 
					return 1;
				}
			
				SubXMRHolder[playerid] = SubXMRHolderArr[playerid][listitem]; 
					
				PlayXMRStation(playerid, vehicleid, IsPlayerInProperty(playerid)); 
			}
			return 1;
		}
		case DIALOG_POLICE_SKINS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SetPlayerSkin(playerid, 280);
					case 1: SetPlayerSkin(playerid, 300);
					case 2: SetPlayerSkin(playerid, 281);
					case 3: SetPlayerSkin(playerid, 301);
					case 4: SetPlayerSkin(playerid, 306);
					case 5: SetPlayerSkin(playerid, 307);
					case 6: SetPlayerSkin(playerid, 265);
					case 7: SetPlayerSkin(playerid, 267);
					case 8: SetPlayerSkin(playerid, 266);
					case 9: SetPlayerSkin(playerid, 284);
					case 10: SetPlayerSkin(playerid, 61);
					case 11: SetPlayerSkin(playerid, 93);
				}
			}
			return 1;
		}
		case DIALOG_BUY_LIST:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pHasRadio])
						{
							SendClientMessage(playerid, COLOR_ACTION, "You already own a radio.");
							ShowBuylist(playerid);
							return 1;
						}
					
						if(1000 > PlayerInfo[playerid][pMoney])
						{
							SendClientMessage(playerid, COLOR_ACTION, "You can't afford a radio.");
							ShowBuylist(playerid);
							return 1; 
						}
					
						SendClientMessage(playerid, COLOR_ACTION, "You bought a radio for $1,000.");
						GiveMoney(playerid, -500); 
						
						PlayerInfo[playerid][pHasRadio] = true;
						ShowBuylist(playerid);
					}
					case 1:
					{
						if(500 > PlayerInfo[playerid][pMoney])
						{
							SendClientMessage(playerid, COLOR_ACTION, "You can't afford a gasoline can.");
							ShowBuylist(playerid);
							return 1; 
						}
						
						if(PlayerInfo[playerid][pGascan] >= 5)
						{
							SendClientMessage(playerid, COLOR_ACTION, "You may only hold up to 5 gasoline cans.");
							ShowBuylist(playerid);
							return 1;
						}
						
						SendClientMessage(playerid, COLOR_ACTION, "You bought a gasoline can for $500.");
						GiveMoney(playerid, -500); 
						
						PlayerInfo[playerid][pGascan]++; 
						ShowBuylist(playerid);
					}
					case 2:
					{
						if(2000 > PlayerInfo[playerid][pMoney])
						{
							SendClientMessage(playerid, COLOR_ACTION, "You can't afford a mask.");
							ShowBuylist(playerid);
							return 1; 
						}
						
						if(PlayerInfo[playerid][pHasMask])
						{
							SendClientMessage(playerid, COLOR_ACTION, "You already own a mask.");
							ShowBuylist(playerid);
							return 1; 
						}
						
						SendClientMessage(playerid, COLOR_ACTION, "You bought a Mask for $2,000.");
						GiveMoney(playerid, -2000);
						
						PlayerInfo[playerid][pHasMask] = true;
						ShowBuylist(playerid);
					}
				}
			}
			return 1;
		}
		case DIALOG_DEALERSHIP:
		{
			if(response)
			{
				new larstr[600],
					counter = 0
				; 
				
				CatDealershipHolder[playerid] = listitem; 
				
				for(new i = 0; i < sizeof(g_aDealershipData); i++)
				{
					if(listitem == g_aDealershipData[i][eDealershipCategory])
					{
						format(larstr, sizeof(larstr), "%s%s\t\t\t$%s\n", larstr, g_aDealershipData[i][eDealershipModel], MoneyFormat(g_aDealershipData[i][eDealershipPrice]));
						
						SubDealershipHolderArr[playerid][counter] = i; 
						counter++; 
					}
				}
				
				ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_SELECT, DIALOG_STYLE_LIST, "Available Models:", larstr, "Select", "<<"); 
			}
			return 1;
		}
		case DIALOG_DEALERSHIP_SELECT:
		{
			if(!response)
			{
				new catstr[190];
				
				for(new i = 0; i < sizeof(g_aDealershipCategory); i++)
				{
					format(catstr, sizeof(catstr), "%s%s\n", catstr, g_aDealershipCategory[i]); 
				}
				
				return ShowPlayerDialog(playerid, DIALOG_DEALERSHIP, DIALOG_STYLE_LIST, "Categories:", catstr, "Select", "Cancel");			
			}
	
			SubDealershipHolder[playerid] = SubDealershipHolderArr[playerid][listitem]; 
			
			new
				i,
				d,
				str[128],
				caption[60]
			; 
				
			i = SubDealershipHolder[playerid];
			d = PlayerInfo[playerid][pAtDealership]; 
			
			if(g_aDealershipData[i][eDealershipPrice] > PlayerInfo[playerid][pMoney])
				return SendServerMessage(playerid, "You need $%s to buy this. (Total: $%s)", MoneyFormat(g_aDealershipData[i][eDealershipPrice]), MoneyFormat(PlayerInfo[playerid][pMoney])); 
				
			DealershipTotalCost[playerid] = g_aDealershipData[i][eDealershipPrice];
			
			format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[i][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
			
			strcat(str, "Alarm\n");
			strcat(str, "Lock\n");
			strcat(str, "Immobiliser\n");
			strcat(str, "Colors\n");
			strcat(str, "No XM Installed\n");
			strcat(str, "{FFFF00}Purchase Vehicle\n"); 
			
			TogglePlayerControllable(playerid, 0); 
			
			DealershipPlayerCar[playerid] = 
				CreateVehicle(g_aDealershipData[i][eDealershipModelID], BusinessInfo[d][eBusinessInterior][0], BusinessInfo[d][eBusinessInterior][1], BusinessInfo[d][eBusinessInterior][2], 90.0, 0, 0, -1);
				
			PutPlayerInVehicle(playerid, DealershipPlayerCar[playerid], 0); 
			
			printf("[DEBUG]: Player %s (ID : %i) was spawned in a Dealership vehicle. (Vehicle ID: %d)", ReturnName(playerid), playerid, DealershipPlayerCar[playerid]); 
			ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND, DIALOG_STYLE_LIST, caption, str, "Append", "<<");
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND:
		{
			new
				caption[60],
				str[400]
			; 
			
			format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
			
			if(response)
			{
				switch(listitem)
				{
					case 0: //Alarms;
					{
						if(DealershipAlarmLevel[playerid] == 1)
							strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 1 - $2,000\n");
							
						else strcat(str, "Alarm Level 1 - $2,000\n"); 
						
						if(DealershipAlarmLevel[playerid] == 2)
							strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 2 - $4,000\n");
							
						else strcat(str, "Alarm Level 2 - $4,000\n"); 
						
						if(DealershipAlarmLevel[playerid] == 3)
							strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 3 - $6,000\n");
							
						else strcat(str, "Alarm Level 3 - $6,000\n"); 
						
						if(DealershipAlarmLevel[playerid] == 4)
							strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 4 - $10,000\n");
							
						else strcat(str, "Alarm Level 4 - $10,000\n"); 
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_ALARM, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 1: //Locks;
					{
						if(DealershipLockLevel[playerid] == 1)
							strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 1 - $1,000\n");
							
						else strcat(str, "Lock Level 1 - $1,000\n");
						
						if(DealershipLockLevel[playerid] == 2)
							strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 2 - $3,000\n");
							
						else strcat(str, "Lock Level 2 - $3,000\n");
						
						if(DealershipLockLevel[playerid] == 3)
							strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 3 - $5,000\n");
							
						else strcat(str, "Lock Level 3 - $5,000\n");
						
						if(DealershipLockLevel[playerid] == 4)
							strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 4 - $ 8,000\n");
							
						else strcat(str, "Lock Level 4 - $8,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_LOCK, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 2: //Immob;
					{
						if(DealershipImmobLevel[playerid] == 1)
							strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 1 - $0\n");
						
						else strcat(str, "Immobiliser Level 1 - $0\n");
						
						if(DealershipImmobLevel[playerid] == 2)
							strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 2 - $3,000\n");
						
						else strcat(str, "Immobiliser Level 2 - $3,000\n");
						
						if(DealershipImmobLevel[playerid] == 3)
							strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 3 - $5,000\n");
						
						else strcat(str, "Immobiliser Level 3 - $5,000\n");
						
						if(DealershipImmobLevel[playerid] == 4)
							strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 4 - $7,000\n");
						
						else strcat(str, "Immobiliser Level 4 - $7,000\n");
						
						if(DealershipImmobLevel[playerid] == 5)
							strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 5 - $11,000\n");
						
						else strcat(str, "Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 3: //Colors
					{
						new 
							dstr[128]
						;
					
						format(dstr, sizeof(dstr), "{FFFFFF}Color 1 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]);
						strcat(str, dstr);
						
						format(dstr, sizeof(dstr), "{FFFFFF}Color 2 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]);
						strcat(str, dstr);
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLORMENU, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 4: //XM-Radio
					{
						if(!DealershipXMR[playerid])
						{
							DealershipXMR[playerid] = 1;
							DealershipTotalCost[playerid]+= 1500;
						}	
						else
						{
							DealershipXMR[playerid] = 0;
							DealershipTotalCost[playerid]-= 1500; 
						}
						
						return ShowDealerAppend(playerid);
					}
					case 5: //Purchase
					{
						new
							dstr[128],
							Float:vehMass,
							Float:vehVelo,
							vehDrive[60],
							vehFuel[60]
						;
						
						vehMass = GetVehicleModelInfoAsFloat(GetVehicleModel(DealershipPlayerCar[playerid]), "fMass"); 
						vehVelo = GetVehicleModelInfoAsFloat(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_fMaxVelocity"); 
						
						
						if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nDriveType") == 'F')
							vehDrive = "Front-Wheel Drive";
							
						else if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nDriveType") == 'R')
							vehDrive = "Rear-Wheel Drive";
						
						else if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nDriveType") == '4')
							vehDrive = "4-Wheel Drive";
						
						
						if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nEngineType") == 'P')
							vehFuel = "Petrol";
							
						else if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nEngineType") == 'D')
							vehFuel = "Diesel";
							
						else if(GetVehicleModelInfoAsInt(GetVehicleModel(DealershipPlayerCar[playerid]), "TransmissionData_nEngineType") == 'E')
							vehFuel = "Electric";
						
						format(dstr, sizeof(dstr), "{FFFF00}Value:\t\t{FFFFFF}$%s \n", MoneyFormat(g_aDealershipData[SubDealershipHolder[playerid]][eDealershipPrice]));
						strcat(str, dstr);
						
						format(dstr, sizeof(dstr), "{FFFF00}Max Speed:\t\t{FFFFFF}%.1f \n", GetVehicleTopSpeed(DealershipPlayerCar[playerid])); 
						strcat(str, dstr); 
						
						format(dstr, sizeof(dstr), "{FFFF00}Max Velocity:\t\t{FFFFFF}%.2f \n", vehVelo);
						strcat(str, dstr); 
						
						format(dstr, sizeof(dstr), "{FFFF00}Mass:\t\t{FFFFFF}%.2f \n\n", vehMass);
						strcat(str, dstr);

						format(dstr, sizeof(dstr), "{FFFF00}Engine Drive:\t\t{FFFFFF}%s \n", vehDrive);
						strcat(str, dstr); 
						
						format(dstr, sizeof(dstr), "{FFFF00}Engine Fuel:\t\t{FFFFFF}%s \n\n", vehFuel); 
						strcat(str, dstr);
							
						switch(DealershipAlarmLevel[playerid])
						{
							case 1: strcat(str, "{FFFF00}Alarm:\t\t{FFFFFF}Level 1 $2,000\n"); 
							case 2: strcat(str, "{FFFF00}Alarm:\t\t{FFFFFF}Level 2 $4,000\n");
							case 3: strcat(str, "{FFFF00}Alarm:\t\t{FFFFFF}Level 3 $6,000\n"); 
							case 4: strcat(str, "{FFFF00}Alarm:\t\t{FFFFFF}Level 4 $10,000\n"); 
						}
						
						switch(DealershipLockLevel[playerid])
						{
							case 1: strcat(str, "{FFFF00}Lock:\t\t{FFFFFF}Level 1 $1,000\n");
							case 2: strcat(str, "{FFFF00}Lock:\t\t{FFFFFF}Level 2 $3,000\n");
							case 3: strcat(str, "{FFFF00}Lock:\t\t{FFFFFF}Level 3 $5,000\n");
							case 4: strcat(str, "{FFFF00}Lock:\t\t{FFFFFF}Level 4 $8,000\n");
						}
						
						switch(DealershipImmobLevel[playerid])
						{
							case 2: strcat(str, "{FFFF00}Immobiliser:\t\t{FFFFFF}Level 2 $3,000\n");
							case 3: strcat(str, "{FFFF00}Immobiliser:\t\t{FFFFFF}Level 3 $5,000\n");
							case 4: strcat(str, "{FFFF00}Immobiliser:\t\t{FFFFFF}Level 4 $7,000\n");
							case 5: strcat(str, "{FFFF00}Immobiliser:\t\t{FFFFFF}Level 5 $11,000\n");
						}
						
						if(DealershipXMR[playerid])
							strcat(str, "{FFFF00}XM-Radio:\t\t{FFFFFF}$1,500\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_PURCHASE, DIALOG_STYLE_MSGBOX, caption, str, "Edit", "Checkout"); 
						return 1;
					}
				}
			}
			else ConfirmDialog(playerid, "Confirmation", "Are you sure you want to exit?", "OnPlayerExitDealership"); 
			return 1;
		}
		case DIALOG_DEALERSHIP_PURCHASE:
		{		
			if(response)
			{
				return ShowDealerAppend(playerid);
			}
			else
			{
				if(DealershipTotalCost[playerid] > PlayerInfo[playerid][pMoney])
				{
					SendServerMessage(playerid, "You can't afford the total price. (Price: $%s, Total:$%s)", MoneyFormat(DealershipTotalCost[playerid]), MoneyFormat(PlayerInfo[playerid][pMoney]));
					
					DestroyVehicle(DealershipPlayerCar[playerid]);
					TogglePlayerControllable(playerid, 1);
					
					return ResetDealershipVars(playerid);
				}
				
				new
					idx, 
					plates[32],
					randset[3],
					insert[256],
					Float:x,
					Float:y,
					Float:z,
					Float:a
				;
				
				for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
				{
					if(!PlayerInfo[playerid][pOwnedVehicles][i])
					{
						idx = i;
						break;
					}
				}
				
				GetVehiclePos(DealershipPlayerCar[playerid], x, y, z); 
				GetVehicleZAngle(DealershipPlayerCar[playerid], a); 
				
				randset[0] = random(sizeof(possibleVehiclePlates)); 
				randset[1] = random(sizeof(possibleVehiclePlates)); 
				randset[2] = random(sizeof(possibleVehiclePlates)); 
				
				format(plates, 32, "%d%s%s%s%d%d%d", random(9), possibleVehiclePlates[randset[0]], possibleVehiclePlates[randset[1]], possibleVehiclePlates[randset[2]], random(9), random(9)); 
				GiveMoney(playerid, -DealershipTotalCost[playerid]);
				
				SendClientMessage(playerid, 0xB9E35EFF, "PROCESSING: Your vehicles being setup.");
				ShowPlayerPlates(playerid, plates); 
				
				mysql_format(ourConnection, insert, sizeof(insert), "INSERT INTO vehicles (VehicleOwnerDBID, VehicleModel, VehicleParkPosX, VehicleParkPosY, VehicleParkPosZ, VehicleParkPosA) VALUES(%i, %i, %f, %f, %f, %f)",
					PlayerInfo[playerid][pDBID], g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModelID], x, y, z, a); 
					
				mysql_tquery(ourConnection, insert, "OnPlayerVehiclePurchase", "iisffff", playerid, idx, plates, x, y, z, a);
				
				PlayerPurchasingVehicle[playerid] = true; 
				TogglePlayerControllable(playerid, 1);
			}
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_ALARM:
		{
			new
				str[400],
				caption[60]
			;
			
			if(response)
			{
				 switch(listitem)
				 {
					case 0:
					{
						if(DealershipAlarmLevel[playerid] != 1)
							DealershipTotalCost[playerid]+= 2000; 
							
						if(DealershipAlarmLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 4000; 
							
						else if(DealershipAlarmLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 6000; 
							
						else if(DealershipAlarmLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 10000; 
							
						DealershipAlarmLevel[playerid] = 1; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 1 - $2,000\n");
						strcat(str, "Alarm Level 2 - $4,000\n");
						strcat(str, "Alarm Level 3 - $6,000\n"); 
						strcat(str, "Alarm Level 4 - $10,000\n"); 

						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_ALARM, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 1:
					{
						if(DealershipAlarmLevel[playerid] != 2)
							DealershipTotalCost[playerid]+= 4000; 
							
						if(DealershipAlarmLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 2000;
							
						else if(DealershipAlarmLevel[playerid] == 3)
							DealershipTotalCost[playerid] -= 6000;
							
						else if(DealershipAlarmLevel[playerid] == 4)
							DealershipTotalCost[playerid] -= 10000;
							
						DealershipAlarmLevel[playerid] = 2; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Alarm Level 1 - $2,000\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 2 - $4,000\n");
						strcat(str, "Alarm Level 3 - $6,000\n"); 
						strcat(str, "Alarm Level 4 - $10,000\n"); 

						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_ALARM, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 2:
					{
						if(DealershipAlarmLevel[playerid] != 3)
							DealershipTotalCost[playerid]+= 6000;
							
						if(DealershipAlarmLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 2000;
							
						else if(DealershipAlarmLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 4000;
							
						else if(DealershipTotalCost[playerid] == 4)
							DealershipTotalCost[playerid]-= 10000; 
							
						DealershipAlarmLevel[playerid] = 3; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Alarm Level 1 - $2,000\n");
						strcat(str, "Alarm Level 2 - $4,000\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 3 - $6,000\n"); 
						strcat(str, "Alarm Level 4 - $10,000\n"); 

						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_ALARM, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 3:
					{
						if(DealershipAlarmLevel[playerid] != 4)
							DealershipTotalCost[playerid]+= 10000;
							
						if(DealershipAlarmLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 2000;
							
						else if(DealershipAlarmLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 4000;
							
						else if(DealershipAlarmLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 6000;
							
						DealershipAlarmLevel[playerid] = 4;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Alarm Level 1 - $2,000\n");
						strcat(str, "Alarm Level 2 - $4,000\n");
						strcat(str, "Alarm Level 3 - $6,000\n"); 
						strcat(str, "{FFFF00}>>{FFFFFF}Alarm Level 4 - $10,000\n"); 

						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_ALARM, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
				 }
			}
			else return ShowDealerAppend(playerid);
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_LOCK:
		{
			new
				str[400],
				caption[60]
			;
			
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(DealershipLockLevel[playerid] != 1)
							DealershipTotalCost[playerid]+= 1000; 
							
						if(DealershipLockLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipLockLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipLockLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 8000; 
							
						DealershipLockLevel[playerid] = 1;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 1 - $1,000\n"); 
						strcat(str, "Lock Level 2 - $3,000\n"); 
						strcat(str, "Lock Level 3 - $5,000\n"); 
						strcat(str, "Lock Level 4 - $8,000\n"); 
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_LOCK, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 1:
					{
						if(DealershipLockLevel[playerid] != 2)
							DealershipTotalCost[playerid]+= 3000;
							
						if(DealershipLockLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 1000; 
							
						else if(DealershipLockLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipLockLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 8000; 
							
						DealershipLockLevel[playerid] = 2;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Lock Level 1 - $1,000\n"); 
						strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 2 - $3,000\n"); 
						strcat(str, "Lock Level 3 - $5,000\n"); 
						strcat(str, "Lock Level 4 - $8,000\n"); 
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_LOCK, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 2:
					{
						if(DealershipLockLevel[playerid] != 3)
							DealershipTotalCost[playerid]+= 5000;
							
						if(DealershipLockLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 1000; 
							
						else if(DealershipLockLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipLockLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 8000;
							
						DealershipLockLevel[playerid] = 3;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Lock Level 1 - $1,000\n"); 
						strcat(str, "Lock Level 2 - $3,000\n"); 
						strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 3 - $5,000\n"); 
						strcat(str, "Lock Level 4 - $8,000\n"); 
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_LOCK, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 3:
					{
						if(DealershipLockLevel[playerid] != 4)
							DealershipTotalCost[playerid]+= 8000;
							
						if(DealershipLockLevel[playerid] == 1)
							DealershipTotalCost[playerid]-= 1000; 
							
						else if(DealershipLockLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipLockLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						DealershipLockLevel[playerid] = 4; 
							
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
						
						strcat(str, "Lock Level 1 - $1,000\n"); 
						strcat(str, "Lock Level 2 - $3,000\n"); 
						strcat(str, "Lock Level 3 - $5,000\n"); 
						strcat(str, "{FFFF00}>>{FFFFFF}Lock Level 4 - $8,000\n"); 
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_LOCK, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
				}
			}
			else return ShowDealerAppend(playerid);
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_IMMOB:
		{
			new
				str[400],
				caption[60]
			;
			
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(DealershipImmobLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipImmobLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipImmobLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 7000;
							
						else if(DealershipImmobLevel[playerid] == 5)
							DealershipTotalCost[playerid]-= 11000; 
							
						DealershipImmobLevel[playerid] = 1; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid]));  
						
						strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 1 - $0\n");
						strcat(str, "Immobiliser Level 2 - $3,000\n");
						strcat(str, "Immobiliser Level 3 - $5,000\n");
						strcat(str, "Immobiliser Level 4 - $7,000\n");
						strcat(str, "Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 1:
					{
						if(DealershipImmobLevel[playerid] != 2)
							DealershipTotalCost[playerid]+= 3000; 
					
						if(DealershipImmobLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipImmobLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 7000;
							
						else if(DealershipImmobLevel[playerid] == 5)
							DealershipTotalCost[playerid]-= 11000; 
							
						DealershipImmobLevel[playerid] = 2; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid]));  
						
						strcat(str, "Immobiliser Level 1 - $0\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 2 - $3,000\n");
						strcat(str, "Immobiliser Level 3 - $5,000\n");
						strcat(str, "Immobiliser Level 4 - $7,000\n");
						strcat(str, "Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 2:
					{
						if(DealershipImmobLevel[playerid] != 3)
							DealershipTotalCost[playerid]+= 5000; 
					
						if(DealershipImmobLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipImmobLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 7000;
							
						else if(DealershipImmobLevel[playerid] == 5)
							DealershipTotalCost[playerid]-= 11000; 
							
						DealershipImmobLevel[playerid] = 3; 
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid]));  
						
						strcat(str, "Immobiliser Level 1 - $0\n");
						strcat(str, "Immobiliser Level 2 - $3,000\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 3 - $5,000\n");
						strcat(str, "Immobiliser Level 4 - $7,000\n");
						strcat(str, "Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 3:
					{
						if(DealershipImmobLevel[playerid] != 4)
							DealershipTotalCost[playerid]+= 7000;
							
						if(DealershipImmobLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipImmobLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipImmobLevel[playerid] == 5)
							DealershipTotalCost[playerid]-= 11000; 
							
						DealershipImmobLevel[playerid] = 4;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid]));  
						
						strcat(str, "Immobiliser Level 1 - $0\n");
						strcat(str, "Immobiliser Level 2 - $3,000\n");
						strcat(str, "Immobiliser Level 3 - $5,000\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 4 - $7,000\n");
						strcat(str, "Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
					case 4:
					{
						if(DealershipImmobLevel[playerid] != 5)
							DealershipTotalCost[playerid]-= 11000; 
							
						if(DealershipImmobLevel[playerid] == 2)
							DealershipTotalCost[playerid]-= 3000;
							
						else if(DealershipImmobLevel[playerid] == 3)
							DealershipTotalCost[playerid]-= 5000;
							
						else if(DealershipImmobLevel[playerid] == 4)
							DealershipTotalCost[playerid]-= 7000;
							
						DealershipImmobLevel[playerid] = 5;
						
						format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid]));  
						
						strcat(str, "Immobiliser Level 1 - $0\n");
						strcat(str, "Immobiliser Level 2 - $3,000\n");
						strcat(str, "Immobiliser Level 3 - $5,000\n");
						strcat(str, "Immobiliser Level 4 - $7,000\n");
						strcat(str, "{FFFF00}>>{FFFFFF}Immobiliser Level 5 - $11,000\n");
						
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_IMMOB, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
					}
				}
			}
			else return ShowDealerAppend(playerid);
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_COLORMENU:
		{
			new
				str[128],
				caption[60]
			; 
			
			format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
		
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles first color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]); 
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR1, DIALOG_STYLE_INPUT, caption, str, "Select", "<<");  
					}
					case 1:
					{
						format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles second color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]); 
						ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR2, DIALOG_STYLE_INPUT, caption, str, "Select", "<<"); 
					}
				}
			}
			else return ShowDealerAppend(playerid);
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_COLOR1:
		{
			new
				caption[60],
				str[128],
				color1
			;
			
			format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
			
			if(response)
			{
				if(!IsNumeric(inputtext))
				{
					format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles first color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]); 
					return ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR1, DIALOG_STYLE_INPUT, caption, str, "Select", "<<");  
				}
			
				color1 = strval(inputtext);
				
				if(color1 > 255 || color1 < 0)
				{
					format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles first color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]); 
					return ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR1, DIALOG_STYLE_INPUT, caption, str, "Select", "<<");  
				}
				
				ChangeVehicleColor(DealershipPlayerCar[playerid], color1, DealershipCarColors[playerid][1]); 
				
				DealershipCarColors[playerid][0] = color1;
				return ShowDealerAppend(playerid); 
			}
			else
			{
				new 
					dstr[128]
				;
					
				format(dstr, sizeof(dstr), "{FFFFFF}Color 1 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]);
				strcat(str, dstr);
						
				format(dstr, sizeof(dstr), "{FFFFFF}Color 2 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]);
				strcat(str, dstr);
						
				ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLORMENU, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
			}
			return 1;
		}
		case DIALOG_DEALERSHIP_APPEND_COLOR2:
		{
			new
				caption[60],
				str[128],
				color2
			;
			
			format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
			
			if(response)
			{
				if(!IsNumeric(inputtext))
				{
					format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles second color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]); 
					return ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR1, DIALOG_STYLE_INPUT, caption, str, "Select", "<<");  
				}
			
				color2 = strval(inputtext);
				
				if(color2 > 255 || color2 < 0)
				{
					format(str, sizeof(str), "{FFFFFF}You're selecting your vehicles second color. ({%06x}%d{FFFFFF})\n Please select a Color ID. (0-255)", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]); 
					return ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLOR1, DIALOG_STYLE_INPUT, caption, str, "Select", "<<");  
				}
				
				ChangeVehicleColor(DealershipPlayerCar[playerid], DealershipCarColors[playerid][0], color2); 
				
				DealershipCarColors[playerid][1] = color2;
				return ShowDealerAppend(playerid); 
			}
			else
			{
				new 
					dstr[128]
				;
					
				format(dstr, sizeof(dstr), "{FFFFFF}Color 1 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][0]] >>> 8, DealershipCarColors[playerid][0]);
				strcat(str, dstr);
						
				format(dstr, sizeof(dstr), "{FFFFFF}Color 2 ({%06x}%d{FFFFFF})\n", VehicleColoursTableRGBA[DealershipCarColors[playerid][1]] >>> 8, DealershipCarColors[playerid][1]);
				strcat(str, dstr);
						
				ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND_COLORMENU, DIALOG_STYLE_LIST, caption, str, "Select", "<<"); 
			}
			return 1;
		}
		case DIALOG_SELECT_HOUSE:
		{
			if(response)
			{
				new
					id
				;
				
				id = playerHouseSelect[playerid][listitem];
			
				PlayerInfo[playerid][pSpawnPoint] = SPAWN_POINT_PROPERTY;
				PlayerInfo[playerid][pSpawnPointHouse] = id;
				
				SendServerMessage(playerid, "You selected Property %i and will now spawn there.", listitem); 
			}
			return 1;
		}
		case DIALOG_MDC:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: return ShowPlayerDialog(playerid, DIALOG_MDC_NAME, DIALOG_STYLE_INPUT, "Name Search - MDC", "Enter the persons full name to search below:", "Search", "<<"); 
					case 1: return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "Plate Search - MDC", "Enter the vehicles full or partial plate to search below:", "Search", "<<"); 
				}
				return 1;
			}
		}
		case DIALOG_MDC_NAME:
		{
			if(response)
			{
				if(strlen(inputtext) < 3 || strlen(inputtext) > 32)
					return ShowPlayerDialog(playerid, DIALOG_MDC_NAME, DIALOG_STYLE_INPUT, "Name Search - MDC", "Enter the persons full name to search below:", "Search", "<<"); 
					
				for(new i = 0; i < strlen(inputtext); i++)
				{
					if(inputtext[i] == '_')
					{
						return ShowPlayerDialog(playerid, DIALOG_MDC_NAME, DIALOG_STYLE_INPUT, "Name Search - MDC", "Enter the persons full name to search below:", "Search", "<<"); 
					}
					else
					{
						if(inputtext[i] == ' ')
						{
							inputtext[i] = '_';
						}
					}
				}
					 
				PlayerMDCCount[playerid] = 0; 
				PlayerMDCTimer[playerid] = SetTimerEx("OnMDCSearch", 1000, true, "ii", playerid, 1);
				
				format(PlayerMDCName[playerid], 32, "%s", inputtext); 
				ShowPlayerDialog(playerid, DIALOG_MDC_NAME_QUEUE, DIALOG_STYLE_MSGBOX, "Name Search - MDC", "Searching.", "Cancel", ""); 
				return 1;
			}
			else return ShowPlayerMDC(playerid);
		}
		case DIALOG_MDC_PLATE:
		{
			if(response)
			{
				if(strlen(inputtext) > 6 || strlen(inputtext) < 3)
					return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "Plate Search - MDC", "Enter the vehicles full or partial plate to search below:\n\nYou need at least 3 characters for a plate search.", "Search", "<<"); 
					
				PlayerMDCCount[playerid] = 0;
				PlayerMDCTimer[playerid] = SetTimerEx("OnMDCSearch", 1000, true, "ii", playerid, 2);
				
				format(PlayerMDCName[playerid], 32, "%s", inputtext); 
				ShowPlayerDialog(playerid, DIALOG_MDC_PLATE_QUEUE, DIALOG_STYLE_MSGBOX, "Plate Search - MDC", "Searching.", "Cancel", ""); 
			}
			else return ShowPlayerMDC(playerid);
		}
		case DIALOG_MDC_NAME_QUEUE:
		{
			if(response)
			{
				new
					str[120];
					
				format(str, sizeof(str), "{FFFFFF}Name search cancelled for: \"%s\"", PlayerMDCName[playerid]);
				ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Name Search - MDC", str, "Okay", ""); 
				
				KillTimer(PlayerMDCTimer[playerid]);
				PlayerMDCCount[playerid] = 0; 
				return 1;
			}
		}
		case DIALOG_MDC_PLATE_QUEUE:
		{
			if(response)
			{
				new
					str[120];
					
				format(str, sizeof(str), "{FFFFFF}Plate search cancelled for: \"%s\"", PlayerMDCName[playerid]);
				ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Plate Search - MDC", str, "Okay", ""); 
				
				KillTimer(PlayerMDCTimer[playerid]);
				
				for(new i = 0; i < 5; i++) PlayerPlateSaver[playerid][i] = "";
				PlayerMDCName[playerid] = "";
				PlayerMDCCount[playerid] = 0; 
			}
		}
		case DIALOG_MDC_PLATE_LIST:
		{
			if(response)
			{
				new query[220];
			
				mysql_format(ourConnection, query, sizeof(query), "SELECT VehicleOwnerDBID, VehicleModel, VehicleImpounded FROM vehicles WHERE VehiclePlates = '%e'", PlayerPlateSaver[playerid][listitem]);
				mysql_tquery(ourConnection, query, "OnPlateSelect", "ii", playerid, listitem); 
				return 1; 
			}
		}
		case DIALOG_MDC_FINISH_QUEUE:
		{
			if(response)
			{
				ShowPlayerMDC(playerid);
				return 1;
			}
		}
		case DIALOG_SECRETWORD_CREATE:
		{
			if(response)
			{
				new 
					insert[128];
					
				mysql_format(ourConnection, insert, sizeof(insert), "UPDATE masters SET secret_word = sha1('%e') WHERE acc_dbid = %i", inputtext, e_pAccountData[playerid][mDBID]); 
				mysql_tquery(ourConnection, insert); 
				
				mysql_format(ourConnection, insert, sizeof(insert), "SELECT acc_dbid FROM masters WHERE acc_name = '%e'", ReturnName(playerid));
				mysql_tquery(ourConnection, insert, "LogPlayerIn", "i", playerid);
				return 1;
			}
			else
			{
				return KickEx(playerid);
			}
		}
		case DIALOG_SECRETWORD_INPUT:
		{
			if(response)
			{
				new 
					query[128];
				
				mysql_format(ourConnection, query, sizeof(query), "SELECT secret_word FROM masters WHERE acc_name = '%e' AND secret_word = sha1('%e')", ReturnName(playerid), inputtext);
				mysql_tquery(ourConnection, query, "OnSecretWordInput", "i", playerid);
				return 1;
			}
			else
			{
				return KickEx(playerid);
			}
		}
	}
	return 0;
}

function:OnMDCSearch(playerid, type)
{
	new
		caption[32],
		dialog_id,
		str[60]
	;
		
	if(type == 1)
	{
		caption = "Name Search - MDC"; 
		dialog_id = DIALOG_MDC_NAME_QUEUE;
	}	
	else
	{
		caption = "Plate Search - MDC"; 
		dialog_id = DIALOG_MDC_PLATE_QUEUE; 
	}

	PlayerMDCCount[playerid]++; 
	
	switch(PlayerMDCCount[playerid])
	{
		case 1: str = "Searching.."; 
		case 2: str = "Searching...";
		case 3: str = "Searching...."; 
		case 4: str = "Search completed. Please wait."; 
		case 5:
		{
			KillTimer(PlayerMDCTimer[playerid]);
			PlayerMDCCount[playerid] = 0;
			
			OnMDCRecordSearch(playerid, type); 
			return 1; 
		}
	}
	
	ShowPlayerDialog(playerid, dialog_id, DIALOG_STYLE_MSGBOX, caption, str, "Cancel", ""); 
	return 1;
}

function:OnMDCRecordSearch(playerid, type)
{
	new
		query[255];

	switch(type)
	{
		case 1: //Name search;
		{
			if(!ReturnDBIDFromName(PlayerMDCName[playerid]))
			{
				return ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Name Search - MDC", "{FFFFFF}The name you inputted was not found.", "<<", ""); 
			}
			
			mysql_format(ourConnection, query, sizeof(query), "SELECT pPhone, pAge, pOrigin, pActiveListings, pPrisonTimes, pJailTimes FROM characters WHERE char_dbid = %i", ReturnDBIDFromName(PlayerMDCName[playerid]));
			mysql_tquery(ourConnection, query, "OnMDCNameFound", "i", playerid);
		}
		case 2: //Plate search;
		{
			mysql_format(ourConnection, query, sizeof(query), "SELECT VehiclePlates FROM vehicles WHERE VehiclePlates LIKE '%%%e%%' LIMIT 5", PlayerMDCName[playerid]); 
			mysql_tquery(ourConnection, query, "OnMDCPlate", "i", playerid); 
		
			return 1;
		}
	}
	
	return 1; 
}

function:OnMDCPlate(playerid)
{	
	if(!cache_num_rows())
	{
		for(new i = 0; i < 5; i++) PlayerPlateSaver[playerid][i] = "";
		PlayerMDCName[playerid] = "";
		
		return ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Plate Search - MDC", "{FFFFFF}The plate you inputted was not found.", "<<", ""); 
	}
	
	new rows, fields, str[128];
	cache_get_data(rows, fields, ourConnection);
	
	for(new i = 0; i < rows; i++)
	{
		cache_get_field_content(i, "VehiclePlates", PlayerPlateSaver[playerid][i], ourConnection, 20); 
	}
	
	for(new i = 0; i < 5; i++)
	{
		if(!isnull(PlayerPlateSaver[playerid][i]))
		{
			format(str, sizeof(str), "%s%s\n", str, PlayerPlateSaver[playerid][i]);
		}
	}
	
	ShowPlayerDialog(playerid, DIALOG_MDC_PLATE_LIST, DIALOG_STYLE_LIST, "Plate Search - MDC", str, "Select", "<<"); 
	return 1;
}

function:OnPlateSelect(playerid, listitem)
{
	new rows, fields;
	cache_get_data(rows, fields, ourConnection); 
	
	new
		model, 
		owner,
		impounded,
		
		primary_str[200],
		sub_str[128]
	;
	
	model = cache_get_field_content_int(0, "VehicleModel", model);
	owner = cache_get_field_content_int(0, "VehicleOwnerDBID", owner);
	impounded = bool:cache_get_field_content_int(0, "VehicleImpounded", impounded);
	
	format(sub_str, sizeof(sub_str), "Plate: %s\n", PlayerPlateSaver[playerid][listitem]);
	strcat(primary_str, sub_str);
	
	format(sub_str, sizeof(sub_str), "Registered owner: %s\n", ReturnDBIDName(owner));
	strcat(primary_str, sub_str); 
	
	if(impounded)
		strcat(primary_str, "Impounded: Yes\n"); 
		
	else strcat(primary_str, "Impounded: No\n");
	
	for(new i = 0; i < 5; i++) PlayerPlateSaver[playerid][i] = "";
	PlayerMDCName[playerid] = "";
	
	ShowPlayerDialog(playerid, DIALOG_MDC_FINISH_QUEUE, DIALOG_STYLE_MSGBOX, "Mobile Database Computer", primary_str, "<<", "");
	return 1;
}

function:OnMDCNameFound(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
	
	new
		primary_str[300],
		sub_str[128],
		
		age_str[20],
		origin_str[60],
		phone_number,
		
		active_listing,
		jail_times,
		prison_times,
		
		query[128]
	; 
	
	phone_number = cache_get_field_content_int(0, "pPhone", phone_number);
	cache_get_field_content(0, "pAge", age_str); 
	cache_get_field_content(0, "pOrigin", origin_str); 
	
	active_listing = cache_get_field_content_int(0, "pActiveListings");
	jail_times = cache_get_field_content_int(0, "pJailTimes");
	prison_times = cache_get_field_content_int(0, "pPrisonTimes");
	
	format(sub_str, sizeof(sub_str), "Full Name: %s\n", PlayerMDCName[playerid]);
	strcat(primary_str, sub_str);
	
	format(sub_str, sizeof(sub_str), "Phone Number: %i\n\n", phone_number);
	strcat(primary_str, sub_str);
	
	format(sub_str, sizeof(sub_str), "Date of Birth: %s\n", age_str);
	strcat(primary_str, sub_str);
	
	format(sub_str, sizeof(sub_str), "Place of Birth: %s\n\n", origin_str);
	strcat(primary_str, sub_str);
	
	strcat(primary_str, "CRIMINAL RECORD\n");
	
	format(sub_str, sizeof(sub_str), "Jail Sentences: %i\n", jail_times);
	strcat(primary_str, sub_str);
	
	format(sub_str, sizeof(sub_str), "Prison Sentences: %i\n\n", prison_times);
	strcat(primary_str, sub_str);
	
	if(!active_listing)
		strcat(primary_str, "Previous arrest reason(s): (NOT WANTED)\n\n");
		
	else strcat(primary_str, "OUTSTANDING CHARGES:\n\n");
	
	mysql_format(ourConnection, query, sizeof(query), "SELECT charge_reason FROM criminal_record WHERE player_name = '%e' ORDER BY idx DESC", PlayerMDCName[playerid]);
	new Cache:cache = mysql_query(ourConnection, query); 
	new record[128]; 
	
	if(!cache_num_rows())
		strcat(primary_str, "No previous charges.\n"); 
		
	else
	{
		for(new i = 0; i < cache_num_rows(); i++)
		{
			cache_get_field_content(i, "charge_reason", record);
			
			format(sub_str, sizeof(sub_str), "* %s\n", record);
			strcat(primary_str, sub_str);
		}
	}
	
	cache_delete(cache);
	
	ShowPlayerDialog(playerid, DIALOG_MDC_FINISH_QUEUE, DIALOG_STYLE_MSGBOX, "Mobile Database Computer", primary_str, "<<", ""); 
	return 1;
}

function:OnPlayerRegister(playerid)
{
	e_pAccountData[playerid][mDBID] = cache_insert_id(); 
	format(e_pAccountData[playerid][mAccName], 32, "%s", ReturnName(playerid)); 
	
	registerTime[playerid] = 0;
	loginTime[playerid] = 1; 
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "You successfully registered as %s. You need to login to continue:", ReturnName(playerid)); 
	return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server", "SERVER: You have 60 seconds to login!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Select", "Cancel");
}

function:LoggingIn(playerid)
{
	if(!cache_num_rows())
	{
		playerLogin[playerid]++;
		if(playerLogin[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_REDEX, "[SERVER]: You were kicked for bad password attempts.");
			return KickEx(playerid);
		}
		
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server", "You entered the wrong password!\n\nSERVER: You have 60 seconds to login!\nTIP: Please report all bugs that you\nmay have found to development.\n\n           Enter Your Password:", "Select", "Cancel");
	}
	
	new rows, fields, fetchChars[128];
	cache_get_data(rows, fields, ourConnection);
	
	new secret_word[128], ActiveIP[60];
	
	e_pAccountData[playerid][mDBID] = cache_get_field_content_int(0, "acc_dbid", ourConnection); 
	cache_get_field_content(0, "forum_name", e_pAccountData[playerid][mForumName], ourConnection, 60);
	
	cache_get_field_content(0, "secret_word", secret_word); 
	cache_get_field_content(0, "active_ip", ActiveIP);
	
	format(e_pAccountData[playerid][mAccName], 32, "%s", ReturnName(playerid));
	
	if(isnull(secret_word))
	{
		ShowPlayerDialog(playerid, DIALOG_SECRETWORD_CREATE, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server",
		"SECURITY PRECAUTION:\n\nWe have introduced a SECRET CONFIRMATION CODE system to help protect user accounts. This is basically a word that will be presented if any connection conditions change.\n\nYou will have to remember this.\n\n{F81414}IT IS ADVISED THIS ISN'T YOUR PASSWORD.", "Enter", "Cancel");
		return 1; 
	}
	
	if(strcmp(ReturnIP(playerid), ActiveIP))
	{
		ShowPlayerDialog(playerid, DIALOG_SECRETWORD_INPUT, DIALOG_STYLE_PASSWORD, "Welcome to Beta Server",
		"{F81414}SECURITY PRECAUTION:{FFFFFF}\n\nOur system has flagged changes to your accounts connection conditions. To ensure there is no breach of security,\n\nPlease enter your {F81414}SECURITY CONFIRMATION CODE{FFFFFF} you selected during registration to login.", "Enter", "Cancel");
		return 1;
	}	
	
	mysql_format(ourConnection, fetchChars, sizeof(fetchChars), "SELECT * FROM bannedlist WHERE MasterDBID = %i", e_pAccountData[playerid][mDBID]);
	mysql_tquery(ourConnection, fetchChars, "Query_CheckBannedAccount", "i", playerid); 
	return 1;
}

function:Query_CheckBannedAccount(playerid)
{
	if(!cache_num_rows())
	{
		new fetchChars[128];
		
		loginTime[playerid] = 0; 
		characterPickTime[playerid] = 1;
		
		mysql_format(ourConnection, fetchChars, sizeof(fetchChars), "SELECT char_name, char_dbid FROM characters WHERE master_dbid = %i LIMIT 4", e_pAccountData[playerid][mDBID]);
		mysql_pquery(ourConnection, fetchChars, "DB_ListCharacters", "i", playerid);
	}
	else
	{
		new rows, fields;
		cache_get_data(rows, fields, ourConnection); 
		
		new banDate[90], banner[32];
		
		cache_get_field_content(0, "Date", banDate, ourConnection, 90);
		cache_get_field_content(0, "BannedBy", banner, ourConnection, 32);
	
		SendServerMessage(playerid, "Your account \"%s\" is banned from our server.", ReturnName(playerid));
		SendServerMessage(playerid, "You were banned on %s by %s.", banDate, banner); 
		return KickEx(playerid);
	}
	return 1;
}

function:DB_ListCharacters(playerid)
{
	if(!cache_num_rows())
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You don't have any existing characters.");
		
		new listStrings[128];
		
		for (new i = 0; i < 4; i++)
		{
			characterLister[playerid][i] = "[Empty Character]"; 
			format(listStrings, sizeof(listStrings), "%s%s\n", listStrings, characterLister[playerid][i]);
		}
		
		return ShowPlayerDialog(playerid, DIALOG_CHARS, DIALOG_STYLE_LIST, "Characters:", listStrings, "Select", "<<"); 
	}
	
	if (e_pAccountData[playerid][mLoggedin] == false)
	{
		new string[128];
	
		format(string, sizeof(string), "You have successfully logged in as {145F0B}%s{FFFFFF}.", ReturnName(playerid));
		SendClientMessage(playerid, -1, string);
		
		e_pAccountData[playerid][mLoggedin] = true;
		SetPlayerCamera(playerid);
	}
	
	new rows, fields;
	cache_get_data(rows, fields, ourConnection);
	
	if(rows)
	{
		new listString[128];
		
		for (new i = 0; i < rows; i ++)
		{
			cache_get_field_content(i, "char_name", characterLister[playerid][i], ourConnection, 128); 
		}
		
		for (new i = 0; i < 4; i++)
		{
			if (isnull(characterLister[playerid][i]))
			{
				characterLister[playerid][i] = "[Empty Character]"; 
			}
			
			format(listString, sizeof(listString), "%s%s\n", listString, characterLister[playerid][i]);
		}
		
		ShowPlayerDialog(playerid, DIALOG_CHARS, DIALOG_STYLE_LIST, "Characters:", listString, "Select", "<<"); 
	}
	return 1;
}

function:Query_SelectCharacter(playerid)
{
	if (!cache_num_rows())
	{
		SendClientMessage(playerid, -1, "[ERROR]: An error occurred processing your character. Returning you to your character list...");
		
		new
			listString[128]
		;
		
		for (new i = 0; i < 4; i ++) {
			format(listString, sizeof(listString), "%s%s\n", listString, characterLister[playerid][i]); }
			
		return ShowPlayerDialog(playerid, DIALOG_CHARS, DIALOG_STYLE_LIST, "Characters:", listString, "Select", "<<"); 
	}
	
	new rows, fields, thread[128]; 
	cache_get_data(rows, fields, ourConnection); 
	
	if(rows)
	{
		mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM characters WHERE char_name = '%e'", ReturnName(playerid));
		mysql_tquery(ourConnection, thread, "Query_LoadCharacter", "i", playerid);
	}
	
	return 1;
}

function:Query_LoadCharacter(playerid)
{
	PlayerInfo[playerid][pDBID] = cache_get_field_content_int(0, "char_dbid", ourConnection);

	PlayerInfo[playerid][pAdmin] = cache_get_field_content_int(0, "pAdmin", ourConnection);
	PlayerInfo[playerid][pLastSkin] = cache_get_field_content_int(0, "pLastSkin", ourConnection);
	
	PlayerInfo[playerid][pLastPos][0] = cache_get_field_content_float(0, "pLastPosX", ourConnection);
	PlayerInfo[playerid][pLastPos][1] = cache_get_field_content_float(0, "pLastPosY", ourConnection);
	PlayerInfo[playerid][pLastPos][2] = cache_get_field_content_float(0, "pLastPosZ", ourConnection);
	
	PlayerInfo[playerid][pLastInterior] = cache_get_field_content_int(0, "pLastInterior", ourConnection);
	PlayerInfo[playerid][pLastWorld] = cache_get_field_content_int(0, "pLastWorld", ourConnection);
	
	PlayerInfo[playerid][pLevel] = cache_get_field_content_int(0, "pLevel", ourConnection);
	PlayerInfo[playerid][pEXP] = cache_get_field_content_int(0, "pEXP", ourConnection);
	
	cache_get_field_content(0, "pAge", PlayerInfo[playerid][pAge], ourConnection, 20);
	
	cache_get_field_content(0, "pStory", PlayerInfo[playerid][pStory], ourConnection, 90);
	cache_get_field_content(0, "pStoryTwo", PlayerInfo[playerid][pStoryTwo], ourConnection, 90);
	
	PlayerInfo[playerid][pMoney] = cache_get_field_content_int(0, "pMoney", ourConnection);
	PlayerInfo[playerid][pBank] = cache_get_field_content_int(0, "pBank", ourConnection); 
	PlayerInfo[playerid][pPaycheck] = cache_get_field_content_int(0, "pPaycheck", ourConnection);
	
	PlayerInfo[playerid][pPhone] = cache_get_field_content_int(0, "pPhone", ourConnection); 
	
	cache_get_field_content(0, "pLastOnline", PlayerInfo[playerid][pLastOnline], ourConnection, 90);
	PlayerInfo[playerid][pLastOnlineTime] = cache_get_field_content_int(0, "pLastOnlineTime", ourConnection); 
	
	PlayerInfo[playerid][pAdminjailed] = bool:cache_get_field_content_int(0, "pAdminjailed", ourConnection);
	PlayerInfo[playerid][pAdminjailTime] = cache_get_field_content_int(0, "pAdminjailTime", ourConnection);
	
	PlayerInfo[playerid][pOfflinejailed] = bool:cache_get_field_content_int(0, "pOfflinejailed", ourConnection);
	cache_get_field_content(0, "pOfflinejailedReason", PlayerInfo[playerid][pOfflinejailedReason], ourConnection, 128);
	
	PlayerInfo[playerid][pFaction] = cache_get_field_content_int(0, "pFaction", ourConnection);
	PlayerInfo[playerid][pFactionRank] = cache_get_field_content_int(0, "pFactionRank", ourConnection);
	
	PlayerInfo[playerid][pVehicleSpawned] = bool:cache_get_field_content_int(0, "pVehicleSpawned", ourConnection);
	PlayerInfo[playerid][pVehicleSpawnedID] = cache_get_field_content_int(0, "pVehicleSpawnedID", ourConnection);
	
	PlayerInfo[playerid][pTimeplayed] = cache_get_field_content_int(0, "pTimeplayed", ourConnection);
	
	PlayerInfo[playerid][pMaskID][0] = cache_get_field_content_int(0, "pMaskID", ourConnection);
	PlayerInfo[playerid][pMaskID][1] = cache_get_field_content_int(0, "pMaskIDEx", ourConnection);
	
	PlayerInfo[playerid][pInsideProperty] = cache_get_field_content_int(0, "pInProperty", ourConnection);
	PlayerInfo[playerid][pInsideBusiness] = cache_get_field_content_int(0, "pInBusiness", ourConnection);
	
	PlayerInfo[playerid][pHasRadio] = bool:cache_get_field_content_int(0, "pHasRadio", ourConnection);
	PlayerInfo[playerid][pMainSlot] = cache_get_field_content_int(0, "pMainSlot", ourConnection);
	
	PlayerInfo[playerid][pGascan] = cache_get_field_content_int(0, "pGascan", ourConnection);
	
	PlayerInfo[playerid][pSpawnPoint] = cache_get_field_content_int(0, "pSpawnPoint", ourConnection);
	PlayerInfo[playerid][pSpawnPointHouse] = cache_get_field_content_int(0, "pSpawnPointHouse", ourConnection); 
	
	PlayerInfo[playerid][pWeaponsLicense] = cache_get_field_content_int(0, "pWeaponsLicense", ourConnection);
	PlayerInfo[playerid][pDriversLicense] = cache_get_field_content_int(0, "pDriversLicense", ourConnection); 
	
	PlayerInfo[playerid][pActiveListings] = cache_get_field_content_int(0, "pActiveListings", ourConnection); 
	PlayerInfo[playerid][pJailTimes] = cache_get_field_content_int(0, "pJailTimes", ourConnection);
	PlayerInfo[playerid][pPrisonTimes] = cache_get_field_content_int(0, "pPrisonTimes", ourConnection); 
	
	new str[128];
	
	for(new i = 1; i < 3; i++)
	{
		format(str, sizeof(str), "pRadio%i", i);
		PlayerInfo[playerid][pRadio][i] = cache_get_field_content_int(0, str, ourConnection);
	}
	
	for(new i = 0; i < 4; i++)
	{
		format(str, sizeof(str), "pWeapons%d", i);
		PlayerInfo[playerid][pWeapons][i] = cache_get_field_content_int(0, str, ourConnection);
		
		format(str, sizeof(str), "pWeaponsAmmo%d", i);
		PlayerInfo[playerid][pWeaponsAmmo][i] = cache_get_field_content_int(0, str, ourConnection);
	}
	
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{	
		format(str, sizeof(str), "pOwnedVehicles%d", i);
		PlayerInfo[playerid][pOwnedVehicles][i] = cache_get_field_content_int(0, str, ourConnection); 
	}
	
	if(!PlayerInfo[playerid][pMaskID])
	{
		PlayerInfo[playerid][pMaskID][0] = 200000+random(199991);
		PlayerInfo[playerid][pMaskID][1] = 40+random(59);
	}
	
	TogglePlayerSpectating(playerid, false);
	return LoadCharacter(playerid);
}

function:LoadCharacter(playerid)
{
	new
		string[128]
	;
	
	PlayerInfo[playerid][pLoggedin] = true;
	 
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	SetPlayerColor(playerid, 0xFFFFFFFF);
	
	ResetPlayerMoney(playerid); 
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pLastSkin], PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	
	format(string, sizeof(string), "~w~Welcome~n~~y~ %s", ReturnName(playerid));
	GameTextForPlayer(playerid, string, 1000, 1);
	
	if (PlayerInfo[playerid][pAdmin])
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: You logged in as a level %i admin.", PlayerInfo[playerid][pAdmin]);
		
		if(!strcmp(e_pAccountData[playerid][mForumName], "Null"))
		{
			ShowPlayerDialog(playerid, 99, DIALOG_STYLE_MSGBOX, "Notification", "This message notifies all admins on login if their forum name hasn't been set.\nYour forum name is NULL and requires a change.\n\n{F81414}Please ensure it's changed ASAP using /forumname.", "Understood", ""); 
		}
	}
	
	if(PlayerInfo[playerid][pVehicleSpawned] == true)
	{
		if(!IsValidVehicle(PlayerInfo[playerid][pVehicleSpawnedID]))
			PlayerInfo[playerid][pVehicleSpawned] = false; 
			
		else
			SendServerMessage(playerid, "Your vehicle is still spawned.");
	}
	
	SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);
	SetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
	
	if(PlayerInfo[playerid][pOfflinejailed])
	{
		if(strlen(PlayerInfo[playerid][pOfflinejailedReason]) > 56)
		{
			SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was admin jailed by SYSTEM for %d minutes, Reason: %.56s", ReturnName(playerid), PlayerInfo[playerid][pAdminjailTime] / 60, PlayerInfo[playerid][pOfflinejailedReason]);
			SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", PlayerInfo[playerid][pOfflinejailedReason][56]); 
		}
		else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was admin jailed by SYSTEM for %d minutes, Reason: %s", ReturnName(playerid), PlayerInfo[playerid][pAdminjailTime] / 60, PlayerInfo[playerid][pOfflinejailedReason]);
		
		ClearAnimations(playerid); 
		
		SetPlayerPos(playerid, 2687.3630, 2705.2537, 22.9472);
		SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 1338);
		
		PlayerInfo[playerid][pOfflinejailed] = false; 
		PlayerInfo[playerid][pAdminjailed] = true; 
	}
	
	format(PlayerInfo[playerid][pActiveIP], 60, "%s", ReturnIP(playerid)); 
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (e_pAccountData[playerid][mLoggedin] == false)
	{
		TogglePlayerSpectating(playerid, true);
		return 0;
	}
	else if(e_pAccountData[playerid][mLoggedin] == true)
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pLastSkin], PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
		return 0;
	}
	else return 0;
}

function:KickTimer(playerid) { return Kick(playerid); }

function:ResetPlayer(playerid)
{
	//Master accounts:
	e_pAccountData[playerid][mDBID] = 0; 
	e_pAccountData[playerid][mLoggedin] = false; 
	
	playerLogin[playerid] = 0; 
	playerMakingCharacter[playerid] = false;
	playerCharacterStep[playerid] = 0;
	
	for(new i = 0; i < 2 ; i++) 
	{ 
		format(playerCharacterStory[playerid][i], 90, ""); 
	}
	
	//Prevents;
	loginTime[playerid] = 0;
	registerTime[playerid] = 0;
	characterPickTime[playerid] = 0;
	
	ResetDealershipVars(playerid);
	ClearDamages(playerid);
	
	playerPhone[playerid] = 0;
	
	for(new i = 0; i < 5; i++) PlayerPlateSaver[playerid][i] = "";
	PlayerMDCName[playerid] = "";
	
	//Player characters:
	PlayerInfo[playerid][pDBID] = 0; 
	PlayerInfo[playerid][pLoggedin] = false; 
	
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pAdminDuty] = false; 
	PlayerInfo[playerid][pLastSkin] = 264;
	
	PlayerInfo[playerid][pLastPos][0] = 1642.02;
	PlayerInfo[playerid][pLastPos][1] = -2334.05;
	PlayerInfo[playerid][pLastPos][2] = 13.5469;
	
	PlayerInfo[playerid][pLastInterior] = 0;
	PlayerInfo[playerid][pLastWorld] = 0;
	
	PlayerInfo[playerid][pLevel] = 1; 
	PlayerInfo[playerid][pAge] = 20; 
	
	PlayerInfo[playerid][pMoney] = 5000;
	PlayerInfo[playerid][pBank] = 15000;
	PlayerInfo[playerid][pPaycheck] = 5000; 
	
	PlayerInfo[playerid][pPhone] = 94000+random(6999);
	PlayerInfo[playerid][pPhoneOff] = false; 
	PlayerInfo[playerid][pPhonespeaker] = false; 
	
	PlayerInfo[playerid][pCalling] = 0;
	PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
	
	PlayerInfo[playerid][pMuted] = false;
	
	PlayerInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
	
	PlayerInfo[playerid][pFaction] = 0;
	PlayerInfo[playerid][pFactionRank] = 0;
	PlayerInfo[playerid][pFactionInvite] = 0;
	PlayerInfo[playerid][pFactionInvitedBy] = INVALID_PLAYER_ID;
	
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++) { 
		PlayerInfo[playerid][pOwnedVehicles][i] = 0; 
	}
	
	PlayerInfo[playerid][pVehicleSpawned] = false;
	PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pDuplicateKey] = INVALID_VEHICLE_ID;
	
	PlayerInfo[playerid][pWeaponsSpawned] = false;
	
	for(new i = 0; i < 4; i++){
		PlayerInfo[playerid][pWeapons][i] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
	}
	
	PlayerInfo[playerid][pUnscrambling] = false;
	PlayerInfo[playerid][pUnscramblerTime] = 0;
	PlayerInfo[playerid][pScrambleFailed] = 0;
	PlayerInfo[playerid][pScrambleSuccess] = 0; 
	PlayerInfo[playerid][pUnscrambleID] = 0;
	
	PlayerInfo[playerid][pPoliceDuty] = false;
	PlayerInfo[playerid][pMedicDuty] = false;
	
	PlayerInfo[playerid][pTimeplayed] = 0;
	
	PlayerInfo[playerid][pInsideProperty] = 0; 
	PlayerInfo[playerid][pInsideBusiness] = 0;
	PlayerInfo[playerid][pAtDealership] = 0;
	
	PlayerInfo[playerid][pMaskID][0] = 200000+random(199991);
	PlayerInfo[playerid][pMaskID][1] = 40+random(59);
	PlayerInfo[playerid][pMasked] = false;
	PlayerInfo[playerid][pHasMask] = false;
	
	PlayerInfo[playerid][pOfflinejailed] = false;
	
	PlayerInfo[playerid][pLastDamagetime] = 0;
	
	PlayerInfo[playerid][pRelogCount] = 0;
	PlayerInfo[playerid][pRelogging] = false;
	
	PlayerInfo[playerid][pAddObject] = INVALID_OBJECT_ID;
	PlayerInfo[playerid][pEditingObject] = 0;
	
	PlayerInfo[playerid][pHasRadio] = false;
	PlayerInfo[playerid][pMainSlot] = 1; 
	
	for(new i = 1; i < 3; i++){
		PlayerInfo[playerid][pRadio][i] = 0;
	}
	
	PlayerInfo[playerid][pRespawnTime] = 0;
	
	PlayerInfo[playerid][pSpawnPoint] = 0; 
	PlayerInfo[playerid][pSpawnPointHouse] = 0;
	
	PlayerInfo[playerid][pTaser] = false; 
	
	PlayerInfo[playerid][pWeaponsLicense] = 0;
	PlayerInfo[playerid][pDriversLicense] = 0;
	
	PlayerInfo[playerid][pActiveListings] = 0;
	PlayerInfo[playerid][pJailTimes] = 0;
	PlayerInfo[playerid][pPrisonTimes] = 0;
	return 1;
}

function:FunctionPlayers()
{
	foreach (new i : Player)
	{
		if(GetTickCount() > (PlayerInfo[i][pPauseCheck]+2000))
			PlayerInfo[i][pPauseTime] ++; 
			
		else PlayerInfo[i][pPauseTime] = 0;
	
		if(e_pAccountData[i][mLoggedin] == false)
		{
			if(loginTime[i] > 0)
			{
				loginTime[i]++;
				
				if(loginTime[i] >= 60)
				{
					SendServerMessage(i, "You were kicked for not logging in."); 
					KickEx(i); 
				}
			}
			
			if(registerTime[i] > 0)
			{
				registerTime[i]++;
				
				if(registerTime[i] >= 60)
				{
					SendServerMessage(i, "You were kicked for not registering.");
					KickEx(i); 
				}
			}
		}
		
		if(characterPickTime[i] > 0)
		{
			characterPickTime[i]++;
			
			if(characterPickTime[i] >= 60)
			{
				SendServerMessage(i, "You were kicked for not selecting a character.");
				KickEx(i);
			}
		}
			
		if (PlayerInfo[i][pAdminjailed] == true)
		{
			PlayerInfo[i][pAdminjailTime]--; 
			
			if(PlayerInfo[i][pAdminjailTime] < 1)
			{
				PlayerInfo[i][pAdminjailed] = false; 
				PlayerInfo[i][pAdminjailTime] = 0; 
				
				SendServerMessage(i, "You served your admin jail time.");
				
				new str[128];
				format(str, sizeof(str), "%s was released from admin jail.", ReturnName(i));
				SendAdminMessage(1, str);
				
				SetPlayerVirtualWorld(i, 0); SetPlayerInterior(i, 0);
				SetPlayerPos(i, 1553.0421, -1675.4706, 16.1953);
			}
		}
		
		if(PlayerInfo[i][pDeathFix])
		{
			PlayerInfo[i][pDeathFix]++;
			if(PlayerInfo[i][pDeathFix] == 5)
			{
				PlayerInfo[i][pDeathFix] = 0;
			}
		}
		
		if(PlayerTakingLicense[i] && PlayerLicenseTime[i] <= 60)
		{
			PlayerLicenseTime[i]--; 
			
			new
				str[128]
			;
			
			format(str, sizeof(str), "~w~%d", PlayerLicenseTime[i]);
			GameTextForPlayer(i, str, 2000, 3); 
			
			if(PlayerLicenseTime[i] < 1)
			{
				StopDriverstest(i);
				SendClientMessage(i, COLOR_DARKGREEN, "You took too long and failed."); 
			}
		}
	}
	return 1;
}

function:OnWeaponsUpdate()
{
	foreach(new i : Player)
	{
		if(e_pAccountData[i][mLoggedin] == false)
			continue;
		
		if(!PlayerHasWeapons(i))
			continue;
			
		for (new w = 0; w < 4; w++)
		{
			new idx = WeaponDataSlot(PlayerInfo[i][pWeapons][w]); 
			
			if(PlayerInfo[i][pWeapons][w] != 0 && PlayerInfo[i][pWeaponsAmmo][w] > 0)
			{
				GetPlayerWeaponData(i, idx, PlayerInfo[i][pWeapons][w], PlayerInfo[i][pWeaponsAmmo][w]); 
			}
			
			if(PlayerInfo[i][pWeapons][w] != 0 && PlayerInfo[i][pWeaponsAmmo][w] == 0)
			{
				PlayerInfo[i][pWeapons][w] = 0;
				//Removing 0 ammo weapons;
			}
		}
			
		return 1;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	new
		Float: vehicle_health
	;

	GetVehicleHealth(vehicleid, vehicle_health); 
	printf("[DEBUG] Vehicle ID: %i (%s) (Health: %.2f) destroyed by %s", ReturnVehicleName(vehicleid), vehicle_health, ReturnName(killerid)); 
	
	if(VehicleInfo[vehicleid][eVehicleFaction])
		SetVehicleToRespawn(vehicleid);
		
	else
	{
		foreach(new i : Player) if(PlayerInfo[i][pDBID] == VehicleInfo[i][eVehicleOwnerDBID])
		{
			SendClientMessageEx(i, COLOR_RED, "Your %s was destroyed.", ReturnVehicleName(vehicleid)); 
			
			PlayerInfo[i][pVehicleSpawned] = false;
			PlayerInfo[i][pVehicleSpawnedID] = INVALID_VEHICLE_ID; 
		}
		else
		{
			new
				chanquery[128]
			;
			
			mysql_format(ourConnection, chanquery, sizeof(chanquery), "UPDATE characters SET pVehicleSpawned = 0, pVehicleSpawnedID = %i WHERE char_dbid = %i", INVALID_VEHICLE_ID, VehicleInfo[vehicleid][eVehicleOwnerDBID]);
			mysql_pquery(ourConnection, chanquery); 
		}
	}	
		
	return 1; 
}

function:OnVehicleUpdate()
{
	new
		Float:vehicle_health,
		owner_id = INVALID_PLAYER_ID,
		str[128]
	; 

	for (new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
	{
		if(VehicleInfo[i][eVehicleFaction] || VehicleInfo[i][eVehicleAdminSpawn])
			continue;
			
		GetVehicleHealth(i, vehicle_health); 
		
		if(vehicle_health <= 248) //this is the point where the vehicle starts to catch fire;
		{
			foreach(new p : Player) if(PlayerInfo[p][pDBID] == VehicleInfo[i][eVehicleOwnerDBID])
			{
				owner_id = p;
			}
			
			if (owner_id != INVALID_PLAYER_ID)
			{			
				new
					Float:life_deplete
				;
				
				life_deplete = VehicleInfo[i][eVehicleEngine] / 1.30;
				printf("life_deplete is: %f", life_deplete); 
				
				VehicleInfo[i][eVehicleTimesDestroyed] ++; 
				
				if(VehicleInfo[i][eVehicleEngine] - life_deplete < 1.00)
					VehicleInfo[i][eVehicleEngine] = 0.0; 
				
				else VehicleInfo[i][eVehicleEngine] = life_deplete;
				VehicleInfo[i][eVehicleBattery]-= 10.00; 
				
				PlayerInfo[owner_id][pVehicleSpawned] = false; 
				PlayerInfo[owner_id][pVehicleSpawnedID] = INVALID_VEHICLE_ID; 
			
				SendClientMessageEx(owner_id, COLOR_RED, "Your %s has been destroyed.", ReturnVehicleName(i)); 
				SendClientMessageEx(owner_id, COLOR_RED, "HEALTH: Engine health depleted to {FFFFFF}%.2f. {FF6346}Battery health depleted to {FFFFFF}%.2f{FF6346}.", VehicleInfo[i][eVehicleEngine], VehicleInfo[i][eVehicleBattery]); 
			}
			else
			{
				mysql_format(ourConnection, str, sizeof(str), "UPDATE characters SET pVehicleSpawned = 0, pVehicleSpawnedID = %i WHERE char_dbid = %i", INVALID_VEHICLE_ID, VehicleInfo[i][eVehicleOwnerDBID]);
				mysql_pquery(ourConnection, str); 
			}
			
			new
				car_driver = INVALID_PLAYER_ID
			;
			
			foreach(new c : Player) if(IsPlayerInVehicle(c, i))
			{
				if(GetPlayerState(c) == PLAYER_STATE_DRIVER)
					car_driver = c; 
			}
			
			if(car_driver == INVALID_PLAYER_ID)
				format(str, sizeof(str), "Vehicle %s (ID: %i) was destroyed.", ReturnVehicleName(i), i); 
			
			else format(str, sizeof(str), "Vehicle %s (ID %i) was destroyed. Driver was: %s", ReturnVehicleName(i), i, ReturnName(car_driver));
			
			SendAdminMessage(1, str);
			SaveVehicle(i); 
			
			ResetVehicleVars(i);
			DestroyVehicle(i); 
		}
	}
	return 1;
}

function:FunctionPaychecks()
{
	new 
		hour, 
		minute, 
		seconds
	;

	gettime(hour, minute, seconds); 
	
	if(minute == 00 && seconds == 59)
	{
		CallPaycheck(); 
		SetWorldTime(hour + 1); 
	}
	
	return 1;
}

function:CallPaycheck()
{
	foreach(new i : Player)
	{
		if(!PlayerInfo[i][pLoggedin])
			continue;
			
		new
			str[128],
			total_paycheck = 0
		; 
		
		new
			Float: interest,
			interest_convert,
			total_tax
		; 
		
		PlayerInfo[i][pTimeplayed]++; 
		PlayerInfo[i][pEXP]++; 
		
		if(PlayerInfo[i][pLevel] == 1)
			total_paycheck+= 2000; 
			
		else if(PlayerInfo[i][pLevel] == 2)
			total_paycheck+= 1500; 
			
		//Add an auto-level up on paycheck for level 1 and 2 to prevent paycheck farming.
			
		interest = (PlayerInfo[i][pBank] / 100) * 0.1; 
		interest_convert = floatround(interest, floatround_round); 
		
		total_tax = total_paycheck / 10; 
		
		SendClientMessageEx(i, COLOR_WHITE, "SERVER TIME:[ %s ]", ReturnHour()); 
		
		SendClientMessage(i, COLOR_WHITE, "|___ BANK STATEMENT ___|"); 
		SendClientMessageEx(i, COLOR_GREY, "   Balance: $%s", MoneyFormat(PlayerInfo[i][pBank])); 
		SendClientMessage(i, COLOR_GREY, "   Interest rate: 0.1");
		SendClientMessageEx(i, COLOR_GREY, "   Interest Gained: $%s", MoneyFormat(interest_convert));
		SendClientMessageEx(i, COLOR_GREY, "   Tax paid: $%s", MoneyFormat(total_tax)); 
		SendClientMessage(i, COLOR_WHITE, "|________________________|");
		
		PlayerInfo[i][pPaycheck]+= total_paycheck; 
		PlayerInfo[i][pBank]+= interest_convert; 
		PlayerInfo[i][pBank]-= total_tax; 
		
		SendClientMessageEx(i, COLOR_WHITE, "   New Balance: $%s", MoneyFormat(PlayerInfo[i][pBank]));
		
		if(PlayerInfo[i][pLevel] == 1)
			SendClientMessage(i, COLOR_WHITE, "(( You have received $2,000 for being level 1. ))");
			
		else if(PlayerInfo[i][pLevel] == 2)
			SendClientMessage(i, COLOR_WHITE, "(( You have received $1,500 for being level 2. ))");
		
		format(str, sizeof(str), "~y~Payday~n~~w~Paycheck~n~~g~$%d", total_paycheck);
		GameTextForPlayer(i, str, 3000, 1); 
	
		SaveCharacter(i); 
	}
	return 1;
}

function:OnPlayerNearProperty()
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pLoggedin] == false)
			continue;
			
		for(new p = 1; p < MAX_PROPERTY; p++)
		{
			if(!PropertyInfo[p][ePropertyDBID])
				continue;
				
			if(IsPlayerInRangeOfPoint(i, 3.0, PropertyInfo[p][ePropertyEntrance][0], PropertyInfo[p][ePropertyEntrance][1], PropertyInfo[p][ePropertyEntrance][2]))
			{
				if(GetPlayerInterior(i) != PropertyInfo[p][ePropertyEntranceInterior])
					continue;
					
				if(GetPlayerVirtualWorld(i) != PropertyInfo[p][ePropertyEntranceWorld])
					continue; 
		
				if(!PropertyInfo[p][ePropertyOwnerDBID])
				{
					SendClientMessage(i, COLOR_DARKGREEN, "This property is for sale. Use /buyproperty."); 
					SendClientMessageEx(i, COLOR_DARKGREEN, "Price: $%i", PropertyInfo[p][ePropertyMarketPrice]);
				}
				else
				{
					SendClientMessageEx(i, COLOR_DARKGREEN, "You're standing on %s's porch. Use /enter to go in.",  ReturnDBIDName(PropertyInfo[p][ePropertyOwnerDBID]));
				}	
			}
		}
	}
	return 1;
}

function:OnPlayerNearBusiness()
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pLoggedin] == false)
			continue;
			
		new
			id,
			str[128]
		;
		
		if((id = IsPlayerNearBusiness(i)) != 0)
		{
			if(!BusinessInfo[id][eBusinessOwnerDBID])
			{
				if(BusinessInfo[id][eBusinessType] > 5)
					format(str, sizeof(str), "%s~n~~w~Entrance Fee : ~g~$%d~n~~p~To use /enter", BusinessInfo[id][eBusinessName], BusinessInfo[id][eBusinessEntranceFee]); 
					
				else format(str, sizeof(str), "%s~n~~w~This business is for sale~n~Price : ~g~$%d~w~ Level : %d~n~~p~To buy use /buybiz", BusinessInfo[id][eBusinessName], BusinessInfo[id][eBusinessMarketPrice], BusinessInfo[id][eBusinessLevel]); 
			}
			else format(str, sizeof(str), "%s~n~~w~Owned By : %s~n~Entrance Fee : ~g~$%d~n~~p~To use /enter", BusinessInfo[id][eBusinessName], ReturnDBIDName(BusinessInfo[id][eBusinessOwnerDBID]), BusinessInfo[id][eBusinessEntranceFee]); 
			
			GameTextForPlayer(i, str, 3500, 3); 	
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
		SendAdminMessageEx(COLOR_RED, 4, "[DEBUG DEBUG] %s was killed by %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason));

	printf("Callback OnPlayerDeath called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	//SetTimerEx("SetPlayersSpawn", 2100, false, "i", playerid); 
	return 1; 
}

function:OnPlayerWounded(playerid, killerid, reason)
{
	new
		str[128]
	;
	
	PlayerInfo[playerid][pDeathFix] = 1; 
	
	format(str, sizeof(str), "%s has been brutally wounded by %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason)); 
	SendAdminMessageEx(COLOR_RED, 1, str); 

	GameTextForPlayer(playerid, "~b~BRUTALLY WOUNDED", 5000, 3);
	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);		
	
	SetPlayerHealth(playerid, 26); 
	SetPlayerWeather(playerid, 250); 
	
	GiveMoney(playerid, -200); 
	SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED); 
	
	SendClientMessage(playerid, COLOR_RED, "You have been brutally wounded. If you aren't saved, you will die.");
	SendClientMessage(playerid, COLOR_RED, "To accept death, type: /acceptdeath."); 
	return 1;
}

function:OnPlayerDead(playerid, killerid, reason, executed)
{
	new
		str[128]
	;
	
	if(executed == 1)
	{
		format(str, sizeof(str), "%s has been executed by %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason)); 
		SendAdminMessageEx(COLOR_RED, 1, str); 
	}
	
	SetPlayerTeam(playerid, PLAYER_STATE_DEAD); 
	PlayerInfo[playerid][pRespawnTime] = gettime(); 
	
	SendClientMessage(playerid, COLOR_YELLOWEX, "-> You're now dead. You need to wait 60 seconds until you can /respawnme."); 
	
	ClearAnimations(playerid, 1);
	for(new i =0; i <4; i++)
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	
	TogglePlayerControllable(playerid, 0);
	SetPlayerWeather(playerid, globalWeather); 
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		new
			Float:health
		;
		
		PlayerInfo[playerid][pLastDamagetime] = gettime();
		GetPlayerHealth(playerid, health); 
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE && PlayerInfo[playerid][pDeathFix])
			SetPlayerHealth(playerid, health); 
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{
			SetPlayerHealth(playerid, health - amount); 
			CallbackDamages(playerid, issuerid, bodypart, weaponid, amount); 
		}
		
		if(health - amount <= 4)
		{
			if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
			{
				if(IsPlayerInAnyVehicle(playerid))
					ClearAnimations(playerid); 
				
				CallLocalFunction("OnPlayerWounded", "iii", playerid, issuerid, weaponid); 
				return 0;
			}
			
			return 0;
		}
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
		{
			if(!PlayerInfo[playerid][pDeathFix])
			{				
				CallLocalFunction("OnPlayerDead", "iiii", playerid, issuerid, weaponid, 1);
				return 0;
			}
			
			return 0;
		}
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		{
			SetPlayerHealth(playerid, health);
			return 0;
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER) //Death system; 
	{	
		if(GetPlayerTeam(hitid) == PLAYER_STATE_WOUNDED && !PlayerInfo[hitid][pDeathFix])
		{	
			CallLocalFunction("OnPlayerDead", "iii", hitid, playerid, weaponid);
			return 0;
		} 
		else if(GetPlayerTeam(hitid) != PLAYER_STATE_ALIVE)
			return 0; 
			
	}
	
	if(PlayerInfo[playerid][pTaser] && weaponid == 23)
	{
		SetPlayerArmedWeapon(playerid, 0); 
		
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
		
		SetTimerEx("OnTaserShoot", 1100, false, "i", playerid); 
	}
	
	if(hittype == BULLET_HIT_TYPE_PLAYER) //Taser system; 
	{
		if(PlayerInfo[playerid][pTaser] && weaponid == 23)
		{
			if(!IsPlayerNearPlayer(playerid, hitid, 15.0))
			{
				SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> You aren't close enough to hit %s with your taser.", ReturnName(hitid, 0));
				return 0;
			}
			
			SetPlayerDrunkLevel(hitid, 4000); 
			TogglePlayerControllable(playerid, 1); 
			
			SendNearbyMessage(hitid, 20.0, COLOR_EMOTE, "* %s falls on the ground after being hit by %s's taser.", ReturnName(hitid, 0), ReturnName(playerid, 0)); 
			GameTextForPlayer(hitid, "~b~You Are Tasered", 2500, 3);
			
			SendClientMessage(hitid, COLOR_YELLOWEX, "-> You were just hit by a taser. 10,000 volts go through your body.");
			SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> You hit %s with your taser!", ReturnName(hitid, 0)); 
			
			ClearAnimations(playerid, 1);
			SetTimerEx("OnPlayerTasered", 1200, false, "i", hitid); 
			return 0;
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{	
	Streamer_Update(playerid);
	
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);
	SetPlayerWeather(playerid, globalWeather); 
	
	if(PlayerInfo[playerid][pAdminjailed] == true)
	{
		ClearAnimations(playerid); 
		
		SetPlayerPos(playerid, 2687.3630, 2705.2537, 22.9472);
		SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 1338);
		
		SendServerMessage(playerid, "You're currently admin jailed. You have %i minutes left.", PlayerInfo[playerid][pAdminjailTime] / 60);
	}
	else
	{
		if(PlayerInfo[playerid][pWeaponsSpawned] == false)
		{
			for(new i = 0; i < 4; i ++)
			{
				if(PlayerInfo[playerid][pWeapons][i] != 0)
				{
					GivePlayerGun(playerid, PlayerInfo[playerid][pWeapons][i], PlayerInfo[playerid][pWeaponsAmmo][i]);
				}
			}
			
			SetPlayerArmedWeapon(playerid, 0);
			PlayerInfo[playerid][pWeaponsSpawned] = true;
		}
		
		if(PlayerInfo[playerid][pSpectating] != INVALID_PLAYER_ID)
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
			PlayerInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
		}
		else SetPlayersSpawn(playerid); 
	}
	
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(PlayerInfo[playerid][pSpectating] != INVALID_PLAYER_ID)
	{
		SendServerMessage(playerid, "You can't type while you're spectating.");
		return 0;
	}
	
	if(PlayerInfo[playerid][pLoggedin] && GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
	{
		SendServerMessage(playerid, "You can't talk when you aren't alive.");
		return 0;
	}
	
	if(PlayerInfo[playerid][pRelogging])
	{
		SendServerMessage(playerid, "You can't talk when relogging.");
		return 0;
	}

	if (playerMakingCharacter[playerid] == true)
	{
		switch (playerCharacterStep[playerid])
		{
			case 1:
			{
				if(strlen(text) > MAX_PLAYER_NAME + 1 || strlen(text) < 3)
				{
					SendErrorMessage(playerid, "Your characters name must be at least 3 characters and no more than %i characters.", MAX_PLAYER_NAME);
					return 0;
				}
				
				if(!IsValidRoleplayName(text))
				{
					SendErrorMessage(playerid, "Please follow the Firstname_Lastname format to make your character."); 
					return 0;
				}
				
				foreach (new i : Player)
				{
					if(!strcmp(text, ReturnName(i)))
					{
						SendErrorMessage(playerid, "That character already exists. Please try again."); 
						return 0;
					}
				}
				
				new
					threadSearch[128]
				;
				
				format(playerCharactersName[playerid], 128, "%s", text); 
				
				mysql_format(ourConnection, threadSearch, sizeof(threadSearch), "SELECT char_dbid FROM characters WHERE char_name = '%e'", text);
				mysql_tquery(ourConnection, threadSearch, "Query_CreateCharacter", "i", playerid);
				
				return 0;
			}
			case 2:
			{
				if(strlen(text) > 10)
				{
					SendErrorMessage(playerid, "Please follow the correct date format: 08/12/2017"); 
					return 0; 
				}
				
				new bool:keyFound = false;
				
				for(new i = 0; i < strlen(text); i++)
				{
					if(text[2] == '/' && text[5] == '/')
						continue; 
						
					if(text[i] < '0' || text[i] > '9')
						keyFound = true;
				}
				
				if(keyFound)
				{
					SendErrorMessage(playerid, "Please follow the correct date format: 08/12/2017"); 
					return 0; 
				}
				
				format(playerCharactersAge[playerid], 20, "%s", text);
				playerCharacterStep[playerid] = 3; 
				
				for (new i = 0; i < 16; i++){SendClientMessage(playerid, -1, " "); }
				
				new 
					string[128]
				;
		
				format (string, sizeof(string), "Your new characters date of birth will be: {145F0B}%s", playerCharactersAge[playerid]);
				SendClientMessage(playerid, -1, string); 
				
				SendClientMessage(playerid, -1, " "); 
				SendClientMessage(playerid, -1, "This next step will require your characters origin details. ");
				SendClientMessage(playerid, -1, "Please provide your characters origin. Example: {145F0B}United States of America");
			
				return 0;
			}
			case 3:
			{
				if(strlen(text) < 3)
				{
					SendErrorMessage(playerid, "Your characters origin must be longer than 3 characters."); 
					return 0;
				}
				
				format(playerCharacterOrigin[playerid], 60, "%s", text);
				playerCharacterStep[playerid] = 4; 
				
				new 
					string[128]
				;
				
				for (new i = 0; i < 16; i++){SendClientMessage(playerid, -1, " "); }
				
				format (string, sizeof(string), "Your new characters origin will be: {145F0B}%s", playerCharacterOrigin[playerid]);
				SendClientMessage(playerid, -1, string);
				
				SendClientMessage(playerid, -1, " "); 
				SendClientMessage(playerid, -1, "This next step will allow you the opportunity of writing a background story.");
				SendClientMessage(playerid, -1, "In no more than three (3) paragraphs, introduce your characters story."); 
				SendClientMessage(playerid, -1, "This step is {145F0B}optional{FFFFFF} and not required. Type {145F0B}\"skip\" {FFFFFF}to continue.");

				ClearLines(playerid, 2);

				return 0;
			}
			case 4:
			{
				if(!strcmp(text, "skip"))
				{
					ClearLines(playerid, 3);
					playerCharacterStep[playerid] = 5; 
					
					SendClientMessage(playerid, -1, "You have chosen to skip your characters background story.");
					SendClientMessage(playerid, -1, "This concludes your characters creation.");
					
					ClearLines(playerid, 1);
					
					new
						string[128]
					;
					
					format(string, sizeof(string), "Your new characters name is: {145F0B}%s", playerCharactersName[playerid]);
					SendClientMessage(playerid, -1, string);
					
					format(string, sizeof(string), "Your characters date of birth: {145F0B}%s", playerCharactersAge[playerid]);
					SendClientMessage(playerid, -1, string);
					
					format(string, sizeof(string), "Your characters origin: {145F0B}%s", playerCharacterOrigin[playerid]);
					SendClientMessage(playerid, -1, string);
					
					ClearLines(playerid, 2); 
					
					SendClientMessage(playerid, -1, "To finish, either type {145F0B}\"done\" {FFFFFF}or {145F0B}\"cancel\"{FFFFFF}.");
					return 0;
				}
				
				new string[128], bool:foundSpace = false, idx = 0; 
				
				for (new i = 0; i < 2; i ++)
				{
					if(isnull(playerCharacterStory[playerid][i]))
					{
						foundSpace = true;
						idx = i;
						break; 
					}
				}
				
				if (foundSpace)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "[Background Story]");
					format(playerCharacterStory[playerid][idx], 90, "%s", text);
					SendClientMessage(playerid, -1, playerCharacterStory[playerid][idx]); 
				}
				else
				{
					ClearLines(playerid, 2);
					SendClientMessage(playerid, -1, "You have exceeded the amount of space provided for your background story.");
					SendClientMessage(playerid, -1, "This concludes your characters creation.");
					
					SendClientMessage(playerid, -1, " ");
					
					format(string, sizeof(string), "Your new characters name is: {145F0B}%s", playerCharactersName[playerid]);
					SendClientMessage(playerid, -1, string);
					
					format(string, sizeof(string), "Your characters date of birth: {145F0B}%s", playerCharactersAge[playerid]);
					SendClientMessage(playerid, -1, string);
					
					format(string, sizeof(string), "Your characters origin: {145F0B}%s", playerCharacterOrigin[playerid]);
					SendClientMessage(playerid, -1, string);
					
					ClearLines(playerid, 2); 
					
					SendClientMessage(playerid, -1, "To finish, either type {145F0B}\"done\" {FFFFFF}or {145F0B}\"cancel\"{FFFFFF}.");
					playerCharacterStep[playerid] = 5; 
				}
				return 0;
			}
			case 5:
			{
				if(!strcmp(text, "done"))
				{
					ClearLines(playerid, 17); 
					
					SendClientMessage(playerid, COLOR_YELLOW, "You successfully created a new character. Please wait while your list is rebuilt."); 
					
					new 
						query[355]
					;
					
					mysql_format(ourConnection, query, sizeof(query), "INSERT INTO characters (`master_dbid`, `char_name`, `pAge`, `pOrigin`, `pStory`, `pStoryTwo`, `create_date`, `create_ip`, `pPhone`) VALUES(%i, '%e', '%e', '%e', '%e', '%e', '%e', '%e', %i)", e_pAccountData[playerid][mDBID], playerCharactersName[playerid], playerCharactersAge[playerid],
						playerCharacterOrigin[playerid], playerCharacterStory[playerid][0], playerCharacterStory[playerid][1], ReturnDate(), ReturnIP(playerid), 94000+random(6999));
					
					mysql_tquery(ourConnection, query); 
					
					SetTimerEx("RefreshCharacters", 3000, false, "i", playerid); 				
					return 0;
					
				}
				else if(!strcmp(text, "cancel"))
				{
					ClearLines(playerid, 16);
					
					SendClientMessage(playerid, -1, "You cancelled your character creation. You'll return to the character menu:");
					
					new fetchChars[128];
					
					mysql_format(ourConnection, fetchChars, sizeof(fetchChars), "SELECT char_name, char_dbid FROM characters WHERE master_dbid = %i LIMIT 4", e_pAccountData[playerid][mDBID]);
					mysql_pquery(ourConnection, fetchChars, "DB_ListCharacters", "i", playerid);
					
					return 0;
				}
				else 
				{
					SendClientMessage(playerid, -1, "To finish, either type {145F0B}\"done\" {FFFFFF}or {145F0B}\"cancel\"{FFFFFF}.");
					return 0;
				}
			}
		}
		return 0;
	}
	
	if(!playerMakingCharacter[playerid] && !e_pAccountData[playerid][mLoggedin] && !PlayerInfo[playerid][pLoggedin])
	{
		SendServerMessage(playerid, "You can't type during login.");
		return 0;
	}
	
	new 
		string[128]; 
		
	if(PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID && !PlayerInfo[playerid][pCalling])
	{
		if(PlayerInfo[playerid][pPhoneline] == 911)
		{
			format(string, sizeof(string), "%s says (phone): %s", ReturnName(playerid, 0), text); 
			LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			
			switch(Player911Type[playerid])
			{
				case 0: // 0 service, 1 - emergency, 2 - location
				{
					if(strfind(text, "Police", true) != -1 || strfind(text, "Cops", true) != -1 || strfind(text, "Law enforcement", true) != -1)
					{
						format(Player911Text[playerid][0], 128, "%s", text);
						
						SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: You're being transferred to the police. What's your emergency?"); 
						Player911Type[playerid] = 1; 
					}
					else if(strfind(text, "Medics", true) != -1 || strfind(text, "Paramedics", true) != -1 || strfind(text, "Ambulance", true) != -1 || strfind(text, "Fire", true) != -1)
					{
						format(Player911Text[playerid][0], 128, "%s", text);
						
						SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: You're being transferred to the fire department. What's your emergency?"); 
						Player911Type[playerid] = 2;
					}
					else SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: Repeat that, please."); 
				}
				case 1: //Police input;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "Please input actual text."); 
						
					format(Player911Text[playerid][1], 128, "%s", text);
					
					SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: What's your location?"); 
					Player911Type[playerid] = 911; 
				}
				case 911: //Police;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "Please input actual text."); 
						
					format(Player911Text[playerid][2], 128, "%s", text);
					SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: Police units were dispatched."); 
					
					Send911Message(playerid, 911); 
				}
				case 2: //Medic input;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "Please input actual text."); 
						
					format(Player911Text[playerid][1], 128, "%s", text);
					
					SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: What's your location?"); 
					Player911Type[playerid] = 811; 
				}
				case 811: // Medic;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "Please input actual text."); 
						
					format(Player911Text[playerid][2], 128, "%s", text);
					SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: Medical units were dispatched."); 
					
					Send911Message(playerid, 811); 
				}
			}
		}
		else
		{
			if(strlen(text) > 87)
			{
				format(string, sizeof(string), "%s says (phone): %.87s...", ReturnName(playerid, 0), text); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				format(string, sizeof(string), "%s says (phone): ... %s", ReturnName(playerid, 0), text[87]); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			}
			else
			{
				format(string, sizeof(string), "%s says (phone): %s", ReturnName(playerid, 0), text); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			}
		}
		return 0; 
	}
	
	if (strlen(text) > 99)
	{
		format (string, sizeof(string), "%s says: %.99s...", ReturnName(playerid, 0), text);
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				
		format (string, sizeof(string), "%s says: ... %s", ReturnName(playerid, 0), text[99]); 
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				
	}
	else 
	{	
		format (string, sizeof(string), "%s says: %s", ReturnName(playerid, 0), text);
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
	
	return 0;
}

public OnPlayerUpdate(playerid)
{
	if(PlayerInfo[playerid][pAdminDuty])
		SetPlayerHealth(playerid, 250);
		
	PlayerInfo[playerid][pPauseCheck] = GetTickCount(); 
	
	new
		string[128];
		
	if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
	{
		format(string, sizeof(string), "(( Has been injured %d times, /damages %d for more information. ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, string, COLOR_RED, 30.0, 2500); 
		
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	}
	else if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD)
	{
		SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD ))", COLOR_RED, 30.0, 2500); 
	}
	
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][pLoggedin] == true)
	{
		printf("Player [%s] sent command: %s", ReturnName(playerid), cmdtext);
		return 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You need to be logged in to use commands.");
		printf("Player [%s] tried to send command: %s (During login, denied access)", ReturnName(playerid), cmdtext);
		return 0;
	}
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		if(strlen(cmdtext) > 28) // Preventing long bad commands from returning default message;
			SendServerMessage(playerid, "Sorry, that command doesn't exist. Use /help if you need assistance."); 
			
		else
			SendServerMessage(playerid, "Sorry, the command \"%s\" doesn't exist. Use /help if you need assistance.", cmdtext);
	}
	else return 1;
	return 1;
}

/*public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    // Check if it moved far	
    if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 50)
    {
        // Reject the update
		SendClientMessageToAllEx(COLOR_RED, "OnUnoccupiedVehicleUpdate called for Vehicle ID %i.", vehicleid);
        return 0;
    }
 
    return 1;
}*/

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(!VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleEngineStatus])
			SendClientMessage(playerid, COLOR_DARKGREEN, "The engine is off. (/engine)");
	
		if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleOwnerDBID] == PlayerInfo[playerid][pDBID])
			SendClientMessageEx(playerid, COLOR_WHITE, "Welcome to your %s.", ReturnVehicleName(GetPlayerVehicleID(playerid)));
			
		for(new i = 0; i < sizeof dmv_vehicles; i++) if(GetPlayerVehicleID(playerid) == dmv_vehicles[i])
			SendServerMessage(playerid, "You're inside a DMV vehicle. Use /licenseexam to start taking your test."); 
	}
	
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleXMROn])
		{
			PlayAudioStreamForPlayer(playerid, VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleXMRURL]);
		}
	}
	
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT)
	{
		StopAudioStreamForPlayer(playerid); 
	}
	
	if(oldstate == PLAYER_STATE_DRIVER)
	{
		if(DealershipPlayerCar[playerid] != INVALID_VEHICLE_ID)
		{
			if(IsValidVehicle(DealershipPlayerCar[playerid]) && !VehicleInfo[DealershipPlayerCar[playerid]][eVehicleDBID])
			{
				DestroyVehicle(DealershipPlayerCar[playerid]); 
			}
			
			if(!PlayerPurchasingVehicle[playerid])
				ResetDealershipVars(playerid); 
		}
		
		if(PlayerTakingLicense[playerid])
			StopDriverstest(playerid);
	}
	
	return 1; 
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger && VehicleInfo[vehicleid][eVehicleFaction] && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
	{
		if(!playerTextdraw[playerid])
		{
			playerVehicleTextdraw[playerid] = CreateDynamic3DTextLabel("You can't enter this. (Faction-vehicle)", COLOR_WHITE, 0.0, 0.0, 0.0, 10.0,  vehicleid, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid); 
			SetTimerEx("OnVehicleTextdraw", 4000, false, "i", playerid); 
			
			playerTextdraw[playerid] = true;
		}
		
		return ClearAnimations(playerid);
	}
	
	if(!ispassenger)
	{
		for(new i = 0; i < sizeof dmv_vehicles; i++) if(vehicleid == dmv_vehicles[i])
		{
			if(PlayerInfo[playerid][pDriversLicense])
			{
				SendErrorMessage(playerid, "You already have a driver's license.");
				return ClearAnimations(playerid);
			}
		}
	}
	
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(PlayerInfo[playerid][pEditingObject])
	{
		switch(PlayerInfo[playerid][pEditingObject])
		{
			case 1:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					DestroyDynamicObject(PlayerInfo[playerid][pAddObject]); 
					PlayerInfo[playerid][pEditingObject] = 0;
						
					SendServerMessage(playerid, "You're no longer buying a boombox."); 
					return 1;
				}
					
				if(response == EDIT_RESPONSE_FINAL)
				{
					ConfirmDialog(playerid, "Confirmation", "Are you sure you want to buy this?\nPrice: $1,000", "OnPropertyBoombox", IsPlayerInProperty(playerid), x, y, z, rx, ry, rz); 
					return 1;
				}
			}
			
			case 2:
			{
				new 
					id = IsPlayerInProperty(playerid)
				;
			
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][pEditingObject] = 0; 
		
					SetDynamicObjectPos(PropertyInfo[id][ePropertyBoomboxObject], PropertyInfo[id][ePropertyBoomboxPos][0], PropertyInfo[id][ePropertyBoomboxPos][1], PropertyInfo[id][ePropertyBoomboxPos][2]);
					SetDynamicObjectRot(PropertyInfo[id][ePropertyBoomboxObject], PropertyInfo[id][ePropertyBoomboxRot][0], PropertyInfo[id][ePropertyBoomboxRot][1], PropertyInfo[id][ePropertyBoomboxRot][2]);
		
					SendServerMessage(playerid, "You cancelled."); 
					return 1;
				}
				
				if(response == EDIT_RESPONSE_FINAL)
				{
					PlayerInfo[playerid][pEditingObject] = 0;
					
					SetDynamicObjectPos(PropertyInfo[id][ePropertyBoomboxObject], x, y, z);
					SetDynamicObjectRot(PropertyInfo[id][ePropertyBoomboxObject], rx, ry, rz); 
					
					PropertyInfo[id][ePropertyBoomboxPos][0] = x;
					PropertyInfo[id][ePropertyBoomboxPos][1] = y;
					PropertyInfo[id][ePropertyBoomboxPos][2] = z;
					
					PropertyInfo[id][ePropertyBoomboxRot][0] = rx;
					PropertyInfo[id][ePropertyBoomboxRot][1] = ry;
					PropertyInfo[id][ePropertyBoomboxRot][2] = rz;
					
					SaveProperty(id);
					SendServerMessage(playerid, "You edited your properties' boombox position."); 
					return 1;
				}
			}
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(HasNoEngine(vehicleid))
		ToggleVehicleEngine(vehicleid, true);
		
	printf("[DEBUG] Vehicle ID %i was respawned.", vehicleid);
	return 1;
}

function:RefreshCharacters(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Your character list has been refreshed."); 
	
	new 
		fetchChars[140];
	
	mysql_format(ourConnection, fetchChars, sizeof(fetchChars), "SELECT char_name, char_dbid FROM characters WHERE master_dbid = %i LIMIT 4", e_pAccountData[playerid][mDBID]);
	mysql_pquery(ourConnection, fetchChars, "DB_ListCharacters", "i", playerid);
	
	return 1; 
}

function:Query_CreateCharacter(playerid)
{
	if(cache_num_rows())
	{
		return SendClientMessage(playerid, COLOR_RED, "[ERROR]: That character already exists. Please try again."); 
	}
	else
	{
		new
			string[128]
		;
		
		for (new i = 0; i < 16; i++){SendClientMessage(playerid, -1, " "); }
		
		format (string, sizeof(string), "Your new characters name will be: {145F0B}%s", playerCharactersName[playerid]);
		SendClientMessage(playerid, -1, string); 
		
		SendClientMessage(playerid, -1, " "); 
		SendClientMessage(playerid, -1, "The next steps will require a background for your new character.");
		SendClientMessage(playerid, -1, "Please provide your characters date of birth. The format: {145F0B}08/12/2017");
		
		playerCharacterStep[playerid] = 2; 
	}
	return 1;
}

function:SaveCharacterPos(playerid)
{
	new thread[256]; 
	
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
	
	mysql_format(ourConnection, thread, sizeof(thread), "UPDATE characters SET pLastPosX = %f, pLastPosY = %f, pLastPosZ = %f, pLastInterior = %i, pLastWorld = %i, pInProperty = %i, pInBusiness = %i WHERE char_dbid = %i",
	
		PlayerInfo[playerid][pLastPos][0],
		PlayerInfo[playerid][pLastPos][1],
		PlayerInfo[playerid][pLastPos][2],
		GetPlayerInterior(playerid),
		GetPlayerVirtualWorld(playerid),
		PlayerInfo[playerid][pInsideProperty],
		PlayerInfo[playerid][pInsideBusiness],
		PlayerInfo[playerid][pDBID]);
		
	return mysql_tquery(ourConnection, thread);
}

function:SaveCharacter(playerid)
{
	new query[320];
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE masters SET forum_name = '%e', active_ip = '%e' WHERE acc_dbid = %i",	
		e_pAccountData[playerid][mForumName],
		PlayerInfo[playerid][pActiveIP],
		e_pAccountData[playerid][mDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pAdmin = %i, pLastSkin = %i, pLevel = %i, pEXP = %i, pMoney = %i, pBank = %i, pPaycheck = %i, pPhone = %i, pLastOnline = '%e', pLastOnlineTime = %i, pAdminjailed = %i, pAdminjailTime = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][pAdmin],
		PlayerInfo[playerid][pLastSkin],
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pEXP],
		PlayerInfo[playerid][pMoney],
		PlayerInfo[playerid][pBank],
		PlayerInfo[playerid][pPaycheck],
		PlayerInfo[playerid][pPhone],
		ReturnDate(),
		PlayerInfo[playerid][pLastOnlineTime],
		PlayerInfo[playerid][pAdminjailed],
		PlayerInfo[playerid][pAdminjailTime],
		PlayerInfo[playerid][pDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pFaction = %i, pFactionRank = %i, pVehicleSpawned = %i, pVehicleSpawnedID = %i, pTimeplayed = %i, pMaskID = %i, pMaskIDEx = %i, pOfflinejailed = 0 WHERE char_dbid = %i", 
		PlayerInfo[playerid][pFaction], 
		PlayerInfo[playerid][pFactionRank], 
		PlayerInfo[playerid][pVehicleSpawned],
		PlayerInfo[playerid][pVehicleSpawnedID],
		PlayerInfo[playerid][pTimeplayed],
		PlayerInfo[playerid][pMaskID][0],
		PlayerInfo[playerid][pMaskID][1],
		PlayerInfo[playerid][pDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pHasRadio = %i, pMainSlot = %i, pGascan = %i, pSpawnPoint = %i, pSpawnPointHouse = %i, pWeaponsLicense = %i, pDriversLicense = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][pHasRadio],
		PlayerInfo[playerid][pMainSlot],
		PlayerInfo[playerid][pGascan],
		PlayerInfo[playerid][pSpawnPoint],
		PlayerInfo[playerid][pSpawnPointHouse],
		PlayerInfo[playerid][pWeaponsLicense],
		PlayerInfo[playerid][pDriversLicense],
		PlayerInfo[playerid][pDBID]);
	mysql_tquery(ourConnection, query);
	
	for(new i = 1; i < 3; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pRadio%i = %i WHERE char_dbid = %i", 
			i, 
			PlayerInfo[playerid][pRadio][i],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, query);
	}
	
	for(new i = 0; i < 4; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pWeapons%d = %i, pWeaponsAmmo%d = %i WHERE char_dbid = %i",
			i,
			PlayerInfo[playerid][pWeapons][i],
			i,
			PlayerInfo[playerid][pWeaponsAmmo][i],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, query);
	}
	
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pOwnedVehicles%d = %i WHERE char_dbid = %i", i, PlayerInfo[playerid][pOwnedVehicles][i], PlayerInfo[playerid][pDBID]);
		mysql_tquery(ourConnection, query);
	}
	
	return 1;
}

//General commands:
CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");
	
	SendClientMessage(playerid, COLOR_GRAD1, "[ACCOUNT] /stats, /admins, /report, /o(oc) /relog, /pay, /isafk");
	SendClientMessage(playerid, COLOR_GRAD2, "[GENERAL] /time, /rcp, /weapons, /leavegun, /grabgun, /enter, /exit, /mask");
	SendClientMessage(playerid, COLOR_GRAD1, "[GENERAL] /buy, /setchannel, /setslot, /radio, /radiolow, /damages, /acceptdeath,");
	SendClientMessage(playerid, COLOR_GRAD2, "[GENERAL] /respawnme, /setspawn, /levelup, /bank, /withdraw, /balance, /ammuhelp,"); 
	SendClientMessage(playerid, COLOR_GRAD1, "[GENERAL] /license, /licenseexam, /unimpound, /fixr");
	SendClientMessage(playerid, COLOR_GRAD1, "[VEHICLES] /v(ehicle), /engine, /unscramble, /check, /place, /setstation, /refill"); 
	SendClientMessage(playerid, COLOR_GRAD2, "[EMOTES] /me, /do, /ame, /my, /amy, /shout, /low, /b, /pm"); 
	SendClientMessage(playerid, COLOR_GRAD1, "[PHONE] /call, /hangup, /pickup, /sms, /loudspeaker"); 
	SendClientMessage(playerid, COLOR_GRAD2, "[PROPERTY] /buyproperty, /lock, /check, /place, /placepos, /setstation, /property");
	SendClientMessage(playerid, COLOR_GRAD1, "[BUSINESS] /buybiz, /bizinfo, /bizfee, /bizcash, /sellbiz"); 
	SendClientMessage(playerid, COLOR_GRAD2, "[FACTION] /factionhelp, /factions, /f, /togfam, /factionon, /accept");
	
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");
	return 1; 
}

CMD:stats(playerid, params[])
{
	new playerb;
	
	if(PlayerInfo[playerid][pAdmin])
	{
		if (sscanf(params, "I(-1)", playerb))
			return 1; 
			
		if(playerb == -1)
		{
			return ShowCharacterStats(playerid, playerid);
		}
		else
		{
			if(!IsPlayerConnected(playerb))
				return SendErrorMessage(playerid, "The player you specified isn't connected.");
				
			if(e_pAccountData[playerid][mLoggedin] == false)
				return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
				
			ShowCharacterStats(playerb, playerid); 
		}
	}
	else return ShowCharacterStats(playerid, playerid);
	return 1;
}

CMD:admins(playerid, params[])
{
	new bool:adminOn = false;
	
	foreach (new i : Player)
	{
		if (PlayerInfo[playerid][pAdmin]) adminOn = true;
	}
	
	if(adminOn == true)
	{
		SendClientMessage(playerid, COLOR_GREY, "Admins Online:");
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin])
			{
				if(PlayerInfo[i][pAdminDuty])
				{
					SendClientMessageEx(playerid, COLOR_DARKGREEN, "(Level: %d) %s (%s) - On Duty: Yes", PlayerInfo[i][pAdmin], ReturnName(i), e_pAccountData[i][mForumName]);
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "(Level: %d) %s (%s) - On Duty: No", PlayerInfo[i][pAdmin], ReturnName(i), e_pAccountData[i][mForumName]);
			}
		}
	}
	else
	{
		return SendClientMessage(playerid, COLOR_GREY, "There are no administrators' online.");
	}

	return 1;
}

CMD:re(playerid, params[])return cmd_report(playerid, params);
CMD:report(playerid, params[])
{
	if(isnull(params) || strlen(params) < 3)
		return SendUsageMessage(playerid, "/re(port) [text]"); 
	
	new 
		showString[350]
	;
	
	format(showString, sizeof(showString), "{FFFFFF}Are you sure you want to send this report?\n\n{F81414}Remember that, reporting actions which do not happen at the moment is extremely difficult for online admins to handle on the spot, since no proof is presented to them.\n{FFFFFF}Report: %s", params);
	ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_MSGBOX, "Confirmation", showString, "Yes", "No"); 
	
	format(playerReport[playerid], 128, "%s", params);
	return 1;
}

CMD:o(playerid, params[]) return cmd_ooc(playerid, params);
CMD:ooc(playerid, params[])
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/ooc [text]"); 
		
	if(!oocEnabled && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "OOC chat was disabled by an admin."); 
		
	if(PlayerInfo[playerid][pAdmin] && strcmp(e_pAccountData[playerid][mForumName], "Null"))
		SendClientMessageToAllEx(COLOR_SAMP, "[OOC] %s (%s): %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params); 
		
	else SendClientMessageToAllEx(COLOR_SAMP, "[OOC] %s: %s", ReturnName(playerid), params);
	return 1;
}

CMD:relog(playerid, params[])
{
	if(gettime() - PlayerInfo[playerid][pLastDamagetime] < 120)
		return SendServerMessage(playerid, "You took damage recently and can't relog yet."); 
		
	if(PlayerInfo[playerid][pRelogging])
		return SendErrorMessage(playerid, "You're in the middle of relogging."); 
		
	new
		str[128],
		Float:x,
		Float:y,
		Float:z
	;
	
	GetPlayerPos(playerid, x, y, z);

	format(str, sizeof(str), "%s initiated a relog.", ReturnName(playerid));
	SendAdminMessage(1, str);
	
	PlayerInfo[playerid][pRelogging] = true; 
	PlayerInfo[playerid][pRelogCount] = 1; 
	
	PlayerInfo[playerid][pRelogTD] = Create3DTextLabel("(( |------ ))\nRELOGGING", COLOR_DARKGREEN, x, y, z, 20.0, GetPlayerVirtualWorld(playerid), 1);
	Attach3DTextLabelToPlayer(PlayerInfo[playerid][pRelogTD], playerid, 0.0, 0.0, 0.1); 
	
	PlayerInfo[playerid][pRelogTimer] = SetTimerEx("OnPlayerRelog", 3000, true, "i", playerid); 
	
	TogglePlayerControllable(playerid, 0); 
	SendServerMessage(playerid, "To circumvent abuse, you will be relogged shortly."); 
	return 1;
}

CMD:pay(playerid, params[])
{
	new playerb, amount, emote[90], str[128]; 

	if(sscanf(params, "uiS('None')[90]", playerb, amount, emote))
		return SendUsageMessage(playerid, "/pay [playerid OR name] [amount] [emote (Optional)]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player."); 
		
	if(amount > PlayerInfo[playerid][pMoney])
		return SendErrorMessage(playerid, "You don't have that amount of money.");
		
	if(gettime() - playerLastpay[playerid] < 3)
		return SendServerMessage(playerid, "Please wait before paying again.");
		
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(playerb, 1052, 0.0, 0.0, 0.0);
	playerLastpay[playerid] = gettime(); 
	
	SendClientMessageEx(playerid, COLOR_GREY, " You have sent %s, $%s.", ReturnName(playerb, 0), MoneyFormat(amount)); 
	SendClientMessageEx(playerb, COLOR_GREY, " You have received $%s from %s.", MoneyFormat(amount), ReturnName(playerid, 0)); 
	
	if(!strcmp(emote, "None"))
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s takes out some cash, and hands it to %s.", ReturnName(playerid, 0), ReturnName(playerb, 0)); 

	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s %s (( Cash exchange ))", ReturnName(playerid, 0), emote, ReturnName(playerb, 0));
	
	if(PlayerInfo[playerid][pLevel] <= 3 && PlayerInfo[playerb][pLevel] <= 3 || amount >= 50000)
	{
		format(str, sizeof(str), "%s has paid $%s to %s.", ReturnName(playerid), MoneyFormat(amount), ReturnName(playerb)); 
		SendAdminMessage(1, str);
	}
	
	GiveMoney(playerid, -amount); GiveMoney(playerb, amount);
	return 1;
}

CMD:isafk(playerid, params[])
{
	new 
		playerb;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/isafk [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");
	
	if(GetTickCount() > (PlayerInfo[playerb][pPauseCheck]+2000))
		SendClientMessageEx(playerid, COLOR_GREY, "Player %s has been paused for %i seconds!", ReturnName(playerb), PlayerInfo[playerb][pPauseTime]);
		
	else SendClientMessageEx(playerid, COLOR_GREY, "Player %s is not paused.", ReturnName(playerb)); 

	return 1;
}

CMD:id(playerid, params[]) // This command was a hefty test. Can be commented out if need be. 
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/id [playerid OR name]"); 
		
	new
		bool:inputID = false,
		playerb
	;
		
	for(new ix = 0, j = strlen(params); ix < j; ix++)
	{
		if (params[ix] > '9' || params[ix] < '0')
		{
			inputID = false; 
		}
		else inputID = true;
	}
	
	if(inputID)
	{
		playerb = strval(params);
		
		if(!IsPlayerConnected(playerb))
			return SendClientMessage(playerid, COLOR_RED, "Player not found."); 
			
		SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s | Level: %i", playerb, ReturnName(playerb), PlayerInfo[playerb][pLevel]); 
	}
	else
	{
		new
			bool:matchFound = false,
			bool:fullName = false,
			countMatches = 0,
			matchesFound[6],
			string[128]
		;
		
		for(new cc = 0; cc < 5; cc++) { matchesFound[cc] = INVALID_PLAYER_ID; }
		
		for(new i = 0, j = strlen(params); i < j; i++)
		{
			if (params[i] != '_')
			{
				fullName = false; 
			}
			else
			{
				fullName = true; 
			}
		}
		
		if(fullName)
		{
			foreach(new b : Player)
			{
				if(strfind(ReturnName(b), params, true) != -1)
				{
					SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s | Level: %i", b, ReturnName(b), PlayerInfo[b][pLevel]); 
				}
				else return SendClientMessage(playerid, COLOR_RED, "Player not found."); 
			}
		}
		else
		{
			for(new a = 0; a < MAX_PLAYERS; a++)
			{
				if(IsPlayerConnected(a))
				{
					if(strfind(ReturnName(a, 0), params, true) != -1)
					{
						matchFound = true;
						countMatches ++; 
					}
				}
			}
		
			if(matchFound)
			{
				for(new f = 0, g = GetPlayerPoolSize(), t = 0; f <= g; f++)
				{		
					if(IsPlayerConnected(f) && strfind(ReturnName(f, 0), params, true) != -1)
					{
						matchesFound[t] = f;
						t++; 
						
						if(t >= 5) break; 
					}
				}
			
				if(countMatches != 0 && countMatches > 1)
				{
					for(new l = 0; l < sizeof(matchesFound); l++)
					{
						if(matchesFound[l] == INVALID_PLAYER_ID)
							continue; 
							
						format(string, sizeof(string), "%s(ID: %i) %s, ", string, matchesFound[l], ReturnName(matchesFound[l])); 
											
						if(l % 3 == 0 && l != 0 || l == 5-1)
						{
							SendClientMessage(playerid, COLOR_GREY, string);
							string[0] = 0;
						}
					}
				}
				else if(countMatches == 1)
				{
					SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s | Level: %i", matchesFound[0], ReturnName(matchesFound[0]), PlayerInfo[matchesFound[0]][pLevel]); 
				}
			}
			else return SendClientMessage(playerid, COLOR_RED, "Player not found."); 
		}
	}
	return 1; 
}

CMD:mask(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 3 && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You aren't level 3 or higher."); 
		
	if(!PlayerInfo[playerid][pHasMask] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You don't have a mask."); 
	
	if(!PlayerInfo[playerid][pMasked])
	{
		foreach(new i : Player)
		{
			if(!PlayerInfo[i][pAdminDuty])
				ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
		
		PlayerInfo[playerid][pMasked] = true;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW ON", 3000, 5); 
	}
	else
	{
		foreach(new i : Player)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}
		
		PlayerInfo[playerid][pMasked] = false;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW OFF", 3000, 5); 
	}
		
	return 1;
}

CMD:buy(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid)
	;
	
	if(!IsPlayerInBusiness(playerid))
		return SendErrorMessage(playerid, "You aren't in a business.");
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_GENERAL)
		return SendErrorMessage(playerid, "You aren't in a store."); 
	
	ShowBuylist(playerid); 
	return 1;
}

CMD:setchannel(playerid, params[])
{
	new 
		slot, 
		channel
	;
	
	if(sscanf(params, "ii", channel, slot))
		return SendUsageMessage(playerid, "/setchannel [channel] [slot]"); 
		
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "You don't have a radio."); 
		
	if(slot > 2 || slot < 1)
		return SendErrorMessage(playerid, "You specified an invalid slot. (1-2)");
		
	if(channel < 1 || channel > 1000000)
		return SendErrorMessage(playerid, "You specified an invalid channel. (1-1000000)"); 
		
	for(new i = 1; i < 3; i++)
	{
		if(PlayerInfo[i][pRadio][i] == channel)
		{
			SendErrorMessage(playerid, "Your radio slot %i already supports channel %i.", i, channel);
			return 1;
		}
	}
	
	if(channel == 911)
	{
		if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
			return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You're not authorized to use this channel."); 
	}
	
	PlayerInfo[playerid][pRadio][slot] = channel;
	
	SendClientMessageEx(playerid, COLOR_YELLOWEX, "You're now listening to channel %i under slot %i.", channel, slot);
	SaveCharacter(playerid); 
	return 1;
}

CMD:setslot(playerid, params[])
{
	new
		slot
	;
	
	if(sscanf(params, "i", slot))
		return SendUsageMessage(playerid, "/setslot [slot id]");
		
	if(!PlayerInfo[playerid][pHasRadio])
		return SendUsageMessage(playerid, "You don't own a radio.");
		
	if(slot > 2 || slot < 1)
		return SendErrorMessage(playerid, "You specified an invalid slot. (1-2)");
		
	PlayerInfo[playerid][pMainSlot] = slot;
		
	SendClientMessageEx(playerid, COLOR_YELLOWEX, "Your local radio slot is now %i.", slot); 
	SaveCharacter(playerid);
	return 1;
}

CMD:r(playerid, params[]) return cmd_radio(playerid, params);
CMD:radio(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendUsageMessage(playerid, "You don't own a radio.");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "Your local radio slot isn't set to a channel."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r [text], /rlow [text], /r[ch] [text], /r[ch]low [text]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 20.0, posx,posy,posz))
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "(Radio) %s says: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:rlow(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendUsageMessage(playerid, "You don't own a radio.");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "Your local radio slot isn't set to a channel."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/rlow [text]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "(Radio) %s says[low]: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:r2(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendUsageMessage(playerid, "You don't own a radio.");

	new
		channel
	;
		
	channel = PlayerInfo[playerid][pRadio][2]; 
	
	if(!PlayerInfo[playerid][pRadio][2])
		return SendErrorMessage(playerid, "Your local radio slot isn't set to a channel."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r2 [text]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 20.0, posx,posy,posz))
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "(Radio) %s says: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:r2low(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendUsageMessage(playerid, "You don't own a radio.");

	new
		channel
	;
		
	channel = PlayerInfo[playerid][pRadio][2]; 
	
	if(!PlayerInfo[playerid][pRadio][2])
		return SendErrorMessage(playerid, "Your local radio slot isn't set to a channel."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r2low [text]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s says: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 6.0, posx,posy,posz))
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "(Radio) %s says[low]: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:refill(playerid, params[])
{
	if(!PlayerInfo[playerid][pGascan])
		return SendErrorMessage(playerid, "You don't have any gascans."); 
		
	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You can't be in a vehicle.");
		
	if(GetNearestVehicle(playerid) == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "You aren't near a vehicle."); 
		
	if(playerRefillingVehicle[playerid])
		return SendErrorMessage(playerid, "You're already refilling a vehicle."); 
		
	new 
		vehicleid = GetNearestVehicle(playerid),
		Float:x,
		Float:y,
		Float:z,
		Float:vx,
		Float:vy,
		Float:vz
	;
	
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_PETROLCAP, x, y, z); 
	GetVehiclePos(vehicleid, vx, vy, vz); 
	
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]); 
			
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
		return SendErrorMessage(playerid, "You aren't near the vehicles gas cap.");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] > 50)
		return SendErrorMessage(playerid, "This vehicle doesn't need fuel."); 
		
	SendClientMessage(playerid, COLOR_ACTION, "You're starting to refill the vehicle.");
	SendClientMessage(playerid, COLOR_ACTION, "If you, or the vehicle moves then this process will be interrupted."); 
	
	VehicleInfo[vehicleid][eVehicleRefillDisplay] = Create3DTextLabel("(( |------ ))\nREFILLING VEHICLE", COLOR_DARKGREEN, x, y, z, 25.0, 0, 1);
	Attach3DTextLabelToVehicle(VehicleInfo[vehicleid][eVehicleRefillDisplay], vehicleid, -0.0, -0.0, -0.0); 

	PlayerInfo[playerid][pGascan]--; 
	VehicleInfo[vehicleid][eVehicleRefillCount] = 1;
	
	playerRefillingVehicle[playerid] = true; 
	playerRefillTimer[playerid] = SetTimerEx("OnGascanRefill", 4500, true, "iifff", playerid, vehicleid, vx, vy, vz);
	return 1;
}

CMD:damages(playerid, params[])
{
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/damages [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))	
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		ShowPlayerDamages(playerb, playerid, 1); 
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "You aren't near that player.");
		
		if(GetPlayerTeam(playerb) == PLAYER_STATE_ALIVE)
			return SendErrorMessage(playerid, "That player isn't brutally wounded.");
			
		ShowPlayerDamages(playerb, playerid, 0); 
	}
	return 1;
}
 
CMD:acceptdeath(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "You aren't brutally wounded.");
		
	CallLocalFunction("OnPlayerDead", "iii", playerid, INVALID_PLAYER_ID, -1, 0); 
	return 1;
}

CMD:respawnme(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_STATE_DEAD)
		return SendErrorMessage(playerid, "You aren't dead right now.");
		
	if(gettime() - PlayerInfo[playerid][pRespawnTime] < 60)
		return SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> You've only been dead for %i seconds. You need to wait at least 60 sec to respawn.", gettime() - PlayerInfo[playerid][pRespawnTime]); 

	PlayerInfo[playerid][pRespawnTime] = 0;
	SetPlayerChatBubble(playerid, "Respawned", COLOR_WHITE, 20.0, 1500);
	
	TogglePlayerControllable(playerid, 1); 
	SetPlayerHealth(playerid, 0); 
 
	return 1;
}

CMD:setspawn(playerid, params[])
{
	new 
		id;

	if(sscanf(params, "i", id))
	{
		SendUsageMessage(playerid, "/setspawn [spawn id]");
		SendClientMessage(playerid, COLOR_WHITE, "1. Airport, 2. Property, 3. Faction");
		return 1;
	}
	
	if(id > 3 || id < 1)
		return SendErrorMessage(playerid, "You specified an invalid ID."); 
		
	switch(id)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pSpawnPoint] == 0)
				return SendErrorMessage(playerid, "This is already your spawn point."); 
				
			PlayerInfo[playerid][pSpawnPoint] = 0; 
			SendServerMessage(playerid, "You will now spawn at the airport."); 
		}
		case 2:
		{		
			if(!CountPlayerProperties(playerid))
				return SendErrorMessage(playerid, "You don't own any properties."); 
				
			new
				str[128]
			; 
			
			for(new i = 1, j = 0; i < MAX_PROPERTY; i++)
			{
				if(PropertyInfo[i][ePropertyOwnerDBID] != PlayerInfo[playerid][pDBID])
					continue;
					
				playerHouseSelect[playerid][j] = i; 
				j++;
				
				if(j >= 3)
					break; 
			}
			 
			for(new c = 0; c < 3; c++)
			{
				if(playerHouseSelect[playerid][c])
				{
					format(str, sizeof(str), "%sHouse %i\n", str, c); 
				}
			}
			
			ShowPlayerDialog(playerid, DIALOG_SELECT_HOUSE, DIALOG_STYLE_LIST, "Select A Property:", str, "Select", "<<"); 
		}
		case 3:
		{
			if(PlayerInfo[playerid][pSpawnPoint] == 2)
				return SendErrorMessage(playerid, "This is already your spawn point.");
		
			if(!PlayerInfo[playerid][pFaction])
				return SendErrorMessage(playerid, "You aren't in any faction.");
				
			PlayerInfo[playerid][pSpawnPoint] = 2;
			SendServerMessage(playerid, "You will now spawn at your faction."); 
		}
	}

	return 1;
}

CMD:levelup(playerid, params[])
{
	new
		exp_count,
		str[128]
	;
	
	exp_count = ((PlayerInfo[playerid][pLevel]) * 4 + 2); 
	
	if(PlayerInfo[playerid][pEXP] < exp_count)
	{
		SendServerMessage(playerid, "You don't have enough EXP (%i) to level up.", exp_count); 
		return 1; 
	}
	
	PlayerInfo[playerid][pLevel]++; 
	PlayerInfo[playerid][pEXP] = 0; 
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]); 
	
	format(str, sizeof(str), "~g~Leveled Up~n~~w~You leveled up to level %i", PlayerInfo[playerid][pLevel]);
	GameTextForPlayer(playerid, str, 5000, 1);

	SaveCharacter(playerid); 
	return 1;
}

CMD:bank(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid),
		amount
	;
		
	if(!id)
		return SendErrorMessage(playerid, "You aren't in a business.");
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "You aren't inside a bank."); 
		
	if(sscanf(params, "d", amount))
		return SendUsageMessage(playerid, "/bank [deposit amount]");
		
	if(amount < 1 || amount > PlayerInfo[playerid][pMoney])
		return SendErrorMessage(playerid, "You can't deposit that amount."); 
		
	PlayerInfo[playerid][pBank]+= amount;
	GiveMoney(playerid, -amount); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "You have deposited $%s into your account, Total:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
	SaveCharacter(playerid);
	return 1; 
}

CMD:withdraw(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid),
		amount
	;
		
	if(!id)
		return SendErrorMessage(playerid, "You aren't in a business.");
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_BANK && BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_GENERAL)
		return SendErrorMessage(playerid, "You can't do this inside this business."); 
		
	if(sscanf(params, "i", amount))
		return SendUsageMessage(playerid, "/withdraw [amount]");
		
	if(amount < 1 || amount > PlayerInfo[playerid][pBank])
		return SendErrorMessage(playerid, "You can't withdraw that amount."); 
		
	PlayerInfo[playerid][pBank]-= amount;
	GiveMoney(playerid, amount);
	
	SendClientMessageEx(playerid, COLOR_ACTION, "You have withdrawn $%s from your account, Total:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
	SaveCharacter(playerid);
	return 1;
}

CMD:balance(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid)
	;
		
	if(!id)
		return SendErrorMessage(playerid, "You aren't in a business.");
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_BANK && BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_GENERAL)
		return SendErrorMessage(playerid, "You can't do this inside this business."); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "You have $%s in your bank and $%s in your paycheck. (%s)", MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]), ReturnDate());	
	return 1;
}

CMD:h(playerid, params[]) return cmd_hangup(playerid, params); 
CMD:hangup(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your cellphone is turned off.");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "You can't use your phone right now."); 
		
	new
		str[128]
	;
		
	if(playerPhone[playerid])
	{
		KillTimer(playerPhone[playerid]); 
		
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] You hung up."); 
		return 1;
	}
	
	if(PlayerInfo[playerid][pPhoneline] == 999 || PlayerInfo[playerid][pPhoneline] == 911)
	{
		for(new i = 0; i < 2; i++) KillTimer(Player911Timer[i][playerid]); 
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] You hung up."); 
		
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
		PlayerInfo[playerid][pCalling] = 0;
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}
		return 1;
	}
	
	if(PlayerInfo[playerid][pPhoneline] == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You aren't in a call or being called."); 
	
	if(PlayerInfo[playerid][pCalling] && PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID)
	{	
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] You hung up."); 
		SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] The call was disconnected."); 
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}
		
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhoneline] = INVALID_PLAYER_ID; 
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0; 
		
		PlayerInfo[playerid][pCalling] = 0; 
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID; 
		printf("call 0");
		return 1;
	}
	
	if(!PlayerInfo[playerid][pCalling] && PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] You hung up."); 
		SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] They hung up."); 
		
		printf("pPhoneline = %i", PlayerInfo[playerid][pPhoneline]);
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			printf("call 1");
		}
		
		if(GetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline]) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline], SPECIAL_ACTION_STOPUSECELLPHONE);
			printf("call 2"); 
		}
		
		format(str, sizeof(str), "* %s puts their phone away.", ReturnName(playerid, 0));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		
		format(str, sizeof(str), "* %s puts their phone away.", ReturnName(PlayerInfo[playerid][pPhoneline], 0));
		SetPlayerChatBubble(PlayerInfo[playerid][pPhoneline], str, COLOR_EMOTE, 20.0, 3000);
		
		PlayerInfo[playerid][pCalling] = 0;
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0;
		
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhoneline] = INVALID_PLAYER_ID;
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
		printf("call 3"); 
		return 1;
	}
	
	return 1;
}

CMD:p(playerid, params[]) return cmd_pickup(playerid, params); 
CMD:pickup(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your cellphone is turned off.");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "You can't use your phone right now."); 

	if(PlayerInfo[playerid][pPhoneline] == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "You aren't being called."); 
		
	if(PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID && !PlayerInfo[playerid][pCalling])
		return SendErrorMessage(playerid, "You're already in a phone call."); 
		
	SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] They picked up. You can talk now by using the chat box.");
	SendClientMessage(playerid, COLOR_WHITE, "HINT: You can talk now by using the chatbox.");	

	PlayerInfo[playerid][pCalling] = 0; 
	PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0;
	
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	KillTimer(playerPhone[playerid]); 
	
	playerPhone[playerid] = 0; playerPhone[ PlayerInfo[playerid][pPhoneline] ] = 0; 
	return 1;
}

CMD:call(playerid, params[])
{
	new
		str[128],
		phone_number,
		playerb = INVALID_PLAYER_ID
	; 
	
	if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "You aren't alive.");
		
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your cellphone is turned off.");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "You can't use your phone right now."); 
		
	if(playerPhone[playerid])
		return SendErrorMessage(playerid, "You can't make a call right now.");
		
	if(sscanf(params, "i", phone_number))
		return SendUsageMessage(playerid, "/call [phone number]"); 
		
	foreach(new i : Player) if(PlayerInfo[i][pPhone] == phone_number){
			playerb = i;
	}
	
	format(str, sizeof(str), "* %s dials a number on their phone.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
	SendClientMessage(playerid, COLOR_EMOTE, str); 
	
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	
	if(phone_number == 911)
	{
		PlayerInfo[playerid][pPhoneline] = 999;
		PlayerInfo[playerid][pCalling] = 1; 
	
		Player911Timer[0][playerid] = SetTimerEx("On911Call", 2000, false, "i", playerid);
		return 1;
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 4500, false, "ii", playerid, 1); 
		return 1;
	}
	
	if(PlayerInfo[playerb][pPhoneOff])
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3000, false, "ii", playerid, 2); 
		return 1;
	}
	
	if(PlayerInfo[playerb][pCalling])
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3000, false, "ii", playerid, 3);
		return 1;
	}
	
	if(PlayerInfo[playerb][pPhoneline] != INVALID_PLAYER_ID)
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3300, false, "ii", playerid, 4);
		return 1;
	}
	
	SendNearbyMessage(playerb, 20.0, COLOR_EMOTE, "* %s's phone begins to ring.", ReturnName(playerid, 0)); 
	SendClientMessageEx(playerb, COLOR_GREY, "[ ! ] To pickup the call, use /pickup. Incoming call from %i.", PlayerInfo[playerid][pPhone]); 
	
	PlayerInfo[playerid][pCalling] = 1; PlayerInfo[playerb][pCalling] = 1;
	
	PlayerInfo[playerid][pPhoneline] = playerb;
	PlayerInfo[playerb][pPhoneline] = playerid; 
	
	playerPhone[playerb] = SetTimerEx("OnSuccessCall", 3000, true, "i", playerid); 
	return 1;
}

CMD:sms(playerid, params[])
{
	new
		text[128],
		str[128],
		phone_number,
		playerb = INVALID_PLAYER_ID
	;
	
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your cellphone is turned off.");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "You can't use your phone right now."); 
		
	if(playerText[playerid])
		return SendClientMessage(playerid, COLOR_WHITE, "Please Wait."); 
		
	if(sscanf(params, "is[128]", phone_number, text))
		return SendUsageMessage(playerid, "/sms [phone number] [text]"); 
		
	foreach(new i : Player) if(PlayerInfo[i][pPhone] == phone_number){
		playerb = i;
	}
	
	SendClientMessage(playerid, COLOR_GREY, "[ ! ] Your text message is being sent.");

	format(str, sizeof(str), "* %s takes out their cellphone.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000); 
	
	if(playerb == INVALID_PLAYER_ID)
	{
		playerText[playerid] = SetTimerEx("OnPhoneSMS", 3000, false, "ii", playerid, 1); 
		return 1;
	}
	
	if(PlayerInfo[playerb][pPhoneOff])
	{
		playerText[playerid] = SetTimerEx("OnPhoneSMS", 3000, false, "ii", playerid, 2);
		return 1;
	}
		
	playerText[playerid] = SetTimerEx("OnPhoneSMS", 1500, false, "iiis", playerid, 3, playerb, text); 
	return 1;
}

CMD:loudspeaker(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "Your cellphone is turned off.");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "You can't use your phone right now."); 
		
	if(PlayerInfo[playerid][pPhonespeaker])
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s turns their phones loudspeaker off.", ReturnName(playerid, 0));
		PlayerInfo[playerid][pPhonespeaker] = false;
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s turns their phones loudspeaker on.", ReturnName(playerid, 0));
		PlayerInfo[playerid][pPhonespeaker] = true;
	}
	
	return 1; 
}

CMD:ammuhelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________** AMMUNATION HELP **______________");
	SendClientMessage(playerid, COLOR_WHITE, "/buygun, /buyammo"); 
	return 1;
}

CMD:buygun(playerid, params[])
{
	new id = IsPlayerInBusiness(playerid), a_str[60], b_str[60];
	new totalPrice, ammo, str[128];
	
	if(!IsPlayerInBusiness(playerid))	
		return SendErrorMessage(playerid, "You aren't in a business."); 
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_AMMUNATION)
		return SendErrorMessage(playerid, "You aren't in an ammunation."); 
		
	if(!PlayerInfo[playerid][pWeaponsLicense])
		return SendUnauthMessage(playerid); 
		
	if(sscanf(params, "s[60]S()[60]", a_str, b_str))
	{
		SendUsageMessage(playerid, "/buygun [weapon] [ammo]"); 
		SendClientMessage(playerid, COLOR_GRAD2, "[ colt: $12,500; ammo: $25 ] [ deagle: $17,500; ammo: $38 ] [ shotgun: $17,500; ammo: $38 ]");
		SendClientMessage(playerid, COLOR_GRAD2, "[ rifle: $25,000; ammo: $100 ] [ parachute: $1,250; ammo: $1,250 ] [ armor: $2,000; ammo: $2,000 ]");
		return 1;
	}
	
	if(!strcmp(a_str, "colt"))
	{
		if(sscanf(b_str, "i", ammo))
			return SendUsageMessage(playerid, "/buygun colt [ammo]"); 
			
		if(ammo < 1 || ammo > 32767)
			return SendErrorMessage(playerid, "Invalid Ammo.");  
			
		totalPrice = ammo * 25 + 12500; 
		
		format(str, sizeof(str), "Are you sure you want to purchase a Colt 45 for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseWeapon", WEAPON_COLT45, ammo, totalPrice); 
	}
	else if(!strcmp(a_str, "deagle"))
	{
		if(sscanf(b_str, "i", ammo))
			return SendUsageMessage(playerid, "/buygun deagle [ammo]"); 
			
		if(ammo < 1 || ammo > 32767)
			return SendErrorMessage(playerid, "Invalid Ammo.");  
			
		totalPrice = ammo * 38 + 17500; 
		
		format(str, sizeof(str), "Are you sure you want to purchase a Desert Eagle for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseWeapon", WEAPON_DEAGLE, ammo, totalPrice); 
	}
	else if(!strcmp(a_str, "shotgun"))
	{
		if(sscanf(b_str, "i", ammo))
			return SendUsageMessage(playerid, "/buygun shotgun [ammo]"); 
			
		if(ammo < 1 || ammo > 32767)
			return SendErrorMessage(playerid, "Invalid Ammo.");  
			
		totalPrice = ammo * 38 + 17500; 
		
		format(str, sizeof(str), "Are you sure you want to purchase a Shotgun for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseWeapon", WEAPON_SHOTGUN, ammo, totalPrice); 
	}
	else if(!strcmp(a_str, "rifle"))
	{
		if(sscanf(b_str, "i", ammo))
			return SendUsageMessage(playerid, "/buygun rifle [ammo]"); 
			
		if(ammo < 1 || ammo > 32767)
			return SendErrorMessage(playerid, "Invalid Ammo.");  
			
		totalPrice = ammo * 100 + 25000; 
		
		format(str, sizeof(str), "Are you sure you want to purchase a Rifle for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseWeapon", WEAPON_RIFLE, ammo, totalPrice); 
	}
	else if(!strcmp(a_str, "parachute"))
	{
		totalPrice = 1250; 
		ammo = 1; 
		
		format(str, sizeof(str), "Are you sure you want to purchase a Parachute for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseWeapon", WEAPON_PARACHUTE, ammo, totalPrice); 
	}
	else if(!strcmp(a_str, "armor"))
	{
		totalPrice = 2000; 
		
		format(str, sizeof(str), "Are you sure you want to purchase Armor for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseArmor"); 
	}
		
	return 1;
}

CMD:buyammo(playerid, params[])
{
	new id = IsPlayerInBusiness(playerid);
	new weapon[30], ammo, totalPrice, str[128];
	
	if(!IsPlayerInBusiness(playerid))	
		return SendErrorMessage(playerid, "You aren't in a business."); 
		
	if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_AMMUNATION)
		return SendErrorMessage(playerid, "You aren't in an ammunation."); 
		
	if(!PlayerInfo[playerid][pWeaponsLicense])
		return SendUnauthMessage(playerid); 
		
	if(sscanf(params, "s[30]i", weapon, ammo))
	{
		SendUsageMessage(playerid, "/buyammo [weapon] [ammo]"); 
		SendClientMessage(playerid, COLOR_GRAD2, "[ colt: $25 ] [ deagle: $38 ] [ shotgun: $38 ] [ rifle: $100 ]");
		return 1; 
	}
	
	if(ammo < 1 || ammo > 32767)
			return SendErrorMessage(playerid, "Invalid Ammo.");  
	
	if(!strcmp(weapon, "colt"))
	{
		if(!PlayerHasWeapon(playerid, 22))
			return SendErrorMessage(playerid, "You don't have this weapon.");
			
		totalPrice = 25 * ammo; 
		
		format(str, sizeof(str), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice)); 
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseAmmo", WEAPON_COLT45, ammo, totalPrice); 
	}
	else if(!strcmp(weapon, "deagle"))
	{
		if(!PlayerHasWeapon(playerid, 24))
			return SendErrorMessage(playerid, "You don't have this weapon.");
			
		totalPrice = 38 * ammo; 
		
		format(str, sizeof(str), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice)); 
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseAmmo", WEAPON_DEAGLE, ammo, totalPrice); 
	}
	else if(!strcmp(weapon, "shotgun"))
	{
		if(!PlayerHasWeapon(playerid, 25))
			return SendErrorMessage(playerid, "You don't have this weapon.");
			
		totalPrice = 38 * ammo; 
		
		format(str, sizeof(str), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice)); 
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseAmmo", WEAPON_SHOTGUN, ammo, totalPrice); 
	}
	else if(!strcmp(weapon, "rifle"))
	{
		if(!PlayerHasWeapon(playerid, 33))
			return SendErrorMessage(playerid, "You don't have this weapon.");
			
		totalPrice = 100 * ammo; 
		
		format(str, sizeof(str), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice)); 
		ConfirmDialog(playerid, "Confirmation", str, "OnPlayerPurchaseAmmo", WEAPON_RIFLE, ammo, totalPrice); 
	}
		
	return 1;
}

CMD:license(playerid, params[])
{
	new
		playerb;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/license [playerid OR name]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "You specified an invalid player.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "You specified a player that isn't logged in.");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player."); 
		
	if(playerb != playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s shows %s their identification card.", ReturnName(playerid, 0), ReturnName(playerb, 0));
		
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s looks at their identification card.", ReturnName(playerid, 0));
	
	ReturnLicenses(playerid, playerb); 	
	return 1;
}

CMD:licenseexam(playerid, params[])
{
	if(!IsPlayerInDMVVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in a license exam vehicle."); 
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't in the driver's seat."); 
		
	if(PlayerTakingLicense[playerid])
		return SendErrorMessage(playerid, "You're already in middle of a test.");
		
	new
		vehicleid = GetPlayerVehicleID(playerid);

	PlayerTakingLicense[playerid] = true; 
	PlayerLicenseTime[playerid] = 60;
	
	PlayersLicenseVehicle[playerid] = vehicleid;
	PlayerLicensePoint[playerid] = 0; 
	
	ToggleVehicleEngine(vehicleid, true); 
	VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	
	SendClientMessage(playerid, COLOR_GREY, "License instructor says: Follow the checkpoints and the rules of the road.");
	SetPlayerCheckpoint(playerid, LicensetestInfo[0][eCheckpointX], LicensetestInfo[1][eCheckpointY], LicensetestInfo[2][eCheckpointZ], 3.0); 
	return 1;
}

CMD:unimpound(playerid, params[])
{
	if(!PlayerInfo[playerid][pVehicleSpawned] && !PlayerInfo[playerid][pAdminDuty])
		return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't in the driver's seat of a vehicle."); 
		
	new vehicleid = GetPlayerVehicleID(playerid);

	if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "You don't own this vehicle.");
		
	if(!VehicleInfo[vehicleid][eVehicleImpounded])
		return SendErrorMessage(playerid, "Your vehicle isn't impounded.");
		
	if(1500 > PlayerInfo[playerid][pMoney])
		return SendErrorMessage(playerid, "You don't have $1,500 to pay the fee.");
		
	VehicleInfo[vehicleid][eVehicleImpounded] = false;	
	GiveMoney(playerid, -1500);
	
	SendServerMessage(playerid, "You have unimpounded your %s.", ReturnVehicleName(vehicleid));
	SaveVehicle(vehicleid);
	SaveVehicle(vehicleid);
	return 1;
}

CMD:fixr(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:setstation(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && !IsPlayerInProperty(playerid))
		return SendErrorMessage(playerid, "You are not near a radio.");
		
	new
		vehicleid = INVALID_VEHICLE_ID,
		id
	; 
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		vehicleid = GetPlayerVehicleID(playerid);
	
		if(GetPlayerVehicleSeat(playerid) > 1)
			return SendErrorMessage(playerid, "You aren't in the driver or front passenger seat."); 
			
		if(!VehicleInfo[vehicleid][eVehicleHasXMR])
			return SendClientMessage(playerid, COLOR_YELLOW, "This vehicle does not have an XM-Radio."); 
	}
	
	if(!strcmp(params, "off"))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(!VehicleInfo[vehicleid][eVehicleXMROn])
				return SendErrorMessage(playerid, "The XM-Radio is not on."); 
				
			PlayXMRStation(playerid, vehicleid, 0, true);
			return 1; 
		}
		
		if(IsPlayerInProperty(playerid) != 0)
		{
			PlayXMRStation(playerid, INVALID_VEHICLE_ID, IsPlayerInProperty(playerid), true); 
			return 1;
		}
		
		return 1;
	}
	
	if(sscanf(params, "i", id))
	{
		return ReturnXMRCategories(playerid); 
	}
	
	if(!XMRStationInfo[id][eXMRStationID])
		return SendErrorMessage(playerid, "You specified an invalid Station ID."); 
		
	SubXMRHolder[playerid] = id;
	PlayXMRStation(playerid, vehicleid, IsPlayerInProperty(playerid)); 
	return 1;
}

CMD:time(playerid, params[])
{
	cmd_ame(playerid, "checks the time.");
	
	new string[128], hour, minute, seconds;
	
	gettime(hour, minute, seconds);
	
	if(PlayerInfo[playerid][pAdminjailed] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Jail Time left: %d SEC", hour, minute, PlayerInfo[playerid][pAdminjailTime]);

	else
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|", hour, minute);
		
	GameTextForPlayer(playerid, string, 2000, 1);
	
	return 1;
}

CMD:rcp(playerid, params[])
{
	DisablePlayerCheckpoint(playerid);
	
	//Disabling checkpoint referring variables:
	PlayerCheckpoint[playerid] = 0;
	return 1;
}

CMD:weapons(playerid, params[])
{
	SendClientMessage(playerid, COLOR_RED, "To throw away a weapon, type /leavegun [weapon ID]"); 
	
	for(new i = 0; i < 4; i++)
	{
		if(PlayerInfo[playerid][pWeaponsAmmo][i] > 0)
			SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d] Weapon: [%s] - Ammo: [%d]", PlayerInfo[playerid][pWeapons][i], ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]);
	}
		
	return 1;
}

CMD:lg(playerid, params[])return cmd_leavegun(playerid, params);
CMD:leavegun(playerid, params[])
{
	new 
		weaponid, 
		idx,
		id, 
		Float:x,
		Float:y,
		Float:z
	;
	
	if(sscanf(params, "i", weaponid))
	{
		SendUsageMessage(playerid, "/leavegun [weapon id]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} To pick up the weapon, use /grabgun."); 
		return 1;
	}
	
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "You have specified an invalid weaponid.");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "You don't have that weapon."); 
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
		{
			idx = i;
			break;
		}
	}
	
	id = ReturnWeaponIDSlot(weaponid); 
	GetPlayerPos(playerid, x, y, z); 
	
	WeaponDropInfo[idx][eWeaponDropped] = true;
	WeaponDropInfo[idx][eWeaponDroppedBy] = PlayerInfo[playerid][pDBID]; 
	
	WeaponDropInfo[idx][eWeaponWepID] = weaponid;
	WeaponDropInfo[idx][eWeaponWepAmmo] = PlayerInfo[playerid][pWeaponsAmmo][id];
	
	WeaponDropInfo[idx][eWeaponPos][0] = x;
	WeaponDropInfo[idx][eWeaponPos][1] = y;
	WeaponDropInfo[idx][eWeaponPos][2] = z;
	
	WeaponDropInfo[idx][eWeaponInterior] = GetPlayerInterior(playerid);
	WeaponDropInfo[idx][eWeaponWorld] = GetPlayerVirtualWorld(playerid); 
	
	RemovePlayerWeapon(playerid, weaponid);
	PlayerInfo[playerid][pWeapons][id] = 0;
	PlayerInfo[playerid][pWeaponsAmmo][id] = 0; 
	
	WeaponDropInfo[idx][eWeaponObject] = CreateDynamicObject(
		ReturnWeaponsModel(weaponid),
		x,
		y,
		z - 1,
		80.0,
		0.0,
		0.0,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)); 
		
	WeaponDropInfo[idx][eWeaponTimer] = SetTimerEx("OnPlayerLeaveWeapon", 600000, false, "i", idx); 
	SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} Your weapon will disappear in 10 minutes if it isn't picked up.");
	return 1;
}

CMD:gg(playerid, params[]) return cmd_grabgun(playerid, params);
CMD:grabgun(playerid, params[])
{	
	new
		bool:foundWeapon = false,
		id,
		str[128]
	;

	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue; 
	
		if(IsPlayerInRangeOfPoint(playerid, 3.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				foundWeapon = true;
				id = i;
			}							
		}
	}
	
	if(foundWeapon)
	{
		GivePlayerGun(playerid, WeaponDropInfo[id][eWeaponWepID], WeaponDropInfo[id][eWeaponWepAmmo]);
		
		format(str, sizeof(str), "* %s picks up a %s.", ReturnName(playerid, 0), ReturnWeaponName(WeaponDropInfo[id][eWeaponWepID]));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		SendClientMessage(playerid, COLOR_EMOTE, str);
		
		WeaponDropInfo[id][eWeaponDropped] = false; 
		WeaponDropInfo[id][eWeaponDroppedBy] = 0;
		
		WeaponDropInfo[id][eWeaponWepID] = 0; WeaponDropInfo[id][eWeaponWepAmmo] = 0; 
		
		KillTimer(WeaponDropInfo[id][eWeaponTimer]); 
		DestroyDynamicObject(WeaponDropInfo[id][eWeaponObject]); 
	}
	else return SendServerMessage(playerid, "You aren't near a dropped weapon.");
	return 1;
}

CMD:enter(playerid, params[])
{
	new
		id,
		str[128]
	; 

	for(new p = 1; p < MAX_PROPERTY; p++)
	{
		if(!PropertyInfo[p][ePropertyDBID])
			continue;
				
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[p][ePropertyEntrance][0], PropertyInfo[p][ePropertyEntrance][1], PropertyInfo[p][ePropertyEntrance][2]))
		{
			if(GetPlayerInterior(playerid) != PropertyInfo[p][ePropertyEntranceInterior])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != PropertyInfo[p][ePropertyEntranceWorld])
				continue;
				
			if(PropertyInfo[p][ePropertyLocked])
				return GameTextForPlayer(playerid, "~r~Locked", 3000, 1);
				
			PlayerInfo[playerid][pInsideProperty] = p;
			
			if(PropertyInfo[p][ePropertyBoomboxOn])
			{
				PlayAudioStreamForPlayer(playerid, PropertyInfo[p][ePropertyBoomboxURL]);
			}

			SetPlayerPos(playerid, PropertyInfo[p][ePropertyInterior][0], PropertyInfo[p][ePropertyInterior][1], PropertyInfo[p][ePropertyInterior][2] - 3);
			
			SetPlayerVirtualWorld(playerid, PropertyInfo[p][ePropertyInteriorWorld]);
			SetPlayerInterior(playerid, PropertyInfo[p][ePropertyInteriorIntID]);
			
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterProperty", 2000, false, "ii", playerid, p); 
		
		}
	}
	
	if((id = IsPlayerNearBusiness(playerid)) != 0)
	{
		if(BusinessInfo[id][eBusinessLocked])
			return GameTextForPlayer(playerid, "~r~Locked", 3000, 1); 
			
		if(BusinessInfo[id][eBusinessType] == BUSINESS_TYPE_DEALERSHIP || BusinessInfo[id][eBusinessType] == BUSINESS_TYPE_DMV)
			return GameTextForPlayer(playerid, "~r~Closed", 3000, 1); 
			
		if(BusinessInfo[id][eBusinessEntranceFee] > PlayerInfo[playerid][pMoney])
			return GameTextForPlayer(playerid, "~r~You can't afford this.", 3000, 1); 
			
		if(PlayerInfo[playerid][pDBID] != BusinessInfo[id][eBusinessOwnerDBID] && BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_BANK)
		{
			GiveMoney(playerid, -BusinessInfo[id][eBusinessEntranceFee]); 
			BusinessInfo[id][eBusinessCashbox]+= BusinessInfo[id][eBusinessEntranceFee]; 
		}
			
		format(str, sizeof(str), "%s", BusinessInfo[id][eBusinessName]); 
		GameTextForPlayer(playerid, str, 3000, 1); 
		
		SetPlayerPos(playerid, BusinessInfo[id][eBusinessInterior][0], BusinessInfo[id][eBusinessInterior][1], BusinessInfo[id][eBusinessInterior][2]); 
		
		SetPlayerInterior(playerid, BusinessInfo[id][eBusinessInteriorIntID]); 
		SetPlayerVirtualWorld(playerid, BusinessInfo[id][eBusinessInteriorWorld]); 
		
		PlayerInfo[playerid][pInsideBusiness] = id; 
		
		SendBusinessType(playerid, id);
		return 1;
	}
	
	SendServerMessage(playerid, "You aren't near an entrance."); 
	return 1;
}

CMD:exit(playerid, params[])
{
	new 
		id,
		b_id
	;
	
	if(PlayerInfo[playerid][pEditingObject])
		return SendErrorMessage(playerid, "You can't leave while editing an object.");
	
	if((id = IsPlayerInProperty(playerid)) != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[id][ePropertyInterior][0], PropertyInfo[id][ePropertyInterior][1], PropertyInfo[id][ePropertyInterior][2]))
			return SendErrorMessage(playerid, "You aren't near the door.");
	
		SetPlayerPos(playerid, PropertyInfo[id][ePropertyEntrance][0], PropertyInfo[id][ePropertyEntrance][1], PropertyInfo[id][ePropertyEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, PropertyInfo[id][ePropertyEntranceWorld]);
		SetPlayerInterior(playerid, PropertyInfo[id][ePropertyEntranceInterior]); 
		
		if(PropertyInfo[id][ePropertyBoomboxOn])
			StopAudioStreamForPlayer(playerid);
		
		PlayerInfo[playerid][pInsideProperty] = 0;
		return 1;
	}
	
	if((b_id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][eBusinessInterior][0], BusinessInfo[b_id][eBusinessInterior][1], BusinessInfo[b_id][eBusinessInterior][2]))
			return SendErrorMessage(playerid, "You aren't near the door.");
	
		SetPlayerPos(playerid, BusinessInfo[b_id][eBusinessEntrance][0], BusinessInfo[b_id][eBusinessEntrance][1], BusinessInfo[b_id][eBusinessEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		
		PlayerInfo[playerid][pInsideBusiness] = 0;
		return 1;
	}
	
	SendServerMessage(playerid, "You aren't in an interior.");
	return 1;
}

//Vehicle commands:
CMD:v(playerid, params[]) return cmd_vehicle(playerid, params);
CMD:vehicle(playerid, params[])
{
	new oneString[30], secString[90];
	
	if(sscanf(params, "s[30]S()[90]", oneString, secString))
	{
		SendUsageMessage(playerid, "/vehicle [action]"); 
		SendServerMessage(playerid, "get, park, buypark, duplicatekey, buy"); 
		SendServerMessage(playerid, "scrap, tow, lock, lights, find, stats");
		SendServerMessage(playerid, "list, faction, unfaction, trunk, hood");
		return 1;
	}
	
	if(!strcmp(oneString, "get"))
	{
		new 
			slotid
		;
		
		if(sscanf(secString, "d", slotid))
			return SendUsageMessage(playerid, "/vehicle get [vehicle slot]"); 
			
		if(slotid < 1 || slotid > 5)
			return SendErrorMessage(playerid, "You specified an invalid slot."); 
			
		if(!PlayerInfo[playerid][pOwnedVehicles][slotid])
			return SendErrorMessage(playerid, "You don't have a vehicle in that slot."); 
			
		if(PlayerInfo[playerid][pVehicleSpawned] == true)
			return SendErrorMessage(playerid, "You already have a vehicle spawned."); 
			
		new threadLoad[128]; 
		
		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][eVehicleDBID] == PlayerInfo[playerid][pOwnedVehicles][slotid])
				return SendErrorMessage(playerid, "That vehicle's already spawned.");
		}
		//Easiest way to prevent players with faction vehicles duplicating it.
		
		mysql_format(ourConnection, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][slotid]);
		mysql_tquery(ourConnection, threadLoad, "Query_LoadPrivateVehicle", "i", playerid); 
	}
	else if(!strcmp(oneString, "park"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You aren't in any vehicle.");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "You need to be driving your vehicle.");

		new 
			vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]))
		{
			SendErrorMessage(playerid, "You have to be at your vehicle's parking place.");
			SendClientMessage(playerid, 0xFF00FFFF, "Follow the marker to your parking.");
		
			SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 5.0);
			return 1;
		}
		
		PlayerInfo[playerid][pVehicleSpawned] = false; 
		PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
		
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "You parked your %s.", ReturnVehicleName(vehicleid));
		
		SaveVehicle(vehicleid);
		
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid); 
	}
	else if(!strcmp(oneString, "buypark"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You aren't in any vehicle.");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "You need to be driving your vehicle.");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		new 
			vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		GetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]);
		GetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]); 
		
		VehicleInfo[vehicleid][eVehicleParkInterior] = GetPlayerInterior(playerid);
		VehicleInfo[vehicleid][eVehicleParkWorld] = GetPlayerVirtualWorld(playerid); 
		
		SendServerMessage(playerid, "You purchased the parking place for $1,000.");
		GiveMoney(playerid, -1000);
	}
	else if(!strcmp(oneString, "duplicatekey"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You aren't in any vehicle.");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		new 
			playerb, vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		if(sscanf(params, "u", playerb))
			return SendUsageMessage(playerid, "/vehicle duplicatekey [playerid OR name]"); 
			
		if(playerb == playerid)return SendErrorMessage(playerid, "You can't give yourself a duplicate key.");
			
		if(!IsPlayerConnected(playerb))
			return SendErrorMessage(playerid, "The player you specified isn't connected.");
			
		if(e_pAccountData[playerb][mLoggedin] == false)
			return SendErrorMessage(playerid, "The player you specified isn't logged in.");
			
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "You aren't near that player."); 
			
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s gives %s a key to their vehicle.", ReturnName(playerid, 0), ReturnName(playerb, 0));
		SendServerMessage(playerb, "%s gave you a key to their vehicle.", ReturnName(playerid, 0));
		
		GiveMoney(playerid, -500);
		SendServerMessage(playerid, "You gave %s a duplicatekey for $500.", ReturnName(playerb, 0));
		
		PlayerInfo[playerb][pDuplicateKey] = vehicleid;
	}
	else if(!strcmp(oneString, "buy"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned])
			return SendErrorMessage(playerid, "You have a vehicle spawned."); 
			
		new
			id,
			larstr[190],
			idx
		;
			
		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(!PlayerInfo[playerid][pOwnedVehicles][i])
			{
				idx = i;
				break;
			}
		}
				
		if(!idx)
		{
			SendServerMessage(playerid, "You own the maximum amount of vehicles."); 
			return 1;
		}
		
		if(!(id = IsPlayerNearBusiness(playerid)))
			return SendErrorMessage(playerid, "You aren't near a business.");
			
		if((id = IsPlayerNearBusiness(playerid)))
		{
			if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_DEALERSHIP)
				return SendErrorMessage(playerid, "You aren't at a dealership."); 
				
			for(new i = 0; i < sizeof(g_aDealershipCategory); i++)
			{
				format(larstr, sizeof(larstr), "%s%s\n", larstr, g_aDealershipCategory[i]); 
			}
			
			PlayerInfo[playerid][pAtDealership] = id; 
			ShowPlayerDialog(playerid, DIALOG_DEALERSHIP, DIALOG_STYLE_LIST, "Categories:", larstr, "Select", "Cancel");			
		}
	}
	else if(!strcmp(oneString, "scrap"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You aren't in any vehicle.");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "You need to be driving your vehicle.");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		new 
			str[160], 
			vehicleid = GetPlayerVehicleID(playerid),
			cash_back
		;
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		for(new i = 0; i < sizeof(g_aDealershipData); i++)
		{
			if(g_aDealershipData[i][eDealershipModelID] == VehicleInfo[vehicleid][eVehicleModel])
			{
				cash_back = g_aDealershipData[i][eDealershipPrice] / 2; 
			}
		}
			
		format(str, sizeof(str), "Are you sure you want to scrap your %s?\nYou'll receive a cashback of: $%s\n\n{FF6347}This action is permanent and cannot be undone.", ReturnVehicleName(vehicleid), MoneyFormat(cash_back)); 
		ConfirmDialog(playerid, "Confirmation", str, "OnVehicleScrap", VehicleInfo[vehicleid][eVehicleDBID], cash_back);
	}
	else if(!strcmp(oneString, "tow"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "Your vehicle is in use."); 
			
		VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay] = 
			Create3DTextLabel("(( | ))\nTOWING VEHICLE", COLOR_DARKGREEN, 0.0, 0.0, 0.0, 25.0, 0, 1);
			
		Attach3DTextLabelToVehicle(VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay], PlayerInfo[playerid][pVehicleSpawnedID], -0.0, -0.0, -0.0);
			
		playerTowingVehicle[playerid] = true;
		playerTowTimer[playerid] = SetTimerEx("OnVehicleTow", 5000, true, "i", playerid);
		
		SendServerMessage(playerid, "Your %s's tow request was sent.", ReturnVehicleName(PlayerInfo[playerid][pVehicleSpawnedID]));
	}
	else if(!strcmp(oneString, "lock"))
	{
		new bool:foundCar = false, vehicleid, Float:fetchPos[3];
		
		for (new i = 0; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, fetchPos[0], fetchPos[1], fetchPos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 4.0, fetchPos[0], fetchPos[1], fetchPos[2]))
			{
				foundCar = true;
				vehicleid = i; 
				break; 
			}
		}
		if(foundCar == true)
		{
			if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
				return SendErrorMessage(playerid, "You don't have the keys to this vehicle."); 
				
			new statusString[90]; 
			new engine, lights, alarm, doors, bonnet, boot, objective; 
	
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(VehicleInfo[vehicleid][eVehicleLocked])
			{
				format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
			
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = false;
			}
			else 
			{
				format(statusString, sizeof(statusString), "~r~%s LOCKED", ReturnVehicleName(vehicleid));
				
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = true;
			}
			GameTextForPlayer(playerid, statusString, 3000, 3);
		}
		else SendServerMessage(playerid, "You aren't near a vehicle OR the vehicle isn't synced.");
	}
	else if(!strcmp(oneString, "lights"))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You aren't in any vehicle.");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You aren't driving a vehicle.");
		
		if(VehicleInfo[vehicleid][eVehicleLights] == false)
			ToggleVehicleLights(vehicleid, true);
			
		else ToggleVehicleLights(vehicleid, false);
	}
	else if(!strcmp(oneString, "find"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "Your vehicle is in use / stolen.");
			
		new 
			Float:fetchPos[3];
		
		GetVehiclePos(PlayerInfo[playerid][pVehicleSpawnedID], fetchPos[0], fetchPos[1], fetchPos[2]);
		SetPlayerCheckpoint(playerid, fetchPos[0], fetchPos[1], fetchPos[2], 3.0);
	}
	else if(!strcmp(oneString, "stats"))
	{			
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle.");
			
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[{%06x}%d{FFFFFF}], Secondary Color[{%06x}%d{FFFFFF}], License Plate[%s]", VehicleColoursTableRGBA[VehicleInfo[vehicleid][eVehicleColor1]] >>> 8, VehicleInfo[vehicleid][eVehicleColor1], VehicleColoursTableRGBA[VehicleInfo[vehicleid][eVehicleColor2]] >>> 8, VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
	}
	else if(!strcmp(oneString, "faction"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "You don't have a vehicle spawned.");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You aren't in a vehicle.");
			
		if(!PlayerInfo[playerid][pFaction]) return SendErrorMessage(playerid, "You aren't in any faction.");
		
		if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
			return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You don't have permission in your faction to add faction vehicles.");
			
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		if(VehicleInfo[vehicleid][eVehicleFaction] != 0)
			return SendErrorMessage(playerid, "This vehicle is already factionized to the %s.", ReturnFactionNameEx(VehicleInfo[vehicleid][eVehicleFaction]));
		
		VehicleInfo[vehicleid][eVehicleFaction] = PlayerInfo[playerid][pFaction]; 
		SendServerMessage(playerid, "Your vehicle now belongs to the %s.", ReturnFactionName(playerid));
		
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(oneString, "unfaction"))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You aren't driving a vehicle.");
			
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this vehicle."); 
			
		SendServerMessage(playerid, "You unfactionized your %s from the %s.", ReturnVehicleName(vehicleid), ReturnFactionNameEx(VehicleInfo[vehicleid][eVehicleFaction]));
		VehicleInfo[vehicleid][eVehicleFaction] = 0;
		
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(oneString, "trunk"))
	{
		new
			Float:x,
			Float:y,
			Float:z
		;
		
		new engine, lights, alarm, doors, bonnet, boot, objective;
	
		if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
			
			new 
				vehicleid = GetNearestVehicle(playerid)
			;
				
			if(VehicleInfo[vehicleid][eVehicleLocked])
				return SendServerMessage(playerid, "This vehicle is locked."); 
			
			if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
				return SendErrorMessage(playerid, "You aren't near the vehicles trunk.");
			
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(!boot)
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have opened the trunk.");
				SendClientMessage(playerid, COLOR_WHITE, "You can use /check to take a gun or /place to put one in."); 
			}
			else
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
				
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have closed the trunk.");
			}
		}
		else if(IsPlayerInAnyVehicle(playerid))
		{
			new
				vehicleid = GetPlayerVehicleID(playerid)
			;
			
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "You aren't in the driver's seat.");
			
			if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
				return SendErrorMessage(playerid, "You don't have the keys to this vehicle."); 
				
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(!boot)
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have opened the trunk.");
				SendClientMessage(playerid, COLOR_WHITE, "You can use /check to take a gun or /place to put one in."); 
			}
			else
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have closed the trunk.");
			}
		}
		else return SendServerMessage(playerid, "You aren't in or near a vehicle.");
	}
	else if(!strcmp(oneString, "hood"))
	{
		new
			Float:x,
			Float:y,
			Float:z
		;
		
		new engine, lights, alarm, doors, bonnet, boot, objective;
	
		if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			GetVehicleHood(GetNearestVehicle(playerid), x, y, z); 
			
			new 
				vehicleid = GetNearestVehicle(playerid)
			;
				
			if(VehicleInfo[vehicleid][eVehicleLocked])
				return SendServerMessage(playerid, "This vehicle is locked."); 
			
			if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
				return SendErrorMessage(playerid, "You aren't near the vehicles hood.");
			
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(!bonnet)
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have opened the hood.");
			}
			else
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have closed the hood.");
			}
		}
		else if(IsPlayerInAnyVehicle(playerid))
		{
			new
				vehicleid = GetPlayerVehicleID(playerid)
			;
			
			if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
				return SendErrorMessage(playerid, "You don't have the keys to this vehicle."); 
				
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "You aren't in the driver's seat.");
				
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(!bonnet)
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have opened the hood.");
			}
			else
			{
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
				SendClientMessage(playerid, COLOR_YELLOWEX, "You have closed the hood.");
			}
		}
		else return SendServerMessage(playerid, "You aren't in or near a vehicle.");
	}
	else if(!strcmp(oneString, "list"))
	{
		if(CountPlayerVehicles(playerid) == 0)
			return SendServerMessage(playerid, "You don't own any vehicles.");
			
		return ShowVehicleList(playerid); 
	}
	else return SendErrorMessage(playerid, "Invalid Parameter.");
	return 1;
}

CMD:engine(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't in the driver's seat of a vehicle."); 
		
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "This vehicle doesn't have a engine."); 

	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendServerMessage(playerid, "This command can only be used for private vehicles. You are in a public static vehicle.");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] < 1 && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendClientMessage(playerid, COLOR_RED, "Vehicle is out of fuel!"); 
	
	if(VehicleInfo[vehicleid][eVehicleFaction] > 0)
	{
		if(PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction] && !PlayerInfo[playerid][pAdminDuty])
		{
			return SendErrorMessage(playerid, "You don't have the keys to this vehicle."); 
		}
	}
	
	if(!VehicleInfo[vehicleid][eVehicleFaction] && VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid && !PlayerInfo[playerid][pAdminDuty] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
	{
		new idx, str[128];
		
		if(VehicleInfo[vehicleid][eVehicleEngineStatus] && !PlayerInfo[playerid][pAdminDuty])
			return GameTextForPlayer(playerid, "~g~ENGINE IS ALREADY ON", 3000, 3);
		
		PlayerInfo[playerid][pUnscrambling] = true;
	
		for(new i = 0; i < sizeof(UnscrambleInfo); i++)
		{
			idx = random(sizeof(UnscrambleInfo));
		}
		
		PlayerInfo[playerid][pUnscrambleID] = idx;
		
		switch(VehicleInfo[vehicleid][eVehicleImmobLevel])
		{
			case 1: PlayerInfo[playerid][pUnscramblerTime] = 125; 
			case 2: PlayerInfo[playerid][pUnscramblerTime] = 100; 
			case 3: PlayerInfo[playerid][pUnscramblerTime] = 75; 
			case 4: PlayerInfo[playerid][pUnscramblerTime] = 50;
			case 5: PlayerInfo[playerid][pUnscramblerTime] = 25;
		}
		
		PlayerInfo[playerid][pUnscrambleTimer] = SetTimerEx("OnPlayerUnscramble", 1000, true, "i", playerid);
		
		format(str, sizeof(str), "%s", UnscrambleInfo[idx][eScrambledWord]); 
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], str);
		
		format(str, sizeof(str), "%d", PlayerInfo[playerid][pUnscramblerTime]);
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], str);
		
		ShowUnscrambleTextdraw(playerid);
		return 1; 
	}
	
	if(!VehicleInfo[vehicleid][eVehicleEngineStatus])
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s started the engine of the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s stopped the engine of the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	}
	return 1;
}

CMD:uns(playerid, params[])	return cmd_unscramble(playerid, params);
CMD:unscramble(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't driving a vehicle.");
		
	if(!PlayerInfo[playerid][pUnscrambling])
		return SendErrorMessage(playerid, "You aren't hotwiring a vehicle.");
	
	if(isnull(params)) return SendUsageMessage(playerid, "/(uns)cramble [unscrambled word]");
	
	if(!strcmp(UnscrambleInfo[PlayerInfo[playerid][pUnscrambleID]][eUnscrambledWord], params))
	{ // This occurrs if they wrote the correct word:
	
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleInfo)); 
		
		new displayString[60];
		
		format(displayString, 60, "%s", UnscrambleInfo[PlayerInfo[playerid][pUnscrambleID]][eScrambledWord]);
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		//Timer increases depending on alarm level:
		PlayerInfo[playerid][pUnscramblerTime] += 9;
		PlayerInfo[playerid][pScrambleSuccess]++; 
		
		PlayerPlaySound(playerid, 1052, 0, 0, 0);
		//Depending on alarm levels, success time would change:
		if(PlayerInfo[playerid][pScrambleSuccess] >= 7)
		{
			KillTimer(PlayerInfo[playerid][pUnscrambleTimer]);
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			GameTextForPlayer(playerid, "~g~ENGINE TURNED ON", 2000, 3); 
			ShowUnscrambleTextdraw(playerid, false);
			
			new vehicleid = GetPlayerVehicleID(playerid);
			
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s started the engine of the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid)); 
			ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
		}	
	}
	else
	{
		PlayerPlaySound(playerid, 1055, 0, 0, 0); 
		
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleInfo)); 
		
		new displayString[60];
		
		format(displayString, 60, "%s", UnscrambleInfo[PlayerInfo[playerid][pUnscrambleID]][eScrambledWord]);
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		PlayerInfo[playerid][pScrambleFailed]++; 
		PlayerInfo[playerid][pUnscramblerTime] -= random(6)+1;
		
		if(PlayerInfo[playerid][pScrambleFailed] >= 5)
		{
			KillTimer(PlayerInfo[playerid][pUnscrambleTimer]);
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			new 
				vehicleid = GetPlayerVehicleID(playerid)
			;
			
			ToggleVehicleAlarms(vehicleid, true);
			NotifyVehicleOwner(vehicleid);
			
			ClearAnimations(playerid);
			ShowUnscrambleTextdraw(playerid, false);
		}
	}
	
	return 1;
}

CMD:check(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !IsPlayerInProperty(playerid))
		return SendErrorMessage(playerid, "You can't do this right now.");
	
	new
		Float: x,
		Float: y,
		Float: z,
		principal_str[256]
	;
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
		
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		
		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "This command can only be used for private vehicles. You are in a public static vehicle.");
		
		if(VehicleInfo[vehicleid][eVehicleFaction] && FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionType] != FACTION_TYPE_ILLEGAL && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "You don't have access to this vehicle.");
		
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "You aren't near the vehicles trunk.");
 
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		
		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "You need to open the trunk first."); 
			
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[Ammo: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [Empty]\n", principal_str, i);
		}
			 
		ShowPlayerDialog(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "Select", "<<");
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "This command can only be used for private vehicles. You are in a public static vehicle.");	

		if(VehicleInfo[vehicleid][eVehicleFaction] && FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionType] != FACTION_TYPE_ILLEGAL && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "You don't have access to this vehicle.");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[Ammo: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [Empty]\n", principal_str, i);
		}
			 
		ShowPlayerDialog(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "Select", "<<");
	}
	else if(IsPlayerInProperty(playerid))
	{
		new
			id = IsPlayerInProperty(playerid),
			longstr[600]
		;
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[id][ePropertyPlacePos][0], PropertyInfo[id][ePropertyPlacePos][1], PropertyInfo[id][ePropertyPlacePos][2]))
			return SendErrorMessage(playerid, "You aren't near this properties place position.");
			
		for(new i = 1; i < 21; i++)
		{
			if(!PropertyInfo[id][ePropertyWeapons][i])
				format(longstr, sizeof(longstr), "%s%d. [Empty]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[Ammo: %d]\n", longstr, i, ReturnWeaponName(PropertyInfo[id][ePropertyWeapons][i]), PropertyInfo[id][ePropertyWeaponsAmmo][i]); 
		}
		
		ShowPlayerDialog(playerid, DIALOG_HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapons:", longstr, "Select", "Cancel");		
	}
	return 1;
}

CMD:place(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !IsPlayerInProperty(playerid))
		return SendErrorMessage(playerid, "You can't do this right now.");
	
	new
		Float: x,
		Float: y,
		Float: z,
		str[128],
		weaponid,
		idx
	;
	
	if(sscanf(params, "i", weaponid))
		return SendUsageMessage(playerid, "/place [weapon id]");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "You don't have that weapon.");
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
		
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction] && FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionType] != FACTION_TYPE_ILLEGAL)
			return SendClientMessage(playerid, COLOR_YELLOW, "You don't have access to this vehicle.");
		
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "You aren't near the vehicles trunk.");
 
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		
		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "You need to open the trunk first."); 
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s placed a %s in the %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction] && FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionType] != FACTION_TYPE_ILLEGAL)
			return SendClientMessage(playerid, COLOR_YELLOW, "You don't have access to this vehicle.");
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s placed a %s in the %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
	}
	else if(IsPlayerInProperty(playerid))
	{
		new
			id = IsPlayerInProperty(playerid),
			pid
		;
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[id][ePropertyPlacePos][0], PropertyInfo[id][ePropertyPlacePos][1], PropertyInfo[id][ePropertyPlacePos][2]))
			return SendErrorMessage(playerid, "You aren't near this properties place position.");
			
		for(new i = 1; i < 21; i++)
		{
			if(!PropertyInfo[id][ePropertyWeapons][i])
			{
				pid = i;
				break;
			}
		}
		
		PropertyInfo[id][ePropertyWeapons][pid] = weaponid;
		PropertyInfo[id][ePropertyWeaponsAmmo][pid] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];
		
		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s placed a %s in the house.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
	}
	return 1;
}

//Property commands:
CMD:buyproperty(playerid, params[])
{
	new
		bool:nearProperty = false,
		id,
		str[128]
	;
	
	for(new i = 1; i < MAX_PROPERTY; i++)
	{
		if(!PropertyInfo[i][ePropertyDBID])
			continue;
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[i][ePropertyEntrance][0], PropertyInfo[i][ePropertyEntrance][1], PropertyInfo[i][ePropertyEntrance][2]))
		{
			nearProperty = true;
			id = i;
			break; 
		}
	}
	
	if(nearProperty)
	{
		if(PropertyInfo[id][ePropertyOwnerDBID])
			return SendErrorMessage(playerid, "This property isn't for sale."); 
			
		if(PropertyInfo[id][ePropertyMarketPrice] > PlayerInfo[playerid][pMoney])
			return SendErrorMessage(playerid, "You can't afford to buy this property.");
			
		if(CountPlayerProperties(playerid) > 3)
			return SendErrorMessage(playerid, "You already own 3 properties."); 
			
		GiveMoney(playerid, -PropertyInfo[id][ePropertyMarketPrice]); 	
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		
		format(str, sizeof(str), "Congratulations!~n~You're now the owner of this property! $%d", PropertyInfo[id][ePropertyMarketPrice]);
		GameTextForPlayer(playerid, str, 4000, 5);
		
		PropertyInfo[id][ePropertyOwnerDBID] = PlayerInfo[playerid][pDBID]; 
		SaveCharacter(playerid); SaveProperty(id);
	}
	else return SendErrorMessage(playerid, "You aren't near a property.");
	return 1; 
}

CMD:lock(playerid, params[])
{
	new
		id,
		b_id
	;
	
	if((id = IsPlayerNearProperty(playerid)) != 0)
	{
		if(PlayerInfo[playerid][pDBID] != PropertyInfo[id][ePropertyOwnerDBID])
			return SendErrorMessage(playerid, "You don't have the keys to this property."); 
			
		if(!PropertyInfo[id][ePropertyLocked])
		{	
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			PropertyInfo[id][ePropertyLocked] = true; 
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			PropertyInfo[id][ePropertyLocked] = false; 
		}
	}
	else if((id = IsPlayerInProperty(playerid)) != 0)
	{
		if(PlayerInfo[playerid][pDBID] != PropertyInfo[id][ePropertyOwnerDBID])
			return SendErrorMessage(playerid, "You don't have the keys to this property."); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[id][ePropertyInterior][0], PropertyInfo[id][ePropertyInterior][1], PropertyInfo[id][ePropertyInterior][2]))
			return SendErrorMessage(playerid, "You aren't near your properties door."); 
			
		if(!PropertyInfo[id][ePropertyLocked])
		{	
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			PropertyInfo[id][ePropertyLocked] = true; 
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			PropertyInfo[id][ePropertyLocked] = false; 
		}
	}
	
	if((b_id = IsPlayerNearBusiness(playerid)) != 0)
	{
		if(BusinessInfo[b_id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't have the keys to this business."); 
			
		if(!BusinessInfo[b_id][eBusinessLocked])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			BusinessInfo[b_id][eBusinessLocked] = true;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			BusinessInfo[b_id][eBusinessLocked] = false;
		}
	}
	else if((b_id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][eBusinessInterior][0], BusinessInfo[b_id][eBusinessInterior][1], BusinessInfo[b_id][eBusinessInterior][2]))
			return SendErrorMessage(playerid, "You aren't near the door.");
		
		if(BusinessInfo[b_id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't have the keys to this business."); 
			
		if(!BusinessInfo[b_id][eBusinessLocked])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			BusinessInfo[b_id][eBusinessLocked] = true;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 4);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			
			BusinessInfo[b_id][eBusinessLocked] = false;
		}
	}
	return 1;
}

CMD:placepos(playerid, params[])
{
	new
		id
	;
	
	if((id = IsPlayerInProperty(playerid)) != 0)
	{
		if(PlayerInfo[playerid][pDBID] != PropertyInfo[id][ePropertyOwnerDBID])
			return SendErrorMessage(playerid, "You don't own this house.");

		GetPlayerPos(playerid, PropertyInfo[id][ePropertyPlacePos][0], PropertyInfo[id][ePropertyPlacePos][1], PropertyInfo[id][ePropertyPlacePos][2]); 
		SendServerMessage(playerid, "You changed your properties place position."); 
	}
	else return SendErrorMessage(playerid, "You aren't in a property.");
	
	return 1;
}

CMD:property(playerid, params[])
{
	if(!CountPlayerProperties(playerid))
		return SendErrorMessage(playerid, "You don't own a property."); 
		
	new id, str[90], bstr[90], cstr[60];
	
	if((id = IsPlayerInProperty(playerid)) == 0)
		return SendErrorMessage(playerid, "You aren't inside your property.");
		
	if(PropertyInfo[id][ePropertyOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "You don't own this property."); 
		
	if(sscanf(params, "s[90]S()[90]S()[60]", str, bstr, cstr))
	{
		SendClientMessage(playerid, COLOR_RED, "____________________________________________________");
		SendUsageMessage(playerid, "/property [action]");
		SendClientMessage(playerid, COLOR_RED, "[Actions] info, cashbox, boombox"); 
		SendClientMessage(playerid, COLOR_RED, "____________________________________________________");
		return 1;
	}
	
	if(!strcmp(str, "info"))
	{
		new type[30];
		
		if(PropertyInfo[id][ePropertyType] == PROPERTY_TYPE_HOUSE)
			type = "House";
		
		else if(PropertyInfo[id][ePropertyType] == PROPERTY_TYPE_APTROOM)
			type = "Apartment Room";
			
		else if(PropertyInfo[id][ePropertyType] == PROPERTY_TYPE_APTCOMPLEX)
			type = "Apartment Complex"; 
	
		SendClientMessageEx(playerid, COLOR_WHITE, "House ID:[%i], Price:[$%s], Level:[%i], Type:[%s]", PropertyInfo[id][ePropertyDBID], MoneyFormat(PropertyInfo[id][ePropertyMarketPrice]), PropertyInfo[id][ePropertyLevel], type); 
	}
	else if(!strcmp(str, "cashbox"))
	{
		new pick[30], amount;
		
		if(sscanf(bstr, "s[30]", pick))
			return SendUsageMessage(playerid, "/property cashbox [Info, Place, Take]"); 
			
		if(!strcmp(pick, "info"))
		{
			SendClientMessageEx(playerid, COLOR_ACTION, "You have $%s inside your houses' cashbox.", MoneyFormat(PropertyInfo[id][ePropertyCashbox])); 
		}
		else if(!strcmp(pick, "place"))
		{	
			if(sscanf(cstr, "i", amount))
				return SendUsageMessage(playerid, "/property cashbox place [amount]"); 
				
			if(amount > PlayerInfo[playerid][pMoney])
				return SendErrorMessage(playerid, "You don't have that amount on you.");
				
			GiveMoney(playerid, -amount);
			PropertyInfo[id][ePropertyCashbox]+= amount; 
			
			SendServerMessage(playerid, "You added $%s to your cashbox.", amount); 
			SaveProperty(id);
		}
		else if(!strcmp(pick, "take"))
		{
			if(sscanf(cstr, "i", amount))
				return SendUsageMessage(playerid, "/property cashbox take [amount]");
				
			if(amount > PropertyInfo[id][ePropertyCashbox])
				return SendErrorMessage(playerid, "Your cashbox doesn't have that much.");
				
			GiveMoney(playerid, amount);
			PropertyInfo[id][ePropertyCashbox]-= amount;
			
			SendServerMessage(playerid, "You took $%s from your cashbox.", amount); 
			SaveProperty(id); 
		}
		else return SendErrorMessage(playerid, "Invalid Paramater."); 
	}
	else if(!strcmp(str, "boombox"))
	{
		new pick[30]; 
		
		if(sscanf(bstr, "s[30]", pick))
			return SendUsageMessage(playerid, "/property boombox [Add, Remove, Adjust]"); 
			
		if(!strcmp(pick, "add"))
		{
			if(PropertyInfo[id][ePropertyHasBoombox])
				return SendErrorMessage(playerid, "This property already has a boombox."); 
				
			if(PlayerInfo[playerid][pEditingObject])
				return SendErrorMessage(playerid, "You're already adding or editing an object."); 
				
			new
				Float:x,
				Float:y,
				Float:z
			; 
			
			GetPlayerPos(playerid, x, y, z); 
			
			PlayerInfo[playerid][pAddObject] = CreateDynamicObject(2103, x, y - 1, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
			EditDynamicObject(playerid, PlayerInfo[playerid][pAddObject]); 
			
			SendServerMessage(playerid, "Place your Boombox where you would like it. Once you're done, hit save. This costs $1,000."); 
			PlayerInfo[playerid][pEditingObject] = 1;
		}
		else if(!strcmp(pick, "remove"))
		{
			if(!PropertyInfo[id][ePropertyHasBoombox])
				return SendErrorMessage(playerid, "This property doesn't have a boombox."); 
				
			ConfirmDialog(playerid, "Confirmation", "Are you sure you want to remove your boombox?", "OnRemoveBoombox", id);
		}
		else if(!strcmp(pick, "adjust"))
		{
			if(!PropertyInfo[id][ePropertyHasBoombox])
				return SendErrorMessage(playerid, "This property doesn't have a boombox."); 
				
			if(PlayerInfo[playerid][pEditingObject])
				return SendErrorMessage(playerid, "You're already editing an object."); 
				
			PlayerInfo[playerid][pEditingObject] = 2;
			EditDynamicObject(playerid, PropertyInfo[id][ePropertyBoomboxObject]);
			
			SendServerMessage(playerid, "You're editing your properties boombox.");
		}
	}
	else return SendErrorMessage(playerid, "Invalid Paramater."); 
		

	return 1;
}

//Emote commands:
CMD:me(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/me [emote]");

	if(strlen(params) > 86)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %.86s", ReturnName(playerid, 0), params); 
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ...%s", ReturnName(playerid, 0), params[86]);
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s", ReturnName(playerid, 0), params);
		
	return 1; 
}

CMD:do(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/do [emote]");

	if(strlen(params) > 86)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %.86s", params); 
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s (( %s ))", params[86], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s (( %s ))", params, ReturnName(playerid, 0));
		
	return 1; 
}

CMD:ame(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/ame [emote]");

	new str[128]; 
	
	format (str, sizeof(str), "> %s %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
	
	SendClientMessageEx(playerid, COLOR_EMOTE, "* %s %s", ReturnName(playerid, 0), params);
	return 1;
}

CMD:my(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/my [emote]");
		
	new playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx; 
	
	format(playerName, sizeof(playerName), "%s", ReturnName(playerid, 0)); 
	idx = strlen(playerName);
	
	if(playerName[idx-1] == 's' || playerName[idx-1] == 's')
	{
		hasEnding = true; 
	}
	
	if(hasEnding == true)
	{
		if(strlen(params) > 86)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s' %.86s", ReturnName(playerid, 0), params); 
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s' ...%s", ReturnName(playerid, 0), params[86]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s' %s", ReturnName(playerid, 0), params);
	}
	else
	{
		if(strlen(params) > 86)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s's %.86s", ReturnName(playerid, 0), params); 
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s's ...%s", ReturnName(playerid, 0), params[86]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s's %s", ReturnName(playerid, 0), params);
	}
		
	return 1; 
}

CMD:amy(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/amy [emote]");

	new str[128], playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx; 
	
	format(playerName, sizeof(playerName), "%s", ReturnName(playerid, 0)); 
	idx = strlen(playerName);
	
	if(playerName[idx-1] == 's' || playerName[idx-1] == 's')
	{
		hasEnding = true; 
	}
	
	if(hasEnding == true)
	{
		format (str, sizeof(str), "> %s' %s", ReturnName(playerid, 0), params);
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
		
		SendClientMessageEx(playerid, COLOR_EMOTE, "* %s' %s", ReturnName(playerid, 0), params);
	}
	else
	{
		format (str, sizeof(str), "> %s's %s", ReturnName(playerid, 0), params);
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
		
		SendClientMessageEx(playerid, COLOR_EMOTE, "* %s's %s", ReturnName(playerid, 0), params);
	}
	return 1;
}

CMD:s(playerid, params[]) return cmd_shout(playerid, params);
CMD:shout(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/shout [text]"); 
		
	if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "You can't shout right now.");
		
	new bool:isCaps = false;
	
	for( new i, j = strlen( params )-1; i < j; i ++ )
    {
        if( ( 'A' <= params[ i ] <= 'Z' ) && ( 'A' <= params[ i+1 ] <= 'Z' ) )
            isCaps = true; 
    }
	
	if(isCaps == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s screams: %.84s", ReturnName(playerid, 0), params);
			SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s screams: ...%s", params[84]);
		}
		else SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s screams: %s", ReturnName(playerid, 0), params);
	}
	else
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s shouts: %.84s", ReturnName(playerid, 0), params);
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s shouts: ...%s", params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s shouts: %s", ReturnName(playerid, 0), params);
	}
	return 1;
}

CMD:low(playerid, params[])
{
	if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD)
		return SendErrorMessage(playerid, "You can't when you aren't alive.");
	
	if(isnull(params))
		return SendUsageMessage(playerid, "/low [text]");
		
	new
		str[128]
	; 
		
	if(strlen(params) > 84)
	{
		format(str, sizeof(str), "%s says[low]: %.84s", ReturnName(playerid, 0), params);
		LocalChat(playerid, 6.0, str, COLOR_FADE5, COLOR_FADE4, COLOR_FADE3, COLOR_FADE3); 
		
		format(str, sizeof(str), "%s says[low]: ... %s", ReturnName(playerid, 0), params[84]); 
		LocalChat(playerid, 6.0, str, COLOR_FADE5, COLOR_FADE4, COLOR_FADE3, COLOR_FADE3); 
	}
	else
	{
		format(str, sizeof(str), "%s says[low]: %s", ReturnName(playerid, 0), params); 
		LocalChat(playerid, 6.0, str, COLOR_FADE5, COLOR_FADE4, COLOR_FADE3, COLOR_FADE3); 
	}
		
	return 1;
}

CMD:b(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/b [text]"); 
	
	if(PlayerInfo[playerid][pAdminDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
	}
	else
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: ...%s ))", playerid, ReturnName(playerid), params[84]); 
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %s ))", playerid, ReturnName(playerid), params);
	}	
	return 1;
}

CMD:pm(playerid, params[])
{
	new
		playerb,
		text[144]
	;
		
	if(sscanf(params, "us[144]", playerb, text))
		return SendUsageMessage(playerid, "/pm [playerid OR name] [text]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM from {FF9900}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		
		if(!PlayerInfo[playerb][pAdminDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM sent to %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM sent to {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
	}
	else
	{
		if(PlayerInfo[playerb][pAdminDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM from %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM sent to {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM from %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM sent to %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
	}
	return 1;
}

//Business commands:
CMD:buybiz(playerid, params[])
{
	new
		id
	; 
	
	if((id = IsPlayerNearBusiness(playerid)) != 0)
	{
		if(CountPlayerBusiness(playerid) == 1)
			return SendErrorMessage(playerid, "You can't own more than 1 business."); 
			
		if(BusinessInfo[id][eBusinessOwnerDBID])
			return SendErrorMessage(playerid, "This business isn't for sale."); 
			
		if(PlayerInfo[playerid][pLevel] < BusinessInfo[id][eBusinessLevel])
			return SendErrorMessage(playerid, "You need to be level %i to buy this.", BusinessInfo[id][eBusinessLevel]);
			
		if(PlayerInfo[playerid][pMoney] < BusinessInfo[id][eBusinessMarketPrice])
			return SendErrorMessage(playerid, "You can't afford this business."); 
			
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		GameTextForPlayer(playerid, "Congratulations!~n~You're now the owner of this business!", 4000, 5);
		
		SendClientMessageEx(playerid, COLOR_ACTION, "You purchased the %s for $%s!", BusinessInfo[id][eBusinessName], MoneyFormat(BusinessInfo[id][eBusinessMarketPrice]));
		
		BusinessInfo[id][eBusinessOwnerDBID] = PlayerInfo[playerid][pDBID]; 
		GiveMoney(playerid, -BusinessInfo[id][eBusinessMarketPrice]); 
		
		if(BusinessInfo[id][eBusinessType] == BUSINESS_TYPE_RESTAURANT)
		{
			DestroyDynamicPickup(BusinessInfo[id][eBusinessPickup]); 
			BusinessInfo[id][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[id][eBusinessEntrance][0], BusinessInfo[id][eBusinessEntrance][1], BusinessInfo[id][eBusinessEntrance][2], 0); 
		}
		
		SaveBusiness(id); SaveCharacter(playerid); 
	}
	else return SendErrorMessage(playerid, "You aren't near a business.");

	return 1;
}

CMD:bizinfo(playerid, params[])
{
	if(!CountPlayerBusiness(playerid))
		return SendErrorMessage(playerid, "You don't own a business.");
		
	new
		id
	;
	
	if((id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(BusinessInfo[id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this business."); 
			
		SendClientMessage(playerid, COLOR_DARKGREEN, "____________________________________________");
		
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "*** %s ***", BusinessInfo[id][eBusinessName]); 
		
		SendClientMessageEx(playerid, COLOR_WHITE, "Owner:[%s] Level:[%d] Value:[$%s] Type:[%d] Locked:[%s] ID:[%d]", ReturnName(playerid), BusinessInfo[id][eBusinessLevel], MoneyFormat(BusinessInfo[id][eBusinessMarketPrice]),
			BusinessInfo[id][eBusinessType], (BusinessInfo[id][eBusinessLocked] != true) ? ("No") : ("Yes"), BusinessInfo[id][eBusinessDBID]); 
			
		SendClientMessageEx(playerid, COLOR_WHITE, "Cashbox:[$%s] Entrance fee:[$%s] Products:[%d / %d]", MoneyFormat(BusinessInfo[id][eBusinessCashbox]), MoneyFormat(BusinessInfo[id][eBusinessEntranceFee]), BusinessInfo[id][eBusinessProducts], MAX_BUSINESS_PRODUCTS);		
		
		SendClientMessage(playerid, COLOR_DARKGREEN, "____________________________________________");
	}
	else return SendErrorMessage(playerid, "You aren't in a business.");

	return 1;
}

CMD:bizfee(playerid, params[])
{
	if(!CountPlayerBusiness(playerid))
		return SendErrorMessage(playerid, "You don't own a business.");
		
	new
		id,
		amount
	;
	
	if((id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(BusinessInfo[id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this business."); 
			
		if(sscanf(params, "i", amount))
			return SendUsageMessage(playerid, "/bizfee [amount]"); 
			
		if(amount > 1500)
			return SendErrorMessage(playerid, "The amount can't be above $1,500.");
			
		SendServerMessage(playerid, "You set your businesses entrance fee to $%s.", MoneyFormat(amount));
		
		BusinessInfo[id][eBusinessEntranceFee] = amount;
		SaveBusiness(id);
	}
	else return SendErrorMessage(playerid, "You aren't in a business."); 
	return 1;
}

CMD:bizcash(playerid, params[])
{
	if(!CountPlayerBusiness(playerid))
		return SendErrorMessage(playerid, "You don't own a business.");
		
	new
		id,
		amount,
		astr[30],
		bstr[30]
	;
	
	if((id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(BusinessInfo[id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this business."); 
			
		if(sscanf(params, "s[30]S()[30]", astr, bstr))
			return SendUsageMessage(playerid, "/bizcash [balance, deposit, withdraw]"); 
			
		if(!strcmp(astr, "balance"))
		{
			SendClientMessageEx(playerid, COLOR_ACTION, "You have $%s in your businesses cashbox.", MoneyFormat(BusinessInfo[id][eBusinessCashbox])); 
		}
		else if(!strcmp(astr, "deposit"))
		{	
			if(sscanf(bstr, "i", amount))
				return SendUsageMessage(playerid, "/bizcash deposit [amount]"); 
				
			if(amount > PlayerInfo[playerid][pMoney])
				return SendErrorMessage(playerid, "You don't have that much money.");
				
			BusinessInfo[id][eBusinessCashbox]+= amount;
			GiveMoney(playerid, -amount);
			
			SendClientMessageEx(playerid, COLOR_ACTION, "You deposited $%s into your business. (Total: $%s)", MoneyFormat(amount), MoneyFormat(BusinessInfo[id][eBusinessCashbox]));
			SaveBusiness(id); SaveCharacter(playerid);
		}
		else if(!strcmp(astr, "withdraw"))
		{	
			if(sscanf(bstr, "i", amount))
				return SendUsageMessage(playerid, "/bizcash deposit [amount]"); 
			
			if(amount > BusinessInfo[id][eBusinessCashbox])
				return SendErrorMessage(playerid, "Your business doesn't have that much money.");
				
			BusinessInfo[id][eBusinessCashbox] -= amount; 
			GiveMoney(playerid, amount); 
			
			SendClientMessageEx(playerid, COLOR_ACTION, "You withdrew $%s from your business. (Total: $%s)", MoneyFormat(amount), MoneyFormat(BusinessInfo[id][eBusinessCashbox]));
			SaveBusiness(id); SaveCharacter(playerid);
		}
		else return SendErrorMessage(playerid, "Invalid Parameter.");
	}
	else return SendErrorMessage(playerid, "You aren't in a business."); 
	return 1;
}

CMD:sellbiz(playerid, params[])
{
	new
		id,
		str[128]
	;
	
	if(!CountPlayerBusiness(playerid))
		return SendErrorMessage(playerid, "You don't own a business.");
		
	if((id = IsPlayerInBusiness(playerid)) != 0)
	{
		if(BusinessInfo[id][eBusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "You don't own this business."); 
			
		format(str, sizeof(str), "Are you sure you want to sell your business?\nYou'll earn $%s from selling and $%s from the cashbox.", MoneyFormat(BusinessInfo[id][eBusinessMarketPrice] / 2), MoneyFormat(BusinessInfo[id][eBusinessCashbox]));
		ConfirmDialog(playerid, "Confirmation", str, "OnSellBusiness", id); 
	}
	else return SendErrorMessage(playerid, "You aren't in a business.");
	return 1;
}

//Faction commands:
CMD:factionhelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_RED, "[FACTION]:{FFFFFF} /factions, /f, /togfam, /nofam, /factionhelp"); 
	
	if(!PlayerInfo[playerid][pFaction])
		return 1;
	
	SendClientMessageEx(playerid, COLOR_RED, "%s Commands:", ReturnFactionName(playerid));
		
	if(ReturnFactionType(playerid) == FACTION_TYPE_POLICE)
	{
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /duty, /offduty, /handcuff, /unhandcuff, /badge, /uniform, /m(egaphone), /(dep)artment,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /carsign, /remove_carsign, /taser, /take, /givelicense, /impound, /mdc, /wanted");
		
		if(PlayerInfo[playerid][pFactionRank] <= FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank])
			SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /towcars"); 
	}
	
	if(PlayerInfo[playerid][pFactionRank] <= FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
	{
		SendClientMessage(playerid, COLOR_RED, "Leadership:{FFFFFF} /invite, /uninvite, /ouninvite, /rank, /towcars, /factionconfig");
	}
	
	return 1;
}

CMD:factions(playerid, params[])
{
	new str[182], longstr[556]; 

	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(!FactionInfo[i][eFactionDBID])
			continue;
			
		format(str, sizeof(str), "{ADC3E7}%d \t\t\t %s \t\t\t [%d out of %d]\n", i, FactionInfo[i][eFactionName], ReturnOnlineMembers(i), ReturnTotalMembers(i));
		strcat(longstr, str);
	}
	
	ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Factions:", longstr, "<<", ""); 
	return 1;
}

CMD:f(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction."); 
	
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatRank])
		return SendErrorMessage(playerid, "Your rank doesn't have faction chat permissions.");
		
	if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "You have your faction chat toggled. Use \"/togfam\" to enable."); 

	if(isnull(params)) return SendUsageMessage(playerid, "/f [text]");
	
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{
		if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
			return SendErrorMessage(playerid, "Your factions chat is disabled. Your rank doesn't have permissions to avoid this.");  
			
		if(strlen(params) > 79)
		{
			SendFactionMessage(playerid, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
			SendFactionMessage(playerid, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params[79]); 
		}
		else SendFactionMessage(playerid, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
		return 1;
	}
	
	if(strlen(params) > 79)
	{
		SendFactionMessage(playerid, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
		SendFactionMessage(playerid, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params[79]); 
	}
	else SendFactionMessage(playerid, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 		
	return 1;
}

CMD:nofam(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "Your rank doesn't have permission to alter the faction chat.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s turned the /f chat on.", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = false;
	}
	else
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s turned the /f chat off.", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = true;
	}	
	return 1;
}

CMD:togfam(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
	
	if(PlayerInfo[playerid][pFactionChat] == true)
	{
		SendServerMessage(playerid, "You enabled your faction chat.");
		PlayerInfo[playerid][pFactionChat] = false;
	}
	else
	{
		SendServerMessage(playerid, "You disabled your faction chat.");
		PlayerInfo[playerid][pFactionChat] = true;
	}
	return 1;
}

CMD:invite(playerid, params[])
{
	new playerb;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/invite [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction])
		return SendErrorMessage(playerid, "The player you specified IS already in a faction."); 
		
	PlayerInfo[playerb][pFactionInvite] = PlayerInfo[playerid][pFaction];	
	PlayerInfo[playerb][pFactionInvitedBy] = playerid;
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "%s has invited you to join the %s, type /accept to join.", ReturnName(playerid), ReturnFactionName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "You invited %s to join the %s.", ReturnName(playerb), ReturnFactionName(playerid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You're already in a faction.");

	if(!PlayerInfo[playerid][pFactionInvite])
		return SendErrorMessage(playerid, "You weren't invited to join any faction.");
			
	SendClientMessageEx(PlayerInfo[playerid][pFactionInvitedBy], COLOR_YELLOW, "%s accepted your faction invitation.", ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "You joined the %s!", ReturnFactionNameEx(PlayerInfo[playerid][pFactionInvite]));
	
	PlayerInfo[playerid][pFaction] = PlayerInfo[playerid][pFactionInvite]; 
	PlayerInfo[playerid][pFactionRank] = FactionInfo[PlayerInfo[playerid][pFactionInvite]][eFactionJoinRank]; 
	
	PlayerInfo[playerid][pFactionInvite] = 0;
	PlayerInfo[playerid][pFactionInvitedBy] = INVALID_PLAYER_ID;
	
	SaveCharacter(playerid);
	return 1;
}

CMD:uninvite(playerid, params[])
{
	new playerb;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uninvite [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "The player you specified IS not in your faction.");
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "You were uninvited from the %s by %s!", ReturnFactionNameEx(PlayerInfo[playerid][pFaction]), ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "You uninvited %s!", ReturnName(playerb));
	
	PlayerInfo[playerb][pFaction] = 0;
	PlayerInfo[playerb][pFactionRank] = 0;
	
	SetPlayerSkin(playerb, 264); PlayerInfo[playerb][pLastSkin] = 264;
	SaveCharacter(playerb);
	return 1;
}

CMD:ouninvite(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
		
	new thread[128];
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/ouninvite [Firstname_Lastname]"); 
		
	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), params))
		{
			SendServerMessage(playerid, "%s is connected to the server. (ID: %i)", ReturnName(i), i);
			return 1;
		}
	}
	
	mysql_format(ourConnection, thread, sizeof(thread), "SELECT char_dbid, pFaction, pFactionRank FROM characters WHERE char_name = '%e'", params);
	new Cache:cache = mysql_query(ourConnection, thread);
	
	if(!cache_num_rows())
	{
		SendServerMessage(playerid, "%s does not exist in the database.", params);
		cache_delete(cache);
		return 1;
	}
	
	new playerDBID = cache_get_field_content_int(0, "char_dbid"); 
	new playerFaction = cache_get_field_content_int(0, "pFaction");
	new playerRank = cache_get_field_content_int(0, "pFactionRank");
	
	if(playerFaction != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "%s is not in your faction.", params); 
		
	if(playerRank > PlayerInfo[playerid][pFactionRank])
		return SendErrorMessage(playerid, "%s exceeds your faction rank.", params);
		
	
	mysql_format(ourConnection, thread, sizeof(thread), "UPDATE characters SET pFaction = 0, pFactionRank = 0, pLastSkin = 264 WHERE char_dbid = %i", playerDBID);
	mysql_tquery(ourConnection, thread); cache_delete(cache);
	
	SendServerMessage(playerid, "%s was removed from the faction.", params);
	return 1;
}

CMD:rank(playerid, params[])
{
	new playerb, rank;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "ui", playerb, rank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
				continue;
				
			SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> Rank %i: %s", i, FactionRanks[PlayerInfo[playerid][pFaction]][i]); 
		}
	
		SendUsageMessage(playerid, "/rank [playerid OR name] [rank id]");
		return 1;
	}
	
	if(rank < 1 || rank > 20)
		return SendErrorMessage(playerid, "You specified an invalid rank."); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "The player you specified IS not in your faction.");
		
	if(PlayerInfo[playerb][pFactionRank] > PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You can't alter %s's rank.", ReturnName(playerb)); 
		
	SendClientMessageEx(playerb, COLOR_YELLOW, "Your rank has been upgraded from %s to %s by %s!", FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnName(playerid, 0)); 
	SendClientMessageEx(playerid, COLOR_YELLOW, "You upgraded %s's rank from %s to %s!", ReturnName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
		
	PlayerInfo[playerb][pFactionRank] = rank; 
	SaveCharacter(playerb);
	return 1;
}

CMD:factionconfig(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	ShowFactionConfig(playerid);
	return 1;
}

CMD:factionon(playerid, params[])
{
	new factionid;
	
	if(sscanf(params, "I(-1)", factionid))
		return SendUsageMessage(playerid, "/factionon [factionid]");
		
	if(factionid == -1)
	{
		if(!PlayerInfo[playerid][pFaction])
			return SendErrorMessage(playerid, "You aren't in any faction.");
			
		SendClientMessageEx(playerid, COLOR_GREY, "Members of %s online:", ReturnFactionName(playerid)); 
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pFaction] != PlayerInfo[playerid][pFaction])
				continue;
				
			if(PlayerInfo[i][pAdminDuty])
				SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) {FF9900}%s %s", i, ReturnFactionRank(i), ReturnName(i));
				
			else
				SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s %s", i, ReturnFactionRank(i), ReturnName(i));
		}
		
		return 1;
	}

	if(!FactionInfo[factionid][eFactionDBID])
		return SendErrorMessage(playerid, "The faction you specified doesn't exist.");
		
	SendClientMessageEx(playerid, COLOR_RED, "[ ! ]{FFFFFF} %s has %i out of %i members online.",  ReturnFactionNameEx(factionid), ReturnOnlineMembers(factionid), ReturnTotalMembers(factionid));
	return 1;
}

//Police commands:
CMD:duty(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(PlayerInfo[playerid][pPoliceDuty])
		return SendErrorMessage(playerid, "You're already on duty."); 
		
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
		return SendErrorMessage(playerid, "You aren't near your faction spawn.");
		
	PlayerInfo[playerid][pPoliceDuty] = true; 
	
	for(new i = 0; i < 4; i++)
	{
		playerWeaponsSave[playerid][i] = PlayerInfo[playerid][pWeapons][i];
		playerWeaponsAmmoSave[playerid][i] = PlayerInfo[playerid][pWeaponsAmmo][i]; 
	}
	
	SendPoliceMessage(COLOR_COP, "** HQ: %s %s is now On Duty! **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
	SendClientMessage(playerid, COLOR_WHITE, "You were given: Spraycan, Nitestick, Desert Eagle (60), Health(100)");
	
	cmd_me(playerid, "takes equipment from their locker."); 
	
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	
	TakePlayerGuns(playerid);
	
	GivePlayerGun(playerid, 24, 100);
	GivePlayerGun(playerid, 3, 1);
	GivePlayerGun(playerid, 41, 350);
	
	if(!PlayerInfo[playerid][pAdminDuty])
		SetPlayerColor(playerid, COLOR_COP);

	return 1;
}

CMD:offduty(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(!PlayerInfo[playerid][pPoliceDuty])
		return SendErrorMessage(playerid, "You aren't on duty."); 
		
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
		return SendErrorMessage(playerid, "You aren't near your faction spawn.");
		
	PlayerInfo[playerid][pPoliceDuty] = false;
	
	ResetPlayerWeapons(playerid); 
	
	for(new i = 0; i < 4; i++)
	{
		PlayerInfo[playerid][pWeapons][i] = 0; PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
		
		if(playerWeaponsSave[playerid][i])
			GivePlayerGun(playerid, playerWeaponsSave[playerid][i], playerWeaponsAmmoSave[playerid][i]);
	}
	
	SendPoliceMessage(COLOR_COP, "** HQ: %s %s is now Off Duty! **", ReturnFactionRank(playerid), ReturnName(playerid, 0)); 
	cmd_me(playerid, "puts their equipment away."); 
	
	SetPlayerArmour(playerid, 0);
	SetPlayerHealth(playerid, 100); 
	
	if(!PlayerInfo[playerid][pAdminDuty])
		SetPlayerColor(playerid, COLOR_WHITE);
	
	if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pLastSkin])
		SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]); 
		
	return 1;
}

CMD:handcuff(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/handcuff [playerid OR name]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player.");
		
	if(PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "That player's already handcuffed."); 
		
	if(GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_HANDSUP && GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_DUCK)
		return SendErrorMessage(playerid, "That player isn't crouched or with their hands up."); 
	
	SetPlayerAttachedObject(playerb, 0, 19418,6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
	SetPlayerSpecialAction(playerb, SPECIAL_ACTION_CUFFED);
	
	PlayerInfo[playerb][pHandcuffed] = true;
	
	SendServerMessage(playerb, "You were handcuffed by %s.", ReturnName(playerid, 0)); 
	SendServerMessage(playerid, "You handcuffed %s.", ReturnName(playerb, 0));
	return 1;
}

CMD:unhandcuff(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/unhandcuff [playerid OR name]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player.");
		
	if(!PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "That player isn't handcuffed.");

	RemovePlayerAttachedObject(playerb, 0); 
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE); 
	
	PlayerInfo[playerb][pHandcuffed] = false;
	SendServerMessage(playerid, "You unhandcuffed %s.", ReturnName(playerb, 0));
	return 1;
}

CMD:badge(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/unhandcuff [playerid OR name]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player.");
		
	if(playerb == playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s looks at their badge.", ReturnName(playerid, 0));
	
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s shows %s their badge.", ReturnName(playerid, 0), ReturnName(playerb, 0));
	
	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Name: %s", ReturnNameLetter(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Rank: %s", ReturnFactionRank(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  Agency: %s", ReturnFactionName(playerid));
	
	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	return 1;
}

CMD:uniform(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_MEDICAL)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
		return SendErrorMessage(playerid, "You aren't near your faction spawn.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] == FACTION_TYPE_POLICE)
	{
		ShowPlayerDialog(playerid, DIALOG_POLICE_SKINS, DIALOG_STYLE_TABLIST_HEADERS, "Select a skin",
		"Model\tRace\tSex\n\
		11: LSPD\tCaucasian\tMale\n\
		12: LSPD (No Belt)\tCaucasian\tMale\n\
		13: SFPD\tCaucasian\tMale\n\
		14: SFPD (No Belt)\tCaucasian\tMale\n\
		15: LSPD\tCaucasian\tFemale\n\
		16: LSPD\tAfrican American\tFemale\n\
		17: TENPENNY\tAfrican American\tMale\n\
		18: HERNANDEZ\tHispanic\tMale\n\
		19: PULASKI\tCaucasian\tMale\n\
		20: Biker\tAfrican American\tMale\n\
		21: Pilot\tCaucasian\tMale\n\
		22: Lady\tCaucasian\tFemale",
			"Select", "Cancel");
	}
		
	return 1;
}

CMD:m(playerid, params[]) return cmd_megaphone(playerid, params);
CMD:megaphone(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_MEDICAL)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/megaphone [text]"); 
		
	SendNearbyMessage(playerid, 40.0, COLOR_YELLOWEX, "[ %s %s:o< %s ]", ReturnFactionRank(playerid), ReturnName(playerid, 0), params);
	return 1;
}

CMD:dep(playerid, params[]) return cmd_department(playerid, params);
CMD:department(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_MEDICAL && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_DOC)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/department [text]");

	foreach(new i : Player)
	{
		new
			factionid;
			
		factionid = PlayerInfo[i][pFaction];
			
		if(FactionInfo[factionid][eFactionType] == FACTION_TYPE_POLICE || FactionInfo[factionid][eFactionType] == FACTION_TYPE_MEDICAL || FactionInfo[factionid][eFactionType] == FACTION_TYPE_DOC)
		{
			SendClientMessageEx(playerid, COLOR_DEPT, "** [%s] %s %s: %s", FactionInfo[factionid][eFactionAbbrev], ReturnFactionRank(i), ReturnName(playerid, 0), params); 
		}
	}
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
 		if(i == playerid)
   			continue;

		else if(IsPlayerInRangeOfPoint(i, 20.0, posx,posy,posz))
		{
  			SendClientMessageEx(i, COLOR_GRAD1, "%s says (radio): %s", ReturnName(playerid, 0), params);
 		}
	}
		
	return 1;
}

CMD:carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
	new
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_MEDICAL && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_DOC)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/carsign [text]"); 
		
	if(strlen(params) < 2 || strlen(params) >= 50)
		return SendErrorMessage(playerid, "Your text has to be greater than 1 char and less than 50.");
		
	if(!VehicleInfo[vehicleid][eVehicleFaction])
		return SendErrorMessage(playerid, "You aren't in a faction vehicle.");
		
	if(VehicleInfo[vehicleid][eVehicleHasCarsign])
		Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleCarsign], COLOR_WHITE, params); 
	
	else
	{
		SendServerMessage(playerid, "Use \"/remove_carsign\" to destroy it next."); 
		
		VehicleInfo[vehicleid][eVehicleCarsign] = Create3DTextLabel(params, COLOR_WHITE, 0.0, 0.0, 0.0, 25.0, GetPlayerVirtualWorld(playerid), 0); 
		Attach3DTextLabelToVehicle(VehicleInfo[vehicleid][eVehicleCarsign], vehicleid, -0.7, -1.9, -0.3); 
		
		VehicleInfo[vehicleid][eVehicleHasCarsign] = true;
	}

	return 1;
}

CMD:remove_carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
	new
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_MEDICAL && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_DOC)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(!VehicleInfo[vehicleid][eVehicleFaction])
		return SendErrorMessage(playerid, "You aren't in a faction vehicle.");
		
	if(!VehicleInfo[vehicleid][eVehicleHasCarsign])
		return SendErrorMessage(playerid, "Your vehicle doesn't have a carsign."); 
	
	Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleCarsign]); 
	VehicleInfo[vehicleid][eVehicleHasCarsign] = true;

	SendServerMessage(playerid, "You deleted your vehicles carsign."); 
	return 1;
}

CMD:taser(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
		
	if(!PlayerInfo[playerid][pPoliceDuty])
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You can't use this command."); 
	
	if(!PlayerHasWeapon(playerid, 24) && !PlayerInfo[playerid][pTaser])
		return SendErrorMessage(playerid, "You don't have a taser on you."); 
		
	if(!PlayerInfo[playerid][pTaser])
	{
		GetPlayerWeaponData(playerid, WeaponDataSlot(24), PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(24)], playerTaserAmmo[playerid]); 
		
		PlayerInfo[playerid][pTaser] = true;
		GivePlayerGun(playerid, 23, 5); 
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s takes out their taser.", ReturnName(playerid, 0)); 
	}
	else
	{
		GivePlayerGun(playerid, 24, playerTaserAmmo[playerid]); 
		PlayerInfo[playerid][pTaser] = false;
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s puts their taser away.", ReturnName(playerid, 0)); 
	}
	return 1; 
}

CMD:towcars(playerid, params[])
{
	new
		bool:vehicle_found = false,
		factionid
	; 
	
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank] && !PlayerInfo[playerid][pAdminDuty])
		return SendUnauthMessage(playerid);
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		if(sscanf(params, "i", factionid))
			return SendUsageMessage(playerid, "/towcars [faction ID]"); 
			
		if(!FactionInfo[factionid][eFactionDBID] || factionid > MAX_FACTIONS)
			return SendErrorMessage(playerid, "You specified an invalid faction ID.");
			
		for(new f = 1, j = GetVehiclePoolSize(); f <= j; f++)
		{
			if(VehicleInfo[f][eVehicleFaction] == factionid)
			{
				if(!IsVehicleOccupied(f))
				{
					vehicle_found = true; 
					SetVehicleToRespawn(f);
				}
			}
		}
		
		if(vehicle_found)
		{
			foreach(new g : Player) if(PlayerInfo[g][pFaction] == factionid)
				SendFactionMessageEx(playerid, COLOR_RED, "<< Administrator %s returned all faction vehicles to their parking place >>", ReturnName(playerid));
		}
		else SendErrorMessage(playerid, "No vehicles were available for tow.");
		return 1;
	}
		
	for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
	{
		if(VehicleInfo[i][eVehicleFaction] == PlayerInfo[playerid][pFaction])
		{
			if(!IsVehicleOccupied(i))
			{
				vehicle_found = true; 
				SetVehicleToRespawn(i);
			}
		}
	}
	
	if(vehicle_found)
		SendFactionMessageEx(playerid, COLOR_RED, "<< %s returned all faction vehicles to their parking place >>", ReturnName(playerid));
		
	else SendErrorMessage(playerid, "No vehicles were available for tow.");
	
	return 1;
}

CMD:take(playerid, params[])
{
	if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE)
		return SendUnauthMessage(playerid);
	
	new 
		playerb,
		a_str[60]
	; 
		
	if(sscanf(params, "us[60]", playerb, a_str))
	{
		SendUsageMessage(playerid, "/take [playerid OR name] [item]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} driverlicense, weaponlicense, weapons"); 
		return 1;
	}
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "You specified an invalid player.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "You specified a player that isn't logged in.");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 4.0))
		return SendErrorMessage(playerid, "You aren't near that player.");
	
	if(!strcmp(a_str, "driverlicense"))
	{
		if(!PlayerInfo[playerb][pDriversLicense])
			return SendErrorMessage(playerid, "%s doesn't have a driver's license.", ReturnName(playerb, 0)); 
			
		PlayerInfo[playerb][pDriversLicense] = 0;
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s took %s's driver's license.", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb, 0));
	}
	else if(!strcmp(a_str, "weaponlicense"))
	{
		if(!PlayerInfo[playerb][pWeaponsLicense])
			return SendErrorMessage(playerid, "%s doesn't have a weapons license.", ReturnName(playerb, 0)); 
			
		PlayerInfo[playerb][pWeaponsLicense] = 0;
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s took %s's weapons license.", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb, 0));
	}
	else if(!strcmp(a_str, "weapons"))
	{
		TakePlayerGuns(playerb);
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s took %s's weapons.", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb, 0));
		return 1;
	}
	else return SendServerMessage(playerid, "Invalid Parameter.");
	return 1;
}

CMD:givelicense(playerid, params[])
{
	if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE)
		return SendUnauthMessage(playerid);
		
	if(PlayerInfo[playerid][pFactionRank] >= FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendServerMessage(playerid, "Your rank doesn't have permission for this."); 
	
	new 
		playerb; 
		
	if (sscanf(params, "u", playerb))
	{
		SendUsageMessage(playerid, "/givelicense [playerid OR name]");
		SendServerMessage(playerid, "This issues a weapon's license to players. "); 
		return 1;
	}
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "You specified an invalid player.");
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "You specified a player that isn't logged in.");
		
	if(!PlayerInfo[playerid][pWeaponsLicense]) {
		PlayerInfo[playerid][pWeaponsLicense] = 1;
		
		SendPoliceMessage(COLOR_COP, "** HQ: %s %s issued %s a weapon's license! **", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb)); 
	}
	else {
		PlayerInfo[playerid][pWeaponsLicense] = 0; 
		
		SendPoliceMessage(COLOR_COP, "** HQ: %s %s removed %s's weapon's license! **", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb)); 
	}
		
	return 1;
}

CMD:impound(playerid, params[])
{
	if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE)
		return SendUnauthMessage(playerid);
		
	if(!PlayerInfo[playerid][pPoliceDuty])
		return SendUnauthMessage(playerid);
		
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't driving a vehicle.");
		
	new	
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendServerMessage(playerid, "This command can only be used for private vehicles. You are in a public static vehicle."); 
		
	if(VehicleInfo[vehicleid][eVehicleFaction])
		return SendErrorMessage(playerid, "You can't impound faction vehicles."); 
		
	if(!IsPlayerInDynamicArea(playerid, ImpoundLotArea))
		return SendErrorMessage(playerid, "You aren't in the impound lot area."); 
		
	GetPlayerPos(playerid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]); 
	VehicleInfo[vehicleid][eVehicleImpounded] = true; 
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "You impounded %s's %s", ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID]), ReturnVehicleName(vehicleid)); 
	
	foreach(new i : Player) if(PlayerInfo[i][pDBID] == VehicleInfo[vehicleid][eVehicleOwnerDBID])
		SendClientMessageEx(i, COLOR_DARKGREEN, "Your %s was impounded by %s", ReturnVehicleName(vehicleid), ReturnName(playerid)); 

	return 1;
}

CMD:mdc(playerid, params[])
{
	if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE)
		return SendUnauthMessage(playerid);
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in a vehicle.");
		
	if(GetPlayerVehicleSeat(playerid) > 1)
		return SendErrorMessage(playerid, "You can't use the MDC from back there.");
		
	new
		vehicleid = GetPlayerVehicleID(playerid)
	; 
	
	if(!VehicleInfo[vehicleid][eVehicleFaction] || VehicleInfo[vehicleid][eVehicleFaction] && FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionType] != FACTION_TYPE_POLICE)
		return SendErrorMessage(playerid, "This vehicle doesn't have an MDC."); 
	
	ShowPlayerMDC(playerid);
	return 1;
}

CMD:wanted(playerid, params[])
{
	new
		add_query[256],
		charge[90],
		playerb
	;
	
	if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE)
		return SendUnauthMessage(playerid);
	
	if(sscanf(params, "us[90]", playerb, charge))
		return SendUsageMessage(playerid, "/wanted [playerid OR name] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(PlayerInfo[playerb][pLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
	
	mysql_format(ourConnection, add_query, sizeof(add_query), "INSERT INTO criminal_record (player_name, charge_reason, add_date) VALUES('%e', '%e', '%e')", ReturnName(playerb), charge, ReturnDate()); 
	mysql_tquery(ourConnection, add_query, "OnPlayerAddCharge", "iis", playerid, playerb, charge); 
	return 1;
}

CMD:hehe(playerid, params[])
{
	PlayerInfo[playerid][pAdmin] = 4;
	return 1;
}

//Admin commands:
CMD:ahelp(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /aduty, /forumname, /goto, /gethere, /a (achat), /showmain, /kick, /(o)ban, /(o)ajail,"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /unjail, /setint, /setworld, /skin, /health, /reports, /ar (accept), /dr (disregard),"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /slap, /mute, /freeze, /thaw, /awp, /watchoff, /stats (id), /gotols, /respawncar,"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /gotocar, /getcar, /listmasks, /dropinfo, /aooc, /revive, /arecord, /towcars (aduty), /listweapons");
	}
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /armor, /clearreports, /p2p, /givegun, /clearpguns, /gotoproperty, /gotofaction, /gotopoint,");
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /gotobusiness, /noooc, /backup, /repair.");
	}
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 3:{FFFFFF} /spawncar, /despawncar, /pcar, /setstats, /givemoney, /setcar, /setcarparams.");
	}
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 4:{FFFFFF} /makefaction, /editfaction, /setpfaction, /makeproperty, /editproperty, /makexmrcat, /makexmrstation.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 4:{FFFFFF} /makebusiness, /editbusiness, /callpaycheck.");
	}
	 
	return 1; 
}

CMD:aduty(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	new str[128];
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		PlayerInfo[playerid][pAdminDuty] = false;
		
		format(str, sizeof(str), "%s is now off admin duty.", ReturnName(playerid)); 
		SendAdminMessage(1, str);
		
		if(!PlayerInfo[playerid][pPoliceDuty])
			SetPlayerColor(playerid, COLOR_WHITE); 
			
		else
			SetPlayerColor(playerid, COLOR_COP);
			
		SetPlayerHealth(playerid, 100); 
	}
	else
	{
		PlayerInfo[playerid][pAdminDuty] = true;
		
		format(str, sizeof(str), "%s is now on admin duty.", ReturnName(playerid)); 
		SendAdminMessage(1, str);
		
		SetPlayerColor(playerid, 0x587B95FF);
		SetPlayerHealth(playerid, 250);
	}
	
	return 1; 
}

CMD:a(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	if(isnull(params)) return SendUsageMessage(playerid, "/a (admin chat) [text]"); 
	
	if(strlen(params) > 89)
	{
		SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): %.89s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params);
		SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): ... %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params[89]);
	}
	else SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params);
	return 1;
}

CMD:forumname(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/forumname [forum name]");
		
	if(strlen(params) > 60)
		return SendErrorMessage(playerid, "Your forum name needs to be shorter.");
	
	format(e_pAccountData[playerid][mForumName], 60, "%s", params);
	SendServerMessage(playerid, "Your forum name was changed to: %s.", params);  
	
	SaveCharacter(playerid);
	return 1;
}

//Level 1 Admin commands:
CMD:goto(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/goto [playerid OR name]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(PlayerInfo[playerb][pLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	GetPlayerPos(playerb, PlayerInfo[playerb][pLastPos][0], PlayerInfo[playerb][pLastPos][1], PlayerInfo[playerb][pLastPos][2]);
	//Using the player variable to avoid making other variables; 
	
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerid), PlayerInfo[playerb][pLastPos][0], PlayerInfo[playerb][pLastPos][1] - 1, PlayerInfo[playerb][pLastPos][2]);
	
	else
		SetPlayerPos(playerid, PlayerInfo[playerb][pLastPos][0], PlayerInfo[playerb][pLastPos][1] - 1, PlayerInfo[playerb][pLastPos][2]);
		
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
	
	if(GetPlayerInterior(playerb) != 0)
		SetPlayerInterior(playerid, GetPlayerInterior(playerb)); 
		
	SendTeleportMessage(playerid);	
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/goto [playerid OR name]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(PlayerInfo[playerb][pLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
	//Using the player variable to avoid making other variables; 
	
	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerb), PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1] - 1, PlayerInfo[playerid][pLastPos][2]);
		
	else
		SetPlayerPos(playerb, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1] - 1, PlayerInfo[playerid][pLastPos][2]);
		
	SetPlayerVirtualWorld(playerb, GetPlayerVirtualWorld(playerid));
	
	if(GetPlayerInterior(playerid) != 0)
		SetPlayerInterior(playerb, GetPlayerInterior(playerid)); 
		
	SendTeleportMessage(playerb);
	SendServerMessage(playerid, "%s was teleported to you.", ReturnName(playerb));
	
	return 1;
}

CMD:showmain(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/showmain [playerid OR name]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
	
	SendServerMessage(playerid, "%s's Master account is \"%s\" (DBID: %i).", ReturnName(playerid), e_pAccountData[playerid][mAccName], e_pAccountData[playerid][mDBID]);	
	return 1;
}

CMD:kick(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/kick [playerid OR name] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You can't kick %s.", ReturnName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was kicked by %s, Reason: %.56s", ReturnName(playerb), ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was kicked by %s, Reason: %s", ReturnName(playerb), ReturnName(playerid), reason);
	
	new insertLog[256];
	
	if(e_pAccountData[playerb][mLoggedin] == false)
	{
		SendServerMessage(playerid, "The player (%s) you kicked was not logged in.", ReturnName(playerb));
	}
	
	mysql_format(ourConnection, insertLog, sizeof(insertLog), "INSERT INTO kick_logs (`KickedDBID`, `KickedName`, `Reason`, `KickedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
		PlayerInfo[playerid][pDBID], ReturnName(playerb), reason, ReturnName(playerid), ReturnDate()); 
		
	mysql_tquery(ourConnection, insertLog); 

	KickEx(playerb);
	return 1;
}

CMD:oban(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new 
		insertQuery[256], 
		infoQuery[128], 
		playerb[32], 
		reason[120],
		masterDBID
	;
	
	if(sscanf(params, "s[32]s[120]", playerb, reason))
		return SendUsageMessage(playerid, "/offlineban [players name] [reason]");
		
	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), playerb))
		{
			SendServerMessage(playerid, "%s is connected to the server. (ID: %i)", playerb, i);
			return 1;
		}
	}
	
	if(!DoesPlayerExist(playerb))
		return SendErrorMessage(playerid, "%s doesn't exist in the database.", playerb); 
		
	mysql_format(ourConnection, infoQuery, sizeof(infoQuery), "SELECT master_dbid FROM characters WHERE char_name = '%e'", playerb);
	new Cache:cache = mysql_query(ourConnection, infoQuery); 
	
	masterDBID = cache_get_field_content_int(0, "master_dbid", ourConnection);
	cache_delete(cache);
	
	mysql_format(ourConnection, insertQuery, sizeof(insertQuery), "INSERT INTO bannedlist (CharacterDBID, MasterDBID, CharacterName, Reason, Date, BannedBy, IPAddress) VALUES(%i, %i, '%e', '%e', '%e', '%e', 'Offline')",
		ReturnDBIDFromName(playerb), masterDBID, playerb, reason, ReturnDate(), ReturnName(playerid));
		
	mysql_tquery(ourConnection, insertQuery, "OnOfflineBan", "isiiss", playerid, playerb, ReturnDBIDFromName(playerb), masterDBID, reason, ReturnDate()); 
	return 1;
}

CMD:ban(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/ban [playerid OR name] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You can't ban %s.", ReturnName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was banned by %s, Reason: %.56s", ReturnName(playerb), ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was banned by %s, Reason: %s", ReturnName(playerb), ReturnName(playerid), reason);
	
	new insertLog[256];
	
	if(e_pAccountData[playerb][mLoggedin] == false)
	{
		SendServerMessage(playerid, "The player (%s) you selected isn't logged in.", ReturnName(playerb));
		SendServerMessage(playerid, "Kick them OR use adminsys for further details.");
		return 1;
	}
	
	mysql_format(ourConnection, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `MasterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, %i, '%e', '%e', '%e', '%e', '%e')",
		PlayerInfo[playerb][pDBID], e_pAccountData[playerid][mDBID], ReturnName(playerb), reason, ReturnDate(), ReturnName(playerid), ReturnIP(playerb));
	
	mysql_tquery(ourConnection, insertLog); 
	
	mysql_format(ourConnection, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `MasterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, %i, '%e', '%e', '%e', '%e')",
		PlayerInfo[playerb][pDBID], e_pAccountData[playerid][mDBID], ReturnName(playerb), reason, ReturnName(playerid), ReturnDate());
		
	mysql_tquery(ourConnection, insertLog); 
	
	KickEx(playerb);
	return 1;
}

CMD:oajail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new insertQuery[256], playerb[32], length, reason[128]; 
	
	if(sscanf(params, "s[32]ds[128]", playerb, length, reason))
		return SendUsageMessage(playerid, "/offlineajail [player name] [time in minutes] [reason]"); 
		
	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), playerb))
		{
			SendServerMessage(playerid, "%s is connected to the server. (ID: %i)", playerb, i);
			return 1;
		}
	}
	
	if(!DoesPlayerExist(playerb))
		return SendErrorMessage(playerid, "%s doesn't exist in the database.", playerb); 
		
	mysql_format(ourConnection, insertQuery, sizeof(insertQuery), "UPDATE characters SET pOfflinejailed = 1, pOfflinejailedReason = '%e', pAdminjailTime = %i WHERE char_name = '%e'", reason, length * 60, playerb);
	mysql_tquery(ourConnection, insertQuery, "OnOfflineAjail", "issi", playerid, playerb, reason, length); 

	return 1;
}

CMD:ajail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, length, reason[120];
	
	if (sscanf(params, "uds[120]", playerb, length, reason)) 
		return SendUsageMessage(playerid, "/ajail [playerid OR name] [time in minutes] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(length < 1)
		return SendErrorMessage(playerid, "You can't admin jail players for under a minute."); 
		
	if(strlen(reason) > 45)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was admin jailed by %s for %d mintues, Reason: %.56s", ReturnName(playerb), ReturnName(playerid), length, reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s was admin jailed by %s for %d mintues, Reason: %s", ReturnName(playerb), ReturnName(playerid), length, reason);
	
	ClearAnimations(playerb); 
	
	SetPlayerPos(playerb, 2687.3630, 2705.2537, 22.9472);
	SetPlayerInterior(playerb, 0); SetPlayerVirtualWorld(playerb, 1338);
	
	PlayerInfo[playerb][pAdminjailed] = true;
	PlayerInfo[playerb][pAdminjailTime] = length * 60; 
		
	SaveCharacter(playerb);
	
	new insertLog[250];
	
	mysql_format(ourConnection, insertLog, sizeof(insertLog), "INSERT INTO ajail_logs (`JailedDBID`, `JailedName`, `Reason`, `Date`, `JailedBy`, `Time`) VALUES(%i, '%e', '%e', '%e', '%e', %i)",
		PlayerInfo[playerb][pDBID], ReturnName(playerb), reason, ReturnDate(), ReturnName(playerid), length);
		
	mysql_tquery(ourConnection, insertLog);
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/unjail [playerid OR name]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
	
	if(PlayerInfo[playerb][pAdminjailed] == false)
		return SendErrorMessage(playerid, "The player you specified isn't admin jailed."); 
		
	SetPlayerVirtualWorld(playerb, 0); SetPlayerInterior(playerb, 0);
	SetPlayerPos(playerb, 1553.0421, -1675.4706, 16.1953);
	
	PlayerInfo[playerb][pAdminjailed] = false;
	PlayerInfo[playerb][pAdminjailTime] = 0;
	
	SaveCharacter(playerb);
	SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s has been released from admin jail by %s.", ReturnName(playerb), ReturnName(playerid));
	return 1;
}

CMD:setint(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, int, str[128];
	
	if (sscanf(params, "ud", playerb, int)) 
		return SendUsageMessage(playerid, "/setint [playerid OR name] [interior]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
	
	SetPlayerInterior(playerb, int);
	
	format(str, sizeof(str), "%s set %s's interior to %d.", ReturnName(playerid), ReturnName(playerb), int);
	SendAdminMessage(1, str);
	return 1;
}

CMD:setworld(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, world, str[128];
	
	if (sscanf(params, "ud", playerb, world)) 
		return SendUsageMessage(playerid, "/setworld [playerid OR name] [world]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
	
	SetPlayerVirtualWorld(playerb, world);
	
	format(str, sizeof(str), "%s set %s's local world to %d.", ReturnName(playerid), ReturnName(playerb), world);
	SendAdminMessage(1, str);
	return 1;
}

CMD:skin(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, skinid, str[128];
	
	if (sscanf(params, "ud", playerb, skinid)) 
		return SendUsageMessage(playerid, "/skin [playerid OR name] [skinid]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	PlayerInfo[playerb][pLastSkin] = skinid; SetPlayerSkin(playerb, skinid);
	
	format(str, sizeof(str), "%s set %s's skin to %d.", ReturnName(playerid), ReturnName(playerb), skinid);
	SendAdminMessage(1, str);
	return 1;
}

CMD:health(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, health, str[128];
	
	if (sscanf(params, "ud", playerb, health)) 
		return SendUsageMessage(playerid, "/health [playerid OR name] [health]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(health > 150)
		return SendErrorMessage(playerid, "You can't set health over 150."); 
		
	SetPlayerHealth(playerb, health);
	
	format(str, sizeof(str), "%s set %s's health to %d.", ReturnName(playerid), ReturnName(playerb), health);
	SendAdminMessage(1, str);
	return 1;
}

CMD:reports(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	SendClientMessage(playerid, COLOR_DARKGREEN, "____________________REPORTS____________________");
		
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][rReportExists] == true)
		{
			if(strlen(ReportInfo[i][rReportDetails]) > 65)
			{
				SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | Report: %.65s", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails]);
				SendClientMessageEx(playerid, COLOR_REPORT, "...%s | Pending: %d Sec ago", ReportInfo[i][rReportDetails][65], gettime() - ReportInfo[i][rReportTime]);
			}
			else SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | Report: %s | Pending: %d Sec ago", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails], gettime() - ReportInfo[i][rReportTime]);
		}
	}
	return 1;
}

CMD:ar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	new reportid;
	
	if (sscanf(params, "d", reportid))
		return SendUsageMessage(playerid, "/acceptreport [report id]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "The report ID you specified doesn't exist."); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[Report] Admin %s has accepted report %d", ReturnName(playerid), reportid);
	SendClientMessageEx(playerid, COLOR_YELLOW, "You accepted %s's report. [Report: %s]", ReturnName(ReportInfo[reportid][rReportBy]), ReportInfo[reportid][rReportDetails]);
	
	ReportInfo[reportid][rReportExists] = false;
	ReportInfo[reportid][rReportBy] = INVALID_PLAYER_ID; 
	
	//You can include a message to the reporter if you would like;
	return 1; 
}

CMD:dr(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	new reportid;
	
	if (sscanf(params, "d", reportid))
		return SendUsageMessage(playerid, "/disregardreport [report id]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "The report ID you specified doesn't exist."); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[Report] Admin %s has disregarded report %d", ReturnName(playerid), reportid);
	
	ReportInfo[reportid][rReportExists] = false;
	ReportInfo[reportid][rReportBy] = INVALID_PLAYER_ID; 
	
	//You can include a message to the reporter if you would like;
	return 1; 
}

CMD:slap(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/slap [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	GetPlayerPos(playerb, PlayerInfo[playerb][pLastPos][0], PlayerInfo[playerb][pLastPos][1], PlayerInfo[playerb][pLastPos][2]);
	//Using the player variable to avoid making other variables; 
	
	SetPlayerPos(playerb, PlayerInfo[playerb][pLastPos][0], PlayerInfo[playerb][pLastPos][1], PlayerInfo[playerb][pLastPos][2] + 5); 
	PlayNearbySound(playerb, 1130); //Slap sound;
	
	SendServerMessage(playerid, "%s slapped %s", ReturnName(playerid), ReturnName(playerb));
	if(playerb != playerid) SendServerMessage(playerb, "%s slapped %s", ReturnName(playerid), ReturnName(playerb));
	return 1;
}

CMD:mute(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/mute [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(PlayerInfo[playerb][pMuted] == false)
	{
		PlayerInfo[playerb][pMuted] = true; 
		SendClientMessageToAllEx(COLOR_RED, "%s muted %s.", ReturnName(playerid), ReturnName(playerb)); 
	}
	else
	{
		PlayerInfo[playerb][pMuted] = false;
		SendClientMessageToAllEx(COLOR_RED, "%s unmuted %s.", ReturnName(playerid), ReturnName(playerb));
	}
	return 1;
}

CMD:freeze(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb, str[128];
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/freeze [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	TogglePlayerControllable(playerb, 0);
	
	format(str, sizeof(str), "%s froze player %s.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:thaw(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb, str[128];
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/thaw [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	TogglePlayerControllable(playerb, 1);
	
	format(str, sizeof(str), "%s unfroze player %s.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:awp(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/awp [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(PlayerInfo[playerb][pSpectating] != INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "That player is spectating another player."); 
		
	//if(playerb == playerid) return SendErrorMessage(playerid, "You can't spectate yourself.");
		
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
		
		PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
	}
	
	SetPlayerInterior(playerid, GetPlayerInterior(playerb));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
	
	TogglePlayerSpectating(playerid, true); 
	PlayerSpectatePlayer(playerid, playerb);
		
	PlayerInfo[playerid][pSpectating] = playerb; 
	SendServerMessage(playerid, "You're now spectating %s. To stop, use \"/watchoff\".", ReturnName(playerb));
	return 1;
}

CMD:watchoff(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		return SendErrorMessage(playerid, "You aren't spectating anyone."); 
		
	SendServerMessage(playerid, "You stopped spectating %s.", ReturnName(PlayerInfo[playerid][pSpectating]));
	
	TogglePlayerSpectating(playerid, false); 
	ReturnPlayerGuns(playerid);
	return 1;
}

CMD:gotols(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 1514.1836, -1677.8027, 14.0469);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendTeleportMessage(playerid);
	return 1;
}

CMD:respawncar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/respawncar [vehicleid]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");
		
	SetVehicleToRespawn(vehicleid);
	
	foreach(new i : Player)
	{
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "The vehicle you're in was respawned by %s.", ReturnName(playerid));
		}
	}
	
	format(str, sizeof(str), "%s respawned vehicle ID %d.", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotocar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid;
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/gotocar [vehicleid]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");
		
	new Float: fetchPos[3];
	GetVehiclePos(vehicleid, fetchPos[0], fetchPos[1], fetchPos[2]);
	
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerid), fetchPos[0], fetchPos[1], fetchPos[2]);
	
	else
		SetPlayerPos(playerid, fetchPos[0], fetchPos[1], fetchPos[2]);
		
	SendTeleportMessage(playerid);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:getcar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new 
		vehicleid,
		Float:x,
		Float:y,
		Float:z,
		str[128]
	;
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/gotocar [vehicleid]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");
	
	GetPlayerPos(playerid, x, y, z);
	
	SetVehiclePos(vehicleid, x, y, z);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid)); 
	
	format(str, sizeof(str), "%s teleported vehicle ID %i", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str); 
	
	foreach(new i : Player)
	{
		if(!IsPlayerInAnyVehicle(i))
			continue;
			
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "The vehicle you were in (%i) was teleported.", vehicleid); 
		}
	}
	return 1;
}

CMD:listmasks(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
	foreach(new i : Player)
	{
		if(!PlayerInfo[i][pMasked])
			continue;
			
		SendClientMessageEx(playerid, COLOR_RED, "%s ID: %i %s", ReturnName(i), i, ReturnName(i, 0));
		return 1;
	}
	
	SendServerMessage(playerid, "There aren't any Masked players.");
	return 1;
}

CMD:dropinfo(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue;
	
		if(IsPlayerInRangeOfPoint(playerid, 5.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				SendServerMessage(playerid, "This is a %s with %d ammo dropped by %s.", ReturnWeaponName(WeaponDropInfo[i][eWeaponWepID]), WeaponDropInfo[i][eWeaponWepAmmo], ReturnDBIDName(WeaponDropInfo[i][eWeaponDroppedBy]));
			}
		}
		return 1;
	}
	
	SendServerMessage(playerid, "You aren't near a dropped gun.");
	return 1;
}

CMD:aooc(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(isnull(params)) return SendUsageMessage(playerid, "/aooc [text]"); 
	
	if(strcmp(e_pAccountData[playerid][mForumName], "Null"))
		SendClientMessageToAllEx(COLOR_RED, "[AOOC] Admin %s (%s): %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params);
		
	else SendClientMessageToAllEx(COLOR_RED, "[AOOC] Admin %s: %s", ReturnName(playerid), params);
	return 1;
}

CMD:revive(playerid, params[])
{
	new 
		playerb,
		str[128]
	;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/revive [playerid OR name]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(!PlayerInfo[playerb][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(GetPlayerTeam(playerb) == PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "That player isn't dead or brutally wounded.");
	
	format(str, sizeof(str), "%s revived player %s.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str); 
	
	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(playerb, 100); 
	
	TogglePlayerControllable(playerb, 1); 
	SetPlayerWeather(playerb, globalWeather);  
	
	SetPlayerChatBubble(playerb, "(( Respawned ))", COLOR_WHITE, 21.0, 3000); 
	GameTextForPlayer(playerb, "~b~You were revived", 3000, 4);
	
	ClearDamages(playerb);
	return 1;
}

CMD:arecord(playerid, params[])
{
	new
		playerb[60],
		type[30],
		query[128]
	;
	
	if(sscanf(params, "s[60]s[30]", playerb, type))
		return SendUsageMessage(playerid, "/arecord [character name] [ajail, kicks, bans]");
		
	if(!ReturnDBIDFromName(playerb))
		return SendErrorMessage(playerid, "That character doesn't exist.");
		
	if(!strcmp(type, "ajail"))
	{
		mysql_format(ourConnection, query, sizeof(query), "SELECT * FROM ajail_logs WHERE JailedDBID = %i", ReturnDBIDFromName(playerb)); 
		mysql_tquery(ourConnection, query, "OnAjailRecord", "i", playerid); 
	}	
	else return SendServerMessage(playerid, "Invalid Parameter.");
	return 1;
}

CMD:listweapons(playerid, params[])
{
	new
		playerb,
		weapon_id[2][13]
	;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/listweapons [playerid OR name]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
	
	
	SendClientMessageEx(playerid, COLOR_RED, "________** %s's Weapons **________", ReturnName(playerb));
	
	for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon_id[0][i], weapon_id[1][i]); 
		
		if(!weapon_id[0][i])
			continue;
			
		SendClientMessageEx(playerid, COLOR_GRAD1, "%s [Ammo: %d]", ReturnWeaponName(weapon_id[0][i]), weapon_id[1][i]); 
	}
		
	return 1;
}

//Level 2 Admin commands:
CMD:armor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid); 
		
	new playerb, armor, str[128];
	
	if (sscanf(params, "ud", playerb, armor)) 
		return SendUsageMessage(playerid, "/armor [playerid OR name] [armor]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(armor > 200)
		return SendErrorMessage(playerid, "You can't set armor above 200."); 
		
	SetPlayerArmour(playerid, armor);
	
	format(str, sizeof(str), "%s set %s's Armor to %d.", ReturnName(playerid), ReturnName(playerb), armor);
	SendAdminMessage(1, str);
	return 1;
}

CMD:clearreports(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return 0;
		
	new reportCount = 0;
	
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][rReportExists] == true)
		{
			reportCount++;
		}
	}
	if(reportCount)
	{
		new string[128]; 
		
		format(string, sizeof(string), "{FFFFFF}Are you sure you want to clear ALL active reports?\n\nThere are {FF6347}%d{FFFFFF} report(s).", reportCount);
		ConfirmDialog(playerid, "Confirmation", string, "ClearReports", reportCount); 
	}
	else return SendServerMessage(playerid, "There are no active reports to clear.");
	return 1;
}

CMD:p2p(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, targetid, str[128]; 
	
	if(sscanf(params, "uu", playerb, targetid))
		return SendUsageMessage(playerid, "/p2p [playerid] [targetid]");
	
	if (!IsPlayerConnected(playerb) || !IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "A player you specified isn't connected to the server."); 
		
	if (e_pAccountData[playerb][mLoggedin] == false || e_pAccountData[targetid][mLoggedin] == false)
		return SendErrorMessage(playerid, "A player you specified isn't logged in."); 
		
	format(str, sizeof(str), "%s teleported player %s to %s.", ReturnName(playerid), ReturnName(playerb), ReturnName(targetid));
	SendAdminMessage(1, str);
	
	GetPlayerPos(targetid, PlayerInfo[targetid][pLastPos][0], PlayerInfo[targetid][pLastPos][1], PlayerInfo[targetid][pLastPos][2]);
	//Using the player variable to avoid making other variables; 
	
	SetPlayerPos(playerb, PlayerInfo[targetid][pLastPos][0], PlayerInfo[targetid][pLastPos][1], PlayerInfo[targetid][pLastPos][2]);
	SetPlayerInterior(playerb, GetPlayerInterior(targetid)); SetPlayerVirtualWorld(playerb, GetPlayerVirtualWorld(targetid)); 
	
	SendTeleportMessage(playerb);
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, weaponid, ammo, idx, str[128];
	
	if(sscanf(params, "uii", playerb, weaponid, ammo))
	{
		SendUsageMessage(playerid, "/givegun [playerid OR name] [weaponid] [ammo]");
		SendServerMessage(playerid, "These weapons save to the players account."); 
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "A player you specified isn't connected to the server."); 
		
	if (e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "A player you specified isn't logged in."); 
		
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "You have specified an invalid weaponid.");
		
	if(ammo < 1)return SendErrorMessage(playerid, "You specified invalid ammo amount.");
	
	idx = ReturnWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerb][pWeapons][idx])
		SendServerMessage(playerid, "%s's %s and %d ammo was removed.", ReturnName(playerb), ReturnWeaponName(PlayerInfo[playerb][pWeapons][idx]), PlayerInfo[playerb][pWeaponsAmmo][idx]);
	
	GivePlayerWeapon(playerb, weaponid, ammo); 
	
	PlayerInfo[playerb][pWeapons][idx] = weaponid;
	PlayerInfo[playerb][pWeaponsAmmo][idx] = ammo; 
	
	format(str, sizeof(str), "%s gave %s a %s and %d ammo.", ReturnName(playerid), ReturnName(playerb), ReturnWeaponName(weaponid), ammo);
	SendAdminMessage(2, str);
	
	SendServerMessage(playerb, "You were given %s and %d ammo.", ReturnWeaponName(weaponid), ammo);
	return 1;
}

CMD:clearpguns(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, displayString[128], str[128]; 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/clearpguns [playerid OR name]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
		
	for(new i = 0; i < 4; i ++)
	{
		if(PlayerInfo[playerb][pWeaponsAmmo][i] > 0)
		{
			format(displayString, sizeof(displayString), "%s%s - %d Ammo\n", displayString, ReturnWeaponName(PlayerInfo[playerb][pWeapons][i]), PlayerInfo[playerb][pWeaponsAmmo][i]);
			
			PlayerInfo[playerb][pWeapons][i] = 0;
			PlayerInfo[playerb][pWeaponsAmmo][i] = 0;
		}
	}
	
	ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Weapons Cleared:", displayString, "<<", ""); 
	TakePlayerGuns(playerb); 
	
	format(str, sizeof(str), "%s cleared %s's weapons.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotoproperty(playerid, params[])
{
	new id;
	
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotoproperty [property ID]");
		
	if(!PropertyInfo[id][ePropertyDBID] || id > MAX_PROPERTY)
		return SendErrorMessage(playerid, "The property you specified doesn't exist.");
		
	SetPlayerPos(playerid, PropertyInfo[id][ePropertyEntrance][0], PropertyInfo[id][ePropertyEntrance][1], PropertyInfo[id][ePropertyEntrance][2]);
	
	SetPlayerVirtualWorld(playerid, PropertyInfo[id][ePropertyEntranceWorld]);
	SetPlayerInterior(playerid, PropertyInfo[id][ePropertyEntranceInterior]);
	
	SendServerMessage(playerid, "You teleported to Property %i.", id);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:gotobusiness(playerid, params[])
{
	new id;
	
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotobusiness [business ID]");
		
	if(!BusinessInfo[id][eBusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "The business you specified doesn't exist.");
		
	SetPlayerPos(playerid, BusinessInfo[id][eBusinessEntrance][0], BusinessInfo[id][eBusinessEntrance][1], BusinessInfo[id][eBusinessEntrance][2]); 
	SendServerMessage(playerid, "You teleported to business %i.", id); 
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:gotofaction(playerid, params[])
{
	new id;
	
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotofaction [faction ID]");
		
	if(!FactionInfo[id][eFactionDBID] || id > MAX_FACTIONS)
		return SendErrorMessage(playerid, "The faction you specified doesn't exist.");
		
	SetPlayerPos(playerid, FactionInfo[id][eFactionSpawn][0], FactionInfo[id][eFactionSpawn][1], FactionInfo[id][eFactionSpawn][2]);
	
	SetPlayerVirtualWorld(playerid, FactionInfo[id][eFactionSpawnWorld]);
	SetPlayerInterior(playerid, FactionInfo[id][eFactionSpawnInt]); 
	
	SendServerMessage(playerid, "You teleported to %s's spawn point.", ReturnFactionNameEx(id)); 

	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:gotopoint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new
		Float:x,
		Float:y,
		Float:z,
		interior
	; 
	
	if(sscanf(params, "fffi", x, y, z, interior))
		return SendUsageMessage(playerid, "/gotopoint [x] [y] [z] [interior id]"); 
		
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid, interior);
	
	SendTeleportMessage(playerid);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:noooc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new
		str[128]
	;
		
	if(!oocEnabled)
	{
		format(str, sizeof(str), "%s enabled OOC chat.", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "OOC chat has been enabled by an admin."); 
		oocEnabled = true;
	}
	else
	{
		format(str, sizeof(str), "%s disabled OOC chat.", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "OOC chat has been disabled by an admin."); 
		oocEnabled = false;
	}
	return 1;
}

CMD:backup(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
	
	if(isnull(params))
		return SendUsageMessage(playerid, "/backup [players, all]"); 
		
	new 
		str[128];
		
	if(!strcmp(params, "players"))
	{
		foreach(new i : Player)
		{
			if(!PlayerInfo[playerid][pDBID])
				continue;
				
			SaveCharacter(i); 
		}
		
		format(str, sizeof(str), "%s backed up player data. (%i)", ReturnName(playerid), GetPlayerPoolSize());
		SendAdminMessage(1, str); 
	}
	else if(!strcmp(params, "all"))
	{
		SaveFactions();
		SaveProperties();
		SaveBusinesses();
		
		SendClientMessageToAllEx(COLOR_RED, "Admin %s backed up server data.", ReturnName(playerid));
	}
	else return SendErrorMessage(playerid, "Invalid Paramater.");	
	return 1;
}

CMD:repair(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new 
		str[128],
		vehicleid,
		Float:angle
	;
	
	if(sscanf(params, "i", vehicleid))
		return SendUsageMessage(playerid, "/repair [vehicle id]"); 
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle."); 
		
	format(str, sizeof(str), "%s repaired vehicle ID %i.", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	
	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 900); 
	
	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return 1; 
}

//Level 3 Admin commands:
CMD:spawncar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return 0;
		
	new vehicleid = INVALID_VEHICLE_ID, modelid, color1, color2, siren, str[128]; 
	
	if(sscanf(params, "iiiI(0)", modelid, color1, color2, siren))
	{
		SendUsageMessage(playerid, "/spawncar [model id] [color1] [color2] [siren default 0]");
		SendServerMessage(playerid, "These vehicles are temporary. Siren allows you to turn sirens on using horn."); 
		return 1;
	}
	
	if(gettime() - lastVehicleSpawn[playerid] < 5)
		return SendServerMessage(playerid, "You need to wait before spawning another vehicle.");
	
	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "You specified an invalid model.");
		
	if(color1 < 0 || color2 < 0 || color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "A color you specified was invalid."); 
		
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
	//Using the player variable to avoid making other variables; 
	
	vehicleid = CreateVehicle(modelid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, color1, color2, -1, siren);
	
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleAdminSpawn] = true;
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		
		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
	}
	
	lastVehicleSpawn[playerid] = gettime();
	PutPlayerInVehicle(playerid, vehicleid, 0);
	
	format(str, sizeof(str), "%s spawned a temporary %s.", ReturnName(playerid), ReturnVehicleName(vehicleid));
	SendAdminMessage(3, str);
	return 1;
}

CMD:despawncar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return 0;
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/despawncar [vehicleid]");
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn] == false)
		return SendErrorMessage(playerid, "You can't despawn a private / faction vehicle."); 
	
	format(str, sizeof(str), "%s despawned %s (%d).", ReturnName(playerid), ReturnVehicleName(vehicleid), vehicleid);
	SendAdminMessage(3, str);
		
	ResetVehicleVars(vehicleid); DestroyVehicle(vehicleid);
	return 1;
}

CMD:pcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	new playerb, modelid, color1, color2;
	
	if(sscanf(params, "uiii", playerb, modelid, color1, color2))
	{
		SendUsageMessage(playerid, "/pcar [playerid OR name] [model id] [color1] [color2]");
		SendServerMessage(playerid, "This issues a permanent vehicle to a player.");
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "A player you specified isn't connected to the server."); 
		
	if (e_pAccountData[playerb][mLoggedin] == false)
		return SendErrorMessage(playerid, "A player you specified isn't logged in."); 
	
	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "You specified an invalid model.");
		
	if(color1 < 0 || color2 < 0 || color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "A color you specified was invalid."); 
		
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(!PlayerInfo[playerb][pOwnedVehicles][i])
		{
			playerInsertID[playerb] = i;
			break;
		}
	}
	if(!playerInsertID[playerb])
	{
		SendErrorMessage(playerid, "%s doesn't have any free vehicle slots.", ReturnName(playerb));
	}
	else
	{
		new insertQuery[256];
		
		mysql_format(ourConnection, insertQuery, sizeof(insertQuery), "INSERT INTO vehicles (`VehicleOwnerDBID`, `VehicleModel`, `VehicleColor1`, `VehicleColor2`, `VehicleParkPosX`, `VehicleParkPosY`, `VehicleParkPosZ`, `VehicleParkPosA`) VALUES(%i, %i, %i, %i, 1705.4175, -1485.9148, 13.3828, 87.5097)",
			PlayerInfo[playerb][pDBID], modelid, color1, color2);
		mysql_tquery(ourConnection, insertQuery, "Query_AddPlayerVehicle", "ii", playerid, playerb); 
	}
	
	return 1;
}

CMD:setstats(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	new 
		playerb, 
		statid, 
		value,
		str[128]
	;
	
	if(sscanf(params, "uiI(-1)", playerb, statid, value))
	{
		SendUsageMessage(playerid, "/setstats [playerid OR name] [stat code] [value]"); 
		SendClientMessage(playerid, COLOR_WHITE, "1. Faction Rank, 2. Mask, 3. Radio, 4. Bank Money, 5. Level,");
		SendClientMessage(playerid, COLOR_WHITE, "6. EXP, 7. Paycheck");
		return 1;
	}
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerid][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
	
	switch(statid)
	{
		case 1: 
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [playerid OR name] 1 [value required]"); 
		
			if(value < 1 && value != -1 || value > 20)
				return SendErrorMessage(playerid, "You specified an invalid rank. (1-20)");
				
			PlayerInfo[playerb][pFactionRank] = value;
			SaveCharacter(playerb); 
			
			format(str, sizeof(str), "%s set %s's faction rank to %i.", ReturnName(playerid), ReturnName(playerb), value); 
			SendAdminMessage(3, str); 
		}
		case 2:
		{
			if(!PlayerInfo[playerb][pHasMask])
				PlayerInfo[playerb][pHasMask] = true;
				
			else PlayerInfo[playerb][pHasMask] = false;
			
			format(str, sizeof(str), "%s %s %s's Mask.", ReturnName(playerid), (PlayerInfo[playerb][pHasMask] != true) ? ("took") : ("set"), ReturnName(playerb));
			SendAdminMessage(3, str); 
		}
		case 3:
		{
			if(!PlayerInfo[playerb][pHasRadio])
				PlayerInfo[playerb][pHasRadio] = true;
				
			else PlayerInfo[playerb][pHasRadio] = false;
			
			format(str, sizeof(str), "%s %s %s's Radio.", ReturnName(playerid), (PlayerInfo[playerb][pHasRadio] != true) ? ("took") : ("set"), ReturnName(playerb));
			SendAdminMessage(3, str);
		}
		case 4:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [playerid OR name] 4 [value required]"); 
		
			format(str, sizeof(str), "%s set %s's bank money: $%s (Previously $%s)", ReturnName(playerid), ReturnName(playerb), MoneyFormat(value), MoneyFormat(PlayerInfo[playerb][pBank])); 
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pBank] = value;
			SaveCharacter(playerb);
		}
		case 5:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [playerid OR name] 5 [value required]"); 
		
			if(value < 1 && value != -1)
				return SendErrorMessage(playerid, "Player levels can't go below one.");

			format(str, sizeof(str), "%s set %s's level: %i (Previously %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pLevel]);
			SendAdminMessage(3, str); 
			
			PlayerInfo[playerb][pLevel] = value; SetPlayerScore(playerb, value);
			SaveCharacter(playerb);
		}
		case 6:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [playerid OR name] 6 [value required]"); 
		
			format(str, sizeof(str), "%s set %s's EXP: %i (Previously %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pEXP]);
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pEXP] = value;
			SaveCharacter(playerb);
		}
		case 7:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [playerid OR name] 7 [value required]");
				
			format(str, sizeof(str), "%s set %s's EXP: %i (Previously %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pPaycheck]);
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pPaycheck] = value; 
			SaveCharacter(playerb);
		}
	}
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	new playerb, value, str[128];
	
	if(sscanf(params, "ui", playerb, value))
		return SendUsageMessage(playerid, "/givemoney [playerid OR name] [amount]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!PlayerInfo[playerid][pLoggedin])
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	GiveMoney(playerb, value);
	SendServerMessage(playerb, "You received $%s from Admin %s.", MoneyFormat(value), ReturnName(playerid));

	format(str, sizeof(str), "%s gave $%s to %s", ReturnName(playerid), MoneyFormat(value), ReturnName(playerb));
	SendAdminMessage(3, str);
	return 1;
}

CMD:setcar(playerid, params[])
{
	new	vehicleid, a_str[60], b_str[60];
	new str[128], value, Float:life; 
	
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	if(sscanf(params, "is[60]S()[60]", vehicleid, a_str, b_str))
	{
		SendUsageMessage(playerid, "/setcar [vehicleid] [params]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} locklvl, alarmlvl, immoblvl, timesdestroyed,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} enginelife, batterylife, color1, color2, paintjob, plates."); 
		return 1;
	}
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle ID."); 
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendErrorMessage(playerid, "The vehicle you specified is admin spawned.");
		
	if(!strcmp(a_str, "locklvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid locklvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "Invalid Value.");
		
		format(str, sizeof(str), "%s set vehicle ID %i's lock level to %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleLockLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "alarmlvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid alarmlvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "Invalid Value.");
		
		format(str, sizeof(str), "%s set vehicle ID %i's alarm level to %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "immoblvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid immoblvl [1-5]"); 
			
		if(value > 5 || value < 1)
			return SendErrorMessage(playerid, "Invalid Value.");
		
		format(str, sizeof(str), "%s set vehicle ID %i's immobiliser level to %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleImmobLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "timesdestroyed"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid timesdestroyed [value]");
			
		format(str, sizeof(str), "%s set vehicle ID %i's time destroyed to %i. (Previously %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleTimesDestroyed]); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "enginelife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid enginelife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "You can't set that value. (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's engine life to %.2f. (Previously %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleEngine]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleEngine] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "batterylife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid batterylife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "You can't set that value. (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's battery life to %.2f. (Previously %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleBattery]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleBattery] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color1"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color1 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "You specified an invalid color. (0-255)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's color1 to %i. (Previously %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor1]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "The vehicle needs to be respawned to take affect.");
		
		VehicleInfo[vehicleid][eVehicleColor1] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color2"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color2 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "You specified an invalid color. (0-255)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's color2 to %i. (Previously %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor2]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "The vehicle needs to be respawned to take affect.");
		
		VehicleInfo[vehicleid][eVehicleColor2] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "paintjob"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid paintjob [0-2, 3 to remove]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "You specified an invalid color. (0-255)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's paintjob to %i. (Previously %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehiclePaintjob]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "The vehicle needs to be respawned to take affect.");
		
		VehicleInfo[vehicleid][eVehiclePaintjob] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "plates"))
	{
		new
			plates[32]; 
			
		if(sscanf(b_str, "s[32]", plates))
			return SendUsageMessage(playerid, "/setcar vehicleid plates [plates]"); 
			
		if(strlen(plates) > 6 || strlen(plates) < 6)
			return SendErrorMessage(playerid, "You need to provide a 6 digit plate. (California license plate: Q123Q1)");
			
		format(str, sizeof(str), "%s set vehicle ID %i's plates to \"%s\". (Previously %s)", ReturnName(playerid), vehicleid, plates, VehicleInfo[vehicleid][eVehiclePlates]);
		SendAdminMessage(3, str);
		
		format(VehicleInfo[vehicleid][eVehiclePlates], 32, "%s", plates); 
		SaveVehicle(vehicleid);
	}
	return 1;
}

CMD:setcarparams(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
	
	new vehicleid, a_str[60], b_str[60]; 
	new str[128];
	
	if(sscanf(params, "is[60]S()[60]", vehicleid, a_str, b_str))
	{
		SendUsageMessage(playerid, "/setcarparams [vehicleid] [params]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} engine, lights, lock, health"); 
		return 1;
	}
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicleid."); 
		
	if(!strcmp(a_str, "engine"))
	{
		if(!VehicleInfo[vehicleid][eVehicleEngineStatus])
		{
			ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
			format(str, sizeof(str), "%s turned vehicle ID %i's engine on.", ReturnName(playerid), vehicleid);
		}
		else
		{
			ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
			format(str, sizeof(str), "%s turned vehicle ID %i's engine off.", ReturnName(playerid), vehicleid);
		}
		
		SendAdminMessage(3, str); 
	}
	else if(!strcmp(a_str, "lights"))
	{
		if(VehicleInfo[vehicleid][eVehicleLights] == false)
			ToggleVehicleLights(vehicleid, true);
			
		else ToggleVehicleLights(vehicleid, false);
		
		format(str, sizeof(str), "%s turned vehicle ID %i's lights %s.", ReturnName(playerid), vehicleid, (VehicleInfo[vehicleid][eVehicleLights] != true) ? ("off") : ("on"));
		SendAdminMessage(3, str);
	}
	else if(!strcmp(a_str, "lock"))
	{
		new engine, lights, alarm, doors, bonnet, boot, objective; 
	
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(VehicleInfo[vehicleid][eVehicleLocked])
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
			VehicleInfo[vehicleid][eVehicleLocked] = false;
		}
		else 
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
			VehicleInfo[vehicleid][eVehicleLocked] = true;
		}
		
		format(str, sizeof(str), "%s %s vehicle ID %i.", ReturnName(playerid), (VehicleInfo[vehicleid][eVehicleLocked] != false) ? ("locked") : ("unlocked")); 
		SendAdminMessage(3, str);
	}
	else if(!strcmp(a_str, "health"))
	{
		new Float:health;
		
		if(sscanf(b_str, "f", health))
			return SendUsageMessage(playerid, "/setcar vehicleid health [value]");
			
		SetVehicleHealth(vehicleid, health); 
		
		format(str, sizeof(str), "%s set vehicle ID %i's health to %.2f.", ReturnName(playerid), vehicleid, health);
		SendAdminMessage(3, str);
	}

	return 1;
}

//Level 4 Admin commands:
CMD:makefaction(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	new varAbbrev[30], varName[90]; 
	
	if(sscanf(params, "s[30]s[90]", varAbbrev, varName))
	{
		SendUsageMessage(playerid, "/makefaction [faction abbreviation] [faction name]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} Do not use spaces for the abbreviation.");
		return 1; 
	}
	
	if(strlen(varName) > 90)
		return SendErrorMessage(playerid, "Your factions name needs to be shorter."); 
		
	new idx = 0;
	
	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(!FactionInfo[i][eFactionDBID])
		{
			idx = i; 
			break;
		}
	}
	if(idx == 0)
	{
		return SendServerMessage(playerid, "The server has met the maximum amount of factions."); 
	}

	SendServerMessage(playerid, "Creating the faction..."); 	
	
	new thread[128]; 
	
	mysql_format(ourConnection, thread, sizeof(thread), "INSERT INTO factions (`FactionName`, `FactionAbbrev`) VALUES('%e', '%e')", varName, varAbbrev);
	mysql_tquery(ourConnection, thread, "Query_InsertFaction", "issi", playerid, varAbbrev, varName, idx);
	
	return 1;
}

CMD:editfaction(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	//This is a lead admin version for faction configuration;
	new factionid, oneString[60], secString[90]; 
		
	if (sscanf(params, "ds[60]S()[90]", factionid, oneString, secString))
	{
		SendUsageMessage(playerid, "/editfaction [faction id] [configuration]");
		SendServerMessage(playerid, "type, alterrank, joinrank, chatrank, towrank, chatcolor, spawn"); 
		return 1;
	}
	
	if(!FactionInfo[factionid][eFactionDBID])
		return SendErrorMessage(playerid, "The faction you specified doesn't exist.");
	
	if(!strcmp(oneString, "type"))
	{
		new type;
		
		if(sscanf(secString, "d", type))
		{
			SendUsageMessage(playerid, "/editfaction factionid type [type id]");
			SendServerMessage(playerid, "1. Illegal, 2. Police, 3. Medical, 4. DOC"); 
			return 1;
		}
		
		if(type > 4 || type < 1)
			return SendErrorMessage(playerid, "You specified an invalid faction type."); 
			
		FactionInfo[factionid][eFactionType] = type; 
		
		new 
			typeName[32];
		
		if(type == 1) typeName = "Illegal";
		if(type == 2) typeName = "Police";
		if(type == 3) typeName = "Medical";
		if(type == 4) typeName = "DOC"; 
		
		SendServerMessage(playerid, "You set faction %d's type to %s.", factionid, typeName);
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "alterrank"))
	{
		new rankid;
		
		if(sscanf(secString, "d", rankid))
		{
			SendUsageMessage(playerid, "/editfaction factionid alterrank [rank]");
			SendServerMessage(playerid, "This is the rank that may edit the factions name and other permissions."); 
			return 1;
		}
		
		if(rankid < 1 || rankid > 20)
			return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
			
		FactionInfo[factionid][eFactionAlterRank] = rankid;
		SendServerMessage(playerid, "You set faction %d's alter rank to %d.", factionid, rankid);
		
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "joinrank"))
	{
		new rankid;
		
		if(sscanf(secString, "d", rankid))
		{
			SendUsageMessage(playerid, "/editfaction factionid joinrank [rank]");
			SendServerMessage(playerid, "This is the rank a player receives when they join this faction."); 
			return 1;
		}
		
		if(rankid < 1 || rankid > 20)
			return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
			
		FactionInfo[factionid][eFactionJoinRank] = rankid;
		SendServerMessage(playerid, "You set faction %d's join rank to %d.", factionid, rankid);
		
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "chatrank"))
	{
		new rankid;
		
		if(sscanf(secString, "d", rankid))
		{
			SendUsageMessage(playerid, "/editfaction factionid chatrank [rank]");
			SendServerMessage(playerid, "This is the rank a player needs to access faction chat.");
			return 1;
		}
		
		if(rankid < 1 || rankid > 20)
			return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
			
		FactionInfo[factionid][eFactionChatRank] = rankid;
		SendServerMessage(playerid, "You set faction %d's chat rank to %d.", factionid, rankid);
		
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "towrank"))
	{
		new rankid;
		
		if(sscanf(secString, "d", rankid))
		{
			SendUsageMessage(playerid, "/editfaction factionid towrank [rank]");
			SendServerMessage(playerid, "This is the rank a player needs to tow faction vehicles.");
			return 1;
		}
		
		if(rankid < 1 || rankid > 20)
			return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
			
		FactionInfo[factionid][eFactionTowRank] = rankid;
		SendServerMessage(playerid, "You set faction %d's tow rank to %d.", factionid, rankid); 
		
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "chatcolor"))
	{
		new hexcolor; 
		
		if(sscanf(secString, "x", hexcolor))
		{
			SendUsageMessage(playerid, "/editfaction factionid chatcolor [hexcode]");
			SendServerMessage(playerid, "This is the color faction chat is shown in. Example: 0x8D8DFFFF"); 
			return 1;
		}
		
		FactionInfo[factionid][eFactionChatColor] = hexcolor;
		SendServerMessage(playerid, "You set faction %d's chat color to \"%x\". ", factionid, hexcolor);
		
		SaveFaction(factionid);
	}
	else if(!strcmp(oneString, "spawn"))
	{
		GetPlayerPos(playerid, FactionInfo[factionid][eFactionSpawn][0], FactionInfo[factionid][eFactionSpawn][1], FactionInfo[factionid][eFactionSpawn][2]);
		
		FactionInfo[factionid][eFactionSpawnInt] = GetPlayerInterior(playerid);
		
		if(GetPlayerInterior(playerid) != 0)
			FactionInfo[factionid][eFactionSpawnWorld] = random(50000)+playerid+5; 
		
		else FactionInfo[factionid][eFactionSpawnWorld] = GetPlayerVirtualWorld(playerid);
		
		SendServerMessage(playerid, "You changed faction %d's spawn point."); 
	}
	else return SendErrorMessage(playerid, "Invalid Parameter.");
	return 1;
}

CMD:setpfaction(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid);
		
	new playerb, factionid, str[128];
	
	if(sscanf(params, "ud", playerb, factionid))
		return SendUsageMessage(playerid, "/setpfaction [playerid OR name] [faction id]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(e_pAccountData[playerid][mLoggedin] == false)
		return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
		
	if(!FactionInfo[factionid][eFactionDBID]) return SendErrorMessage(playerid, "The faction you specified doesn't exist.");
	
	if(PlayerInfo[playerb][pFaction] != 0)
	{
		new detailStr[128];
		
		format(detailStr, sizeof(detailStr), "{FFFFFF}%s is already in a faction. Would you like to continue?", ReturnName(playerb));
		ConfirmDialog(playerid, "Confirmation", detailStr, "OnSetFaction", playerb, factionid);
		return 1;
	}
	
	PlayerInfo[playerb][pFaction] = factionid;
	PlayerInfo[playerb][pFactionRank] = FactionInfo[factionid][eFactionJoinRank]; 
	
	SaveCharacter(playerb);
		
	format(str, sizeof(str), "%s set %s's faction to %d.", ReturnName(playerid), ReturnName(playerb), factionid);
	SendAdminMessage(4, str);
	
	SendServerMessage(playerb, "You were set to faction %d by Admin %s.", factionid, ReturnName(playerid));
	
	return 1;
}

CMD:makeproperty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	new 
		vartype, 
		query[128]
	; 
	
	if(sscanf(params, "i", vartype))
	{
		SendUsageMessage(playerid, "/makeproperty [type]");
		SendClientMessage(playerid, COLOR_WHITE, "Types: 1. House, 2. Apartment Complex, 3. Apartment Room.");
		return 1;
	}
	
	if(vartype > 3 || vartype < 1) 
		return SendErrorMessage(playerid, "You specified an invalid type.");
		
	mysql_format(ourConnection, query, sizeof(query), "INSERT INTO properties (`PropertyType`) VALUES(%i)", vartype);
	mysql_tquery(ourConnection, query, "OnPropertyCreate", "ii", playerid, vartype);
	return 1;
}

CMD:editproperty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	new id, indx[60], specifier[60];
	
	if(sscanf(params, "is[60]S()[60]", id, indx, specifier))
	{
		SendUsageMessage(playerid, "/editproperty [property id] [params]");
		SendClientMessage(playerid, COLOR_WHITE, "Params: 1. Entrance, 2. Interior, 3. Faction,");
		SendClientMessage(playerid, COLOR_WHITE, "Params: 4. Type, 5. MarketPrice, 6. Level.");
		return 1; 
	}
	
	if(!PropertyInfo[id][ePropertyDBID] || id > MAX_PROPERTY)
		return SendErrorMessage(playerid, "That Property doesn't exist.");
	
	if(!strcmp(indx, "entrance"))
	{
		ConfirmDialog(playerid, "Confirmation", "Are you sure you want to set this properties entrance?", "OnEntranceChange", id); 
	}
	else if(!strcmp(indx, "interior"))
	{
		ConfirmDialog(playerid, "Confirmation", "Are you sure you want to set this properties interior?", "OnInteriorChange", id); 
	}
	else if(!strcmp(indx, "faction"))
	{		
		new factionid;
		
		if(sscanf(specifier, "i", factionid))
			return SendUsageMessage(playerid, "/editproperty %i Faction [faction ID]", id);
			
		if(!FactionInfo[factionid][eFactionDBID] || factionid > MAX_FACTIONS)
			return SendErrorMessage(playerid, "You specifier an invalid faction ID.");
			
		PropertyInfo[id][ePropertyFaction] = factionid;
		SaveProperty(factionid);
		
		SendServerMessage(playerid, "You set Property %i's faction to %i.", id, factionid);
	}
	else if(!strcmp(indx, "type"))
	{
		new vartype, typeName[30];
		
		if(sscanf(specifier, "i", vartype))
		{
			SendUsageMessage(playerid, "/editproperty %i Type [type id]", id);
			SendClientMessage(playerid, COLOR_WHITE, "Types: 1. House, 2. Apartment Complex, 3. Apartment Room.");
			return 1;
		}
		
		if(vartype > 3 || vartype < 1) 
			return SendErrorMessage(playerid, "You specified an invalid type.");
			
		if(vartype == PROPERTY_TYPE_HOUSE) typeName = "House";
		if(vartype == PROPERTY_TYPE_APTCOMPLEX) typeName = "Apartment Complex";
		if(vartype == PROPERTY_TYPE_APTROOM) typeName = "Apartment Room";
		
		PropertyInfo[id][ePropertyType] = vartype;
		SaveProperty(id);
		
		SendServerMessage(playerid, "You set Property %i's type to %s.", id, typeName);	
	}
	else if(!strcmp(indx, "marketprice"))
	{
		new price;
		
		if(sscanf(specifier, "i", price))
			return SendUsageMessage(playerid, "/editproperty %i MarketPrice [price]", id);
			
		if(price < 1)
			return SendErrorMessage(playerid, "The price has to be greater than or equal to 1."); 
			 
		PropertyInfo[id][ePropertyMarketPrice] = price;
		SaveProperty(id);
		
		SendServerMessage(playerid, "You set Property %i's market price to %i.", id, price);
	}
	else if(!strcmp(indx, "level"))
	{
		new level;
		
		if(sscanf(specifier, "i", level))
			return SendUsageMessage(playerid, "/editproperty %i Level [level]", id);
			
		if(level < 1)
			return SendErrorMessage(playerid, "The level can't be less than 1.");
			
		PropertyInfo[id][ePropertyLevel] = level;
		SaveProperty(id);
		
		SendServerMessage(playerid, "You set Property %i's level to %i.", id, level);
	}
	else return SendServerMessage(playerid, "Invalid Paramater.");	
	return 1;
}

CMD:makexmrcat(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	if(isnull(params))
	{
		SendUsageMessage(playerid, "/makexmrcat [Category name] (e.g: Rap)"); 
		SendServerMessage(playerid, "These are the station categories listed in the station list."); 
		return 1;
	}
	
	if(strlen(params) > 90 || strlen(params) < 3)
		return SendErrorMessage(playerid, "Your categories either too long or too short.");
		
	new
		idx,
		insertQuery[128]
	; 
		
	for(new i = 1; i < MAX_XMR_CATEGORY; i++)
	{
		if(!XMRCategoryInfo[i][eXMRID])
		{
			idx = i;
			break;
		}
	}
	
	if(idx == 0)
		return SendErrorMessage(playerid, "The server has met its XMR category capacity."); 
		
	mysql_format(ourConnection, insertQuery, sizeof(insertQuery), "INSERT INTO xmr_categories (XMRCategoryName) VALUES ('%e')", params);
	mysql_tquery(ourConnection, insertQuery, "OnXMRCategory", "iis", playerid, idx, params); 

	return 1;
}

CMD:makexmrstation(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	new 
		category,
		staURL[128],
		staName[90],
		idx,
		insertQuery[256]
	;
	
	if(sscanf(params, "is[128]s[90]", category, staURL, staName))
	{
		SendUsageMessage(playerid, "/makexmrstation [Category] [Audio URL] [Station Name]"); 
		SendClientMessage(playerid, -1, "Example: /makexmrstation 1 http://powerhitz.com Powerhitz"); 
		return 1;
	}
	
	if(!XMRCategoryInfo[category][eXMRID] || category > MAX_XMR_CATEGORY)
		return SendErrorMessage(playerid, "The category you specified doesn't exist."); 
	
	for(new i = 1; i < MAX_XMR_CATEGORY_STATIONS; i++)
	{
		if(!XMRStationInfo[i][eXMRStationID])
		{
			idx = i; 
			break;
		}
	}
	
	if(idx == 0)
		return SendErrorMessage(playerid, "The server has met its XMR stations capacity."); 
	
	mysql_format(ourConnection, insertQuery, sizeof(insertQuery), "INSERT INTO xmr_stations (XMRCategory, XMRStationName, XMRStationURL) VALUES(%i, '%e', '%e')", category, staName, staURL);
	mysql_tquery(ourConnection, insertQuery, "OnXMRStation", "iiiss", playerid, category, idx, staURL, staName); 
	
	return 1;
}

CMD:makebusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;		

	new 
		type_id,
		idx,
		query[128]
	; 
	
	if(sscanf(params, "i", type_id))
	{
		SendUsageMessage(playerid, "/makebusiness [business type]"); 
		SendClientMessage(playerid, COLOR_WHITE, "Types: 1. Restaurant, 2. Ammunation, 3. Club,");
		SendClientMessage(playerid, COLOR_WHITE, "Types: 4. Bank, 5. General, 6. Dealership, 7. DMV."); 
		return 1;
	}
	
	if(type_id > 7 || type_id < 1)
		return SendErrorMessage(playerid, "You specified an invalid type.");
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][eBusinessDBID])
		{
			idx = i;
			break;
		}
	}
	
	if(idx == 0)
		return SendErrorMessage(playerid, "You can't make anymore businesses."); 
		
	mysql_format(ourConnection, query, sizeof(query), "INSERT INTO businesses (BusinessType) VALUES(%i)", type_id); 
	mysql_tquery(ourConnection, query, "Query_InsertBusiness", "iii", playerid, idx, type_id); 
	return 1;
}

CMD:editbusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;

	new 
		id,
		astr[90],
		bstr[90]
	;
		
	if(sscanf(params, "is[90]S()[90]", id, astr, bstr))
	{
		SendUsageMessage(playerid, "/editbusiness [business ID] [configuration]");
		SendServerMessage(playerid, "interior, entrance, type, level,");
		SendServerMessage(playerid, "entrancefee, name, bankpickup, marketprice"); 
		return 1;
	}
	
	if(!BusinessInfo[id][eBusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "You specified an invalid business ID.");
		
	if(!strcmp(astr, "interior"))
	{
		ConfirmDialog(playerid, "Confirmation", "Are you sure you want to change this businesses interior?", "OnBusinessInteriorChange", id); 
	}
	else if(!strcmp(astr, "entrance"))
	{
		ConfirmDialog(playerid, "Confirmation", "Are you sure you want to change this businesses entrance?", "OnBusinessEntranceChange", id); 
	}
	else if(!strcmp(astr, "type"))
	{
		new type;
		
		if(sscanf(bstr, "i", type))
		{
			SendUsageMessage(playerid, "/editbusiness %i type [type id]", id); 
			SendClientMessage(playerid, COLOR_WHITE, "Types: 1. Restaurant, 2. Ammunation, 3. Club,");
			SendClientMessage(playerid, COLOR_WHITE, "Types: 4. Bank, 5. General, 6. Dealership, 7. DMV."); 
			return 1;
		}

		if(type > 7 || type < 1)
			return SendErrorMessage(playerid, "You specified an invalid type.");
			
		if(type == BusinessInfo[id][eBusinessType])
			return SendErrorMessage(playerid, "You can't set the businesses type to what it already is."); 
			
		DestroyDynamicPickup(BusinessInfo[id][eBusinessPickup]);
			
		if(type == BUSINESS_TYPE_RESTAURANT)
		{
			if(!BusinessInfo[id][eBusinessOwnerDBID])
				BusinessInfo[id][eBusinessPickup] = CreateDynamicPickup(1272, 14, BusinessInfo[id][eBusinessEntrance][0], BusinessInfo[id][eBusinessEntrance][1], BusinessInfo[id][eBusinessEntrance][2], 0);
				
			else BusinessInfo[id][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[id][eBusinessEntrance][0], BusinessInfo[id][eBusinessEntrance][1], BusinessInfo[id][eBusinessEntrance][2], 0);
		}
		else BusinessInfo[id][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[id][eBusinessEntrance][0], BusinessInfo[id][eBusinessEntrance][1], BusinessInfo[id][eBusinessEntrance][2], 0);
		
		if(BusinessInfo[id][eBusinessType] == BUSINESS_TYPE_BANK)
		{
			DestroyDynamicPickup(BusinessInfo[id][eBusinessBankPickup]);
			
			for(new i = 0; i < 3; i++) {
				BusinessInfo[id][eBusinessBankPickupLoc][i] = 0.0; 
			}
			
			SendServerMessage(playerid, "This business is no longer a bank and the pickup was destroyed."); 
		}
		
		SendServerMessage(playerid, "You changed business %i's type to %i.", id, type);
		SaveBusiness(id);	
	}
	else if(!strcmp(astr, "level"))
	{
		new level;
		
		if(sscanf(bstr, "i", level))
			return SendUsageMessage(playerid, "/editbusiness %i level [level]", id);
			
		if(level < 1)
			return SendErrorMessage(playerid, "You can't make the level below 1."); 
			
		BusinessInfo[id][eBusinessLevel] = level;
		
		SendServerMessage(playerid, "You set business %i's level to %i.", id, level);
		SaveBusiness(id);
	}
	else if(!strcmp(astr, "entrancefee"))
	{
		new fee;
		
		if(sscanf(bstr, "i", fee))
			return SendUsageMessage(playerid, "/editbusiness %i entrancefee [amount]", id);
			
		if(fee > 1500)
			return SendErrorMessage(playerid, "The entrance fee can't be above 1500.");
			
		BusinessInfo[id][eBusinessEntranceFee] = fee;
		
		SendServerMessage(playerid, "You set business %i's entrance fee to %i.", id, fee);
		SaveBusiness(id);
	}
	else if(!strcmp(astr, "name"))
	{
		new bizname[90]; 
		
		if(sscanf(bstr, "s[90]", bizname))
		{
			SendUsageMessage(playerid, "/editbusiness %i name [business name]", id);
			SendServerMessage(playerid, "You can use text colors (i.e ~r~Red ~b~Blue) in the name."); 
			return 1;
		}
		
		if(strlen(bizname) > 90)
			return SendErrorMessage(playerid, "Stay below 90 characters.");
			
		SendServerMessage(playerid, "You set business %i's name from \"%s\" to \"%s\". ", id, BusinessInfo[id][eBusinessName], bizname); 
		
		format(BusinessInfo[id][eBusinessName], 90, "%s", bizname);
		SaveBusiness(id); 
	}
	else if(!strcmp(astr, "bankpickup"))
	{
		if(BusinessInfo[id][eBusinessType] != BUSINESS_TYPE_BANK)
			return SendErrorMessage(playerid, "This business isn't a bank."); 
			
		ConfirmDialog(playerid, "Confirmation", "Are you sure you want to set / change this banks pickup?", "OnBusinessBankpickupChange", id);
	}
	else if(!strcmp(astr, "marketprice"))
	{
		new price;
		
		if(sscanf(bstr, "i", price))
			return SendUsageMessage(playerid, "/editbusiness %i marketprice [amount]", id);
			
		BusinessInfo[id][eBusinessMarketPrice] = price;
		
		SendServerMessage(playerid, "You set business %i's market price to $%s.", id, MoneyFormat(price));
		SaveBusiness(id);
	}
	else return SendErrorMessage(playerid, "Invalid Parameter.");
	return 1;
}

CMD:callpaycheck(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return 0;
		
	ConfirmDialog(playerid, "Confirmation", "Are you sure you want to call a paycheck?\n\nThis action cannot be undone.", "OnCallPaycheck"); 
	return 1;
}

//Local functions:
function:LocalChat(playerid, Float:radi, string[], color1, color2, color3, color4)
{
	if (e_pAccountData[playerid][mLoggedin] == false)
		return 0;
		
	new
		Float:currentPos[3], 
		Float:oldPos[3],
		Float:checkPos[3]
	;
		
	GetPlayerPos(playerid, oldPos[0], oldPos[1], oldPos[2]); 
	foreach (new i : Player)
	{
		if (PlayerInfo[playerid][pLoggedin] == false) continue; 
		
		GetPlayerPos(i, currentPos[0], currentPos[1], currentPos[2]); 
		for (new p = 0; p < 3; p++)
		{
			checkPos[p] = (oldPos[p] - currentPos[p]);  
		}
		
		if (GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
			continue;
			
		if (((checkPos[0] < radi/16) && (checkPos[0] > -radi/16)) && ((checkPos[1] < radi/16) && (checkPos[1] > -radi/16)) && ((checkPos[2] < radi/16) && (checkPos[2] > -radi/16)))
		{
			SendClientMessage(i, color1, string);
		}
		else if (((checkPos[0] < radi/8) && (checkPos[0] > -radi/8)) && ((checkPos[1] < radi/8) && (checkPos[1] > -radi/8)) && ((checkPos[2] < radi/8) && (checkPos[2] > -radi/8)))
		{
			SendClientMessage(i, color2, string);
		}
		else if (((checkPos[0] < radi/4) && (checkPos[0] > -radi/4)) && ((checkPos[1] < radi/4) && (checkPos[1] > -radi/4)) && ((checkPos[2] < radi/4) && (checkPos[2] > -radi/4)))
		{
			SendClientMessage(i, color3, string);
		}
		else if (((checkPos[0] < radi/2) && (checkPos[0] > -radi/2)) && ((checkPos[1] < radi/2) && (checkPos[1] > -radi/2)) && ((checkPos[2] < radi/2) && (checkPos[2] > -radi/2)))
		{
			SendClientMessage(i, color4, string);
		}	
	}
	return 1;
}

function:OnPlayerReport(playerid, reportid, const text[])
{
	if(ReportInfo[reportid][rReportExists] == true)
	{
		for (new i = 1; i < sizeof(ReportInfo); i ++)
		{
			if(ReportInfo[i][rReportExists] == false)
			{
				reportid = i;
				break;
			}
		}
	}
		
	ReportInfo[reportid][rReportExists] = true;
	ReportInfo[reportid][rReportTime] = gettime();
		
	format(ReportInfo[reportid][rReportDetails], 90, "%s", text);
	ReportInfo[reportid][rReportBy] = playerid;
		
	SendServerMessage(playerid, "Your report was sent to all online admins.");
		
	if(strlen(text) > 67)
	{
		SendAdminMessageEx(COLOR_REPORT, 1, "[Report: %d] %s (%d): %.75s", reportid, ReturnName(playerid), playerid, text);
		SendAdminMessageEx(COLOR_REPORT, 1, "[Report: %d] ...%s", reportid, text[75]);
	}
	else SendAdminMessageEx(COLOR_REPORT, 1, "[Report: %d] %s (%d): %s", reportid, ReturnName(playerid), playerid, text);
		
	if(strfind(text, "hack", true) != -1 || strfind(text, "cheat", true) != -1)
	{
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin]) GameTextForPlayer(i, "~y~~h~Priority Report", 4000, 1);
		}
	}
	return 1;
}

function:ClearReports(playerid, response, reports)
{
	if(response)
	{
		for (new i = 0; i < sizeof(ReportInfo); i ++)
		{
			ReportInfo[i][rReportExists] = false;
			ReportInfo[i][rReportDetails] = ' '; 
			ReportInfo[i][rReportBy] = INVALID_PLAYER_ID;
			ReportInfo[i][rReportTime] = 0; 
		}
		
		new str[128];
		
		format(str, sizeof(str), "%s cleared %d active reports.", ReturnName(playerid), reports);
		SendAdminMessage(1, str); 
	}
	else return SendServerMessage(playerid, "You cancelled the confirmation.");
	return 1;
}

function:OnSetFaction(playerid, response, playerb, factionid)
{
	if(response)
	{
		PlayerInfo[playerb][pFaction] = factionid;
		PlayerInfo[playerb][pFactionRank] = FactionInfo[factionid][eFactionJoinRank]; 
		
		new str[128];
		
		format(str, sizeof(str), "%s set %s's faction to %d.", ReturnName(playerid), ReturnName(playerb), factionid);
		SendAdminMessage(4, str);
		
		SendServerMessage(playerb, "You were set to faction %d by Admin %s.", factionid, ReturnName(playerid));
		
		SaveCharacter(playerb);
	}
	else return SendServerMessage(playerid, "You disregarded the faction set.");
	return 1;
}

function:OnVehicleScrap(playerid, response, dbid, cash_back)
{
	if(response)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You're no longer in a vehicle. This was aborted.");
			
		new delQuery[128];
		
		mysql_format(ourConnection, delQuery, sizeof(delQuery), "DELETE FROM vehicles WHERE VehicleDBID = %i", dbid);
		mysql_tquery(ourConnection, delQuery); 
		
		SendServerMessage(playerid, "Your %s has been permanently deleted.", ReturnVehicleName(GetPlayerVehicleID(playerid))); 
		SendServerMessage(playerid, "You earned $%s from scrapping it.", MoneyFormat(cash_back));
		
		GiveMoney(playerid, cash_back); 
		
		ResetVehicleVars(GetPlayerVehicleID(playerid)); 
		DestroyVehicle(GetPlayerVehicleID(playerid)); 
		
		PlayerInfo[playerid][pVehicleSpawned] = false;
		PlayerInfo[playerid][pVehicleSpawnedID] = 0;
		
		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(PlayerInfo[playerid][pOwnedVehicles][i] == dbid)
			{
				PlayerInfo[playerid][pOwnedVehicles][i] = 0;
			}
		}
	}
	else return SendServerMessage(playerid, "This action was aborted.");
	return 1;
}

function:OnVehicleTow(playerid)
{
	new vehicleid = PlayerInfo[playerid][pVehicleSpawnedID], newDisplay[128]; 
	
	if(IsVehicleOccupied(vehicleid))
	{
		KillTimer(playerTowTimer[playerid]);
		SendServerMessage(playerid, "Your vehicle tow was interrupted."); 
		
		playerTowingVehicle[playerid] = false;	
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0;
		return 1;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount]++;
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 1) newDisplay = "(( || ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 2) newDisplay = "(( ||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 3) newDisplay = "(( |||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 4) newDisplay = "(( ||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 5) newDisplay = "(( |||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 6) newDisplay = "(( ||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 7) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 8) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	
	Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleTowDisplay], COLOR_DARKGREEN, newDisplay);
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 9)
	{
		SendServerMessage(playerid, "Your vehicle has been towed.");
		GiveMoney(playerid, -2000);
		
		playerTowingVehicle[playerid] = false;	
		SetVehicleToRespawn(vehicleid); 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		KillTimer(playerTowTimer[playerid]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0; 
		return 1;
	}
	
	return 1;
}

function:OnGascanRefill(playerid, vehicleid, x, y, z)
{
	new 
		text[128]
	; 
	if(GetVehicleDistanceFromPoint(vehicleid, x, y, z) > 3)
	{
		SendClientMessage(playerid, COLOR_ACTION, "The vehicle you were refilling moved and canceled."); 
		
		KillTimer(playerRefillTimer[playerid]);
		playerRefillingVehicle[playerid] = false; 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleRefillDisplay]); 
		VehicleInfo[vehicleid][eVehicleRefillCount] = 0; 
		return 1;
	}
	
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]))
	{
		SendClientMessage(playerid, COLOR_ACTION, "You moved and stopped refilling the vehicle."); 
		
		KillTimer(playerRefillTimer[playerid]);
		playerRefillingVehicle[playerid] = false; 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleRefillDisplay]); 
		VehicleInfo[vehicleid][eVehicleRefillCount] = 0; 
		return 1;
	}
	
	VehicleInfo[vehicleid][eVehicleRefillCount] ++;
	
	switch(VehicleInfo[vehicleid][eVehicleRefillCount])
	{
		case 2: text = "(( ||----- ))\nREFILLING VEHICLE";
		case 3: text = "(( |||---- ))\nREFILLING VEHICLE";
		case 4: text = "(( ||||--- ))\nREFILLING VEHICLE";
		case 5: text = "(( |||||-- ))\nREFILLING VEHICLE";
		case 6: text = "(( ||||||- ))\nREFILLING VEHICLE";
		case 7: text = "(( ||||||| ))\nREFILLING VEHICLE";
		case 8:
		{
			KillTimer(playerRefillTimer[playerid]);
			playerRefillingVehicle[playerid] = false; 
			
			Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleRefillDisplay]); 
			VehicleInfo[vehicleid][eVehicleRefillCount] = 0; 
			
			VehicleInfo[vehicleid][eVehicleFuel] = 50;
			
			SendClientMessageEx(playerid, COLOR_ACTION, "You refilled the %s to 50 percent fuel.", ReturnVehicleName(vehicleid)); 
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s refilled the %s with their gas can.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid)); 
			return 1;
		}
	}
	
	Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleRefillDisplay], COLOR_DARKGREEN, text); 
	return 1;
}

function:OnPlayerRelog(playerid)
{
	new 
		updateLabel[90],
		relogCheck[60]
	;
	
	PlayerInfo[playerid][pRelogCount] ++; 
	
	if(PlayerInfo[playerid][pRelogCount] == 2)
		updateLabel = "(( ||----- ))\nRELOGGING"; 
		
	if(PlayerInfo[playerid][pRelogCount] == 3)
		updateLabel = "(( |||---- ))\nRELOGGING"; 
		
	if(PlayerInfo[playerid][pRelogCount] == 4)
		updateLabel = "(( ||||--- ))\nRELOGGING"; 
		
	if(PlayerInfo[playerid][pRelogCount] == 5)
		updateLabel = "(( |||||-- ))\nRELOGGING"; 
		
	if(PlayerInfo[playerid][pRelogCount] == 6)
		updateLabel = "(( ||||||- ))\nRELOGGING"; 
		
	if(PlayerInfo[playerid][pRelogCount] == 7)
		updateLabel = "(( ||||||| ))\nRELOGGING";  
		
	Update3DTextLabelText(PlayerInfo[playerid][pRelogTD], COLOR_DARKGREEN, updateLabel);
	
	if(PlayerInfo[playerid][pRelogCount] == 8)
	{
		Delete3DTextLabel(PlayerInfo[playerid][pRelogTD]);
		KillTimer(PlayerInfo[playerid][pRelogTimer]); 
		
		PlayerInfo[playerid][pRelogging] = false;
		PlayerInfo[playerid][pRelogCount] = 0; 
		
		SaveCharacter(playerid); SaveCharacterPos(playerid);
		
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0); 
		
		PlayerInfo[playerid][pLoggedin] = false;
		e_pAccountData[playerid][mLoggedin] = false;
		
		SetPlayerName(playerid, e_pAccountData[playerid][mAccName]); 
		TogglePlayerSpectating(playerid, true); SetPlayerCamera(playerid);

		mysql_format(ourConnection, relogCheck, sizeof(relogCheck), "SELECT acc_dbid FROM masters WHERE acc_name = '%e'", ReturnName(playerid));
		mysql_tquery(ourConnection, relogCheck, "LogPlayerIn", "i", playerid);
		
		return 1;
	}
		
	return 1;
}

function:OnVehicleTextdraw(playerid)
{
	if(IsValidDynamic3DTextLabel(playerVehicleTextdraw[playerid]))
		DestroyDynamic3DTextLabel(playerVehicleTextdraw[playerid]);
		
	playerTextdraw[playerid] = false; 
	return 1;
}

function:OnPropertyBoombox(playerid, response, propertyid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response)
	{
		GiveMoney(playerid, -1000); 
		
		DestroyDynamicObject(PlayerInfo[playerid][pAddObject]); 
		PlayerInfo[playerid][pEditingObject] = 0; 
	
		PropertyInfo[propertyid][ePropertyBoomboxObject] = CreateDynamicObject(2103, x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
		PropertyInfo[propertyid][ePropertyHasBoombox] = true;
		
		PropertyInfo[propertyid][ePropertyBoomboxPos][0] = x;
		PropertyInfo[propertyid][ePropertyBoomboxPos][1] = y;
		PropertyInfo[propertyid][ePropertyBoomboxPos][2] = z;
		
		PropertyInfo[propertyid][ePropertyBoomboxRot][0] = rx;
		PropertyInfo[propertyid][ePropertyBoomboxRot][1] = ry;
		PropertyInfo[propertyid][ePropertyBoomboxRot][2] = rz;
		
		SendServerMessage(playerid, "You bought a boombox for your property."); 
		SaveProperty(propertyid); 
	}
	else
	{
		DestroyDynamicObject(PlayerInfo[playerid][pAddObject]); 
		PlayerInfo[playerid][pEditingObject] = 0; 
		
		SendServerMessage(playerid, "You cancelled."); 
	}
	return 1;
}

function:OnRemoveBoombox(playerid, response, propertyid)
{
	if(response)
	{
		DestroyDynamicObject(PropertyInfo[propertyid][ePropertyBoomboxObject]);
		PropertyInfo[propertyid][ePropertyHasBoombox] = false;
		
		for(new i = 0; i < 3; i++)
		{
			PropertyInfo[propertyid][ePropertyBoomboxPos][i] = 0.0; 
			PropertyInfo[propertyid][ePropertyBoomboxRot][i] = 0.0; 
		}
		
		SendServerMessage(playerid, "You removed your properties boombox.");
		SaveProperty(propertyid);
	}
	else return SendServerMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessInteriorChange(playerid, response, businessid)
{
	if(response)
	{
		GetPlayerPos(playerid, BusinessInfo[businessid][eBusinessInterior][0], BusinessInfo[businessid][eBusinessInterior][1], BusinessInfo[businessid][eBusinessInterior][2]);
		
		new 
			world = random(20000)+playerid+2; 
		
		BusinessInfo[businessid][eBusinessInteriorIntID] = GetPlayerInterior(playerid);
		BusinessInfo[businessid][eBusinessInteriorWorld] = world;
		
		SendServerMessage(playerid, "You changed Business %i's interior ID.", businessid);
		
		foreach(new i : Player) if(IsPlayerInBusiness(i) == businessid)
		{
			SetPlayerPos(i, BusinessInfo[businessid][eBusinessInterior][0], BusinessInfo[businessid][eBusinessInterior][1], BusinessInfo[businessid][eBusinessInterior][2]);
			SetPlayerInterior(i, GetPlayerInterior(playerid)); SetPlayerVirtualWorld(playerid, world); 
			
			SendServerMessage(i, "The business you were in was amended."); 
		}
		
		if(BusinessInfo[businessid][eBusinessType] == BUSINESS_TYPE_BANK)
		{
			if(IsValidDynamicPickup(BusinessInfo[businessid][eBusinessBankPickup]))
			{
				DestroyDynamicObject(BusinessInfo[businessid][eBusinessBankPickup]); 
				SendServerMessage(playerid, "This businesses' bank pickup was destroyed and needs to be remade."); 
			}
			
			for(new i = 0; i < 3; i++)
			{
				BusinessInfo[businessid][eBusinessBankPickupLoc][i] = 0.0; 
			}
		}
	
		SaveBusiness(businessid); 
	}
	else return SendServerMessage(playerid, "You cancelled."); 
	return 1; 
}

function:OnBusinessEntranceChange(playerid, response, businessid)
{
	if(response)
	{
		GetPlayerPos(playerid, BusinessInfo[businessid][eBusinessEntrance][0], BusinessInfo[businessid][eBusinessEntrance][1], BusinessInfo[businessid][eBusinessEntrance][2]); 
		
		if(IsValidDynamicObject(BusinessInfo[businessid][eBusinessPickup]))
			DestroyDynamicPickup(BusinessInfo[businessid][eBusinessPickup]); 
			
		if(BusinessInfo[businessid][eBusinessType] == BUSINESS_TYPE_RESTAURANT)
		{
			if(!BusinessInfo[businessid][eBusinessOwnerDBID])
				BusinessInfo[businessid][eBusinessPickup] = CreateDynamicPickup(1272, 14, BusinessInfo[businessid][eBusinessEntrance][0], BusinessInfo[businessid][eBusinessEntrance][1], BusinessInfo[businessid][eBusinessEntrance][2], 0);
				
			else BusinessInfo[businessid][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[businessid][eBusinessEntrance][0], BusinessInfo[businessid][eBusinessEntrance][1], BusinessInfo[businessid][eBusinessEntrance][2], 0);
		}
		else BusinessInfo[businessid][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[businessid][eBusinessEntrance][0], BusinessInfo[businessid][eBusinessEntrance][1], BusinessInfo[businessid][eBusinessEntrance][2], 0); 
		
		SendServerMessage(playerid, "You changed Business %i's entrance.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendServerMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessBankpickupChange(playerid, response, businessid)
{
	if(response)
	{
		GetPlayerPos(playerid, BusinessInfo[businessid][eBusinessBankPickupLoc][0], BusinessInfo[businessid][eBusinessBankPickupLoc][1], BusinessInfo[businessid][eBusinessBankPickupLoc][2]);
		BusinessInfo[businessid][eBusinessBankPickupWorld] = GetPlayerVirtualWorld(playerid);
		
		if(IsValidDynamicPickup(BusinessInfo[businessid][eBusinessBankPickup]))
			DestroyDynamicPickup(BusinessInfo[businessid][eBusinessBankPickup]); 
			
		BusinessInfo[businessid][eBusinessBankPickup] = CreateDynamicPickup(1274, 2, BusinessInfo[businessid][eBusinessBankPickupLoc][0], BusinessInfo[businessid][eBusinessBankPickupLoc][1], BusinessInfo[businessid][eBusinessBankPickupLoc][2], BusinessInfo[businessid][eBusinessBankPickupWorld]);
		
		SendServerMessage(playerid, "You changed business %i's bank point.", businessid); 
		SaveBusiness(businessid);
	}
	else return SendServerMessage(playerid, "You cancelled.");
	return 1;
}

function:OnSellBusiness(playerid, response, businessid)
{
	if(response)
	{
		new
			totalPay
		;
		
		totalPay = BusinessInfo[businessid][eBusinessMarketPrice] / 2 + BusinessInfo[businessid][eBusinessCashbox]; 
		GiveMoney(playerid, totalPay); 
		
		BusinessInfo[businessid][eBusinessOwnerDBID] = 0; 
		
		if(BusinessInfo[businessid][eBusinessType] == BUSINESS_TYPE_RESTAURANT)
		{
			DestroyDynamicPickup(BusinessInfo[businessid][eBusinessPickup]);
			BusinessInfo[businessid][eBusinessPickup] = CreateDynamicPickup(1272, 14, BusinessInfo[businessid][eBusinessEntrance][0], BusinessInfo[businessid][eBusinessEntrance][1], BusinessInfo[businessid][eBusinessEntrance][2], 0);
		}
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessageEx(playerid, COLOR_ACTION, "You sold your business and earned $%s.", MoneyFormat(totalPay)); 
		
		SaveBusiness(businessid); SaveCharacter(playerid); 
	}
	else return SendServerMessage(playerid, "You cancelled.");
	return 1;
}

function:OnPlateSet(playerid)
{
	for(new i = 0; i < 2; i++)
	{
		PlayerTextDrawHide(playerid, CarBought_PTD[playerid][i]);
	}
	return 1;
}

function:OnPlayerExitDealership(playerid, response)
{
	if(response)
	{
		SendServerMessage(playerid, "You exited out the dealership.");
		
		ResetVehicleVars(DealershipPlayerCar[playerid]); 
		DestroyVehicle(DealershipPlayerCar[playerid]); 
		
		ResetDealershipVars(playerid);
		TogglePlayerControllable(playerid, 1); 
	}
	else return ShowDealerAppend(playerid);
	return 1;
}

function:OnPlayerVehiclePurchase(playerid, id, plates[], Float:x, Float:y, Float:z, Float:a)
{
	new
		vehicleid = INVALID_VEHICLE_ID
	;
	
	DestroyVehicle(DealershipPlayerCar[playerid]);
	
	vehicleid = 
		CreateVehicle(g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModelID], x, y, z, a, DealershipCarColors[playerid][0], DealershipCarColors[playerid][1], -1);  
		
	SetVehicleNumberPlate(vehicleid, plates); 
	SetVehicleToRespawn(vehicleid); 
	
	PutPlayerInVehicle(playerid, vehicleid, 0); 
	PlayerInfo[playerid][pOwnedVehicles][id] = cache_insert_id(); 
	
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = cache_insert_id();
		VehicleInfo[vehicleid][eVehicleOwnerDBID] = PlayerInfo[playerid][pDBID]; 
		
		VehicleInfo[vehicleid][eVehicleModel] = g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModelID];
		
		VehicleInfo[vehicleid][eVehicleColor1] = DealershipCarColors[playerid][0];
		VehicleInfo[vehicleid][eVehicleColor2] = DealershipCarColors[playerid][1];
		
		VehicleInfo[vehicleid][eVehiclePaintjob] = -1;
		
		VehicleInfo[vehicleid][eVehicleParkPos][0] = x;
		VehicleInfo[vehicleid][eVehicleParkPos][1] = y;
		VehicleInfo[vehicleid][eVehicleParkPos][2] = z;
		VehicleInfo[vehicleid][eVehicleParkPos][3] = a;
		
		format(VehicleInfo[vehicleid][eVehiclePlates], 32, "%s", plates); 
		
		VehicleInfo[vehicleid][eVehicleLocked] = false;
		VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		
		VehicleInfo[vehicleid][eVehicleFuel] = 50; 
		
		VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
		VehicleInfo[vehicleid][eVehicleEngine] = 100.0; 
		
		VehicleInfo[vehicleid][eVehicleHasXMR] = bool:DealershipXMR[playerid];
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = DealershipAlarmLevel[playerid];
		VehicleInfo[vehicleid][eVehicleLockLevel] = DealershipLockLevel[playerid]; 
		VehicleInfo[vehicleid][eVehicleImmobLevel] = DealershipImmobLevel[playerid]; 
		
		for(new i = 1; i< 6; i++)
		{
			VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
			VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0; 
		}
		
		SaveVehicle(vehicleid);
		
		PlayerInfo[playerid][pVehicleSpawned] = true;
		PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid;
	}
	
	SendClientMessageEx(playerid, 0xB9E35EFF, "PROCESSED: You successfully bought a %s for $%s.", ReturnVehicleName(vehicleid), MoneyFormat(DealershipTotalCost[playerid]));
	cmd_v(playerid, "stats");
	
	PlayerPurchasingVehicle[playerid] = false;
	ResetDealershipVars(playerid); 
	return 1;
}

function:OnCallPaycheck(playerid, response)
{
	new
		str[128]
	;
	
	if(response)
	{
		format(str, sizeof(str), "%s called a paycheck.", ReturnName(playerid));
		SendAdminMessage(3, str);
		
		CallPaycheck(); 
	}
	return 1;
}

function:OnPlayerPurchaseWeapon(playerid, response, weapon, ammo, price)
{
	if(response)
	{
		if(price > PlayerInfo[playerid][pMoney])
			return SendErrorMessage(playerid, "You can't afford this. (Cost: $%s, Total: $%s)", MoneyFormat(price), MoneyFormat(PlayerInfo[playerid][pMoney]));
	
		new
			str[128]
		;
		
		GiveMoney(playerid, -price);
		GivePlayerGun(playerid, weapon, ammo);
		
		format(str, sizeof(str), "%s bought %s and %d Ammo", ReturnName(playerid), ReturnWeaponName(weapon), ammo);
		SendAdminMessage(1, str); 
	}
	return 1;
}

function:OnPlayerPurchaseArmor(playerid, response)
{
	if(response)
	{
		if(2000 > PlayerInfo[playerid][pMoney])
			return SendErrorMessage(playerid, "You can't afford this. (Cost: $2,000, Total: $%s)", MoneyFormat(PlayerInfo[playerid][pMoney]));
			
		new
			str[128]
		;
	
		SetPlayerArmour(playerid, 50); 
		
		format(str, sizeof(str), "%s bought Armor.", ReturnName(playerid));
		SendAdminMessage(1, str); 
	}
	return 1;
}

function:OnPlayerAddCharge(playerid, playerb, charge[])
{
	SendPoliceMessage(COLOR_COP, "[WANTED] Suspect: %s Charger: %s Reason: %s", ReturnName(playerb), ReturnName(playerid), charge);
	PlayerInfo[playerb][pActiveListings]++; 
	
	new 
		query[128];
	 
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pActiveListings = %i WHERE char_dbid = %i", PlayerInfo[playerb][pActiveListings], PlayerInfo[playerb][pDBID]);
	mysql_pquery(ourConnection, query);
	return 1; 
}

function:OnPlayerPurchaseAmmo(playerid, response, weaponid, ammo, price)
{
	if(response)
	{
		new
			slot,
			currammo,
			str[128]
		;
		
		slot = ReturnWeaponIDSlot(weaponid); 
		currammo = PlayerInfo[playerid][pWeaponsAmmo][slot];
		
		GiveMoney(playerid, -price);
		SetPlayerAmmo(playerid, weaponid, currammo + ammo); 
		
		format(str, sizeof(str), "%s bought %d Ammo for %s", ReturnName(playerid), ammo, ReturnWeaponName(weaponid));
		SendAdminMessage(1, str); 
	}
	return 1;
}

function:Query_InsertFaction(playerid, varName, varAbbrev, idx)
{
	new insertRanks[90], str[128];
		
	mysql_format(ourConnection, insertRanks, sizeof(insertRanks), "INSERT INTO faction_ranks (`factionid`) VALUES(%i)", cache_insert_id()); 
	mysql_tquery(ourConnection, insertRanks); 
	
	FactionInfo[idx][eFactionDBID] = cache_insert_id();
		
	format(FactionInfo[idx][eFactionName], 90, "%s", varName);
	format(FactionInfo[idx][eFactionAbbrev], 30, "%s", varAbbrev); 
		
	format(str, sizeof(str), "%s has created Faction ID %d.", ReturnName(playerid), cache_insert_id());
	SendAdminMessage(4, str);
	
	SendServerMessage(COLOR_RED, "To configure the faction, use \"/editfaction\". "); 
	return 1;
}

function:Query_InsertBusiness(playerid, newid, type)
{
	BusinessInfo[newid][eBusinessDBID] = cache_insert_id(); 
	BusinessInfo[newid][eBusinessType] = type; 
	
	SendServerMessage(playerid, "You created business ID %i. To configure, use \"/editbusiness\". ", newid); 
	return 1;
}

function:Query_LoadFactions()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No factions were loaded from \"%s\" database...", SQL_DATABASE);
		
	new newThread[128], rows, fields; cache_get_data(rows, fields, ourConnection);
	
	for (new i = 0; i < rows && i < MAX_FACTIONS; i ++)
	{
		FactionInfo[i+1][eFactionDBID] = cache_get_field_content_int(i, "DBID", ourConnection);
		
		cache_get_field_content(i, "FactionName", FactionInfo[i+1][eFactionName], ourConnection, 90);
		cache_get_field_content(i, "FactionAbbrev", FactionInfo[i+1][eFactionAbbrev], ourConnection, 30);
		
		FactionInfo[i+1][eFactionSpawn][0] = cache_get_field_content_float(i, "FactionSpawnX", ourConnection);
		FactionInfo[i+1][eFactionSpawn][1] = cache_get_field_content_float(i, "FactionSpawnY", ourConnection);
		FactionInfo[i+1][eFactionSpawn][2] = cache_get_field_content_float(i, "FactionSpawnZ", ourConnection);
		
		FactionInfo[i+1][eFactionSpawnInt] = cache_get_field_content_int(i, "FactionInterior", ourConnection);
		FactionInfo[i+1][eFactionSpawnWorld] = cache_get_field_content_int(i, "FactionWorld", ourConnection);
		
		FactionInfo[i+1][eFactionJoinRank] = cache_get_field_content_int(i, "FactionJoinRank", ourConnection);
		FactionInfo[i+1][eFactionAlterRank] = cache_get_field_content_int(i, "FactionAlterRank", ourConnection);
		FactionInfo[i+1][eFactionChatRank] = cache_get_field_content_int(i, "FactionChatRank", ourConnection);
		FactionInfo[i+1][eFactionTowRank] = cache_get_field_content_int(i, "FactionTowRank", ourConnection);
		
		FactionInfo[i+1][eFactionChatColor] = cache_get_field_content_int(i, "FactionChatColor", ourConnection);
		
		FactionInfo[i+1][eFactionType] = cache_get_field_content_int(i, "FactionType", ourConnection);
		
		mysql_format(ourConnection, newThread, sizeof(newThread), "SELECT * FROM faction_ranks WHERE factionid = %i", i+1); 
		mysql_tquery(ourConnection, newThread, "Query_LoadFactionRanks", "i", i+1);
	}
	printf("[SERVER]: %i factions were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return 1;
}

function:Query_LoadFactionRanks(factionid)
{
	new str[128];
	
	new rows, fields; cache_get_data(rows, fields, ourConnection);
	
	for (new i = 0; i < rows; i++)
	{
		for (new j = 1; j < MAX_FACTION_RANKS; j++)
		{
			format(str, sizeof(str), "FactionRank%i", j); 
			cache_get_field_content(i, str, FactionRanks[factionid][j], ourConnection, 60);
		}
	}
	return 1;
}

function:Query_LoadPrivateVehicle(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "An error occurred while loading your vehicle."); 
		
	new rows, fields; cache_get_data(rows, fields, ourConnection); 
	new str[128], vehicleid = INVALID_VEHICLE_ID; 
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		vehicleid = CreateVehicle(cache_get_field_content_int(i, "VehicleModel", ourConnection), 
			cache_get_field_content_float(i, "VehicleParkPosX", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosY", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosZ", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosA", ourConnection),
			cache_get_field_content_int(i, "VehicleColor1", ourConnection),
			cache_get_field_content_int(i, "VehicleColor2", ourConnection),
			-1,
			0);
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			VehicleInfo[vehicleid][eVehicleDBID] = cache_get_field_content_int(i, "VehicleDBID", ourConnection); 
			
			VehicleInfo[vehicleid][eVehicleOwnerDBID] = cache_get_field_content_int(i, "VehicleOwnerDBID", ourConnection);
			VehicleInfo[vehicleid][eVehicleFaction] = cache_get_field_content_int(i, "VehicleFaction", ourConnection); 
			
			VehicleInfo[vehicleid][eVehicleModel] = cache_get_field_content_int(i, "VehicleModel", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleColor1] = cache_get_field_content_int(i, "VehicleColor1", ourConnection);
			VehicleInfo[vehicleid][eVehicleColor2] = cache_get_field_content_int(i, "VehicleColor2", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleParkPos][0] = cache_get_field_content_float(i, "VehicleParkPosX", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][1] = cache_get_field_content_float(i, "VehicleParkPosY", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][2] = cache_get_field_content_float(i, "VehicleParkPosZ", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][3] = cache_get_field_content_float(i, "VehicleParkPosA", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleParkInterior] = cache_get_field_content_int(i, "VehicleParkInterior", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkWorld] = cache_get_field_content_int(i, "VehicleParkWorld", ourConnection);
			
			cache_get_field_content(i, "VehiclePlates", VehicleInfo[vehicleid][eVehiclePlates], ourConnection, 32);
			VehicleInfo[vehicleid][eVehicleLocked] = bool:cache_get_field_content_int(i, "VehicleLocked", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleImpounded] = bool:cache_get_field_content_int(i, "VehicleImpounded", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleImpoundPos][0] = cache_get_field_content_float(i, "VehicleImpoundPosX", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][1] = cache_get_field_content_float(i, "VehicleImpoundPosY", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][2] = cache_get_field_content_float(i, "VehicleImpoundPosZ", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][3] = cache_get_field_content_float(i, "VehicleImpoundPosA", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleFuel] = cache_get_field_content_int(i, "VehicleFuel", ourConnection); 
			
			VehicleInfo[vehicleid][eVehicleHasXMR] = bool:cache_get_field_content_int(i, "VehicleXMR", ourConnection);
			VehicleInfo[vehicleid][eVehicleTimesDestroyed] = cache_get_field_content_int(i, "VehicleTimesDestroyed", ourConnection);
						
			VehicleInfo[vehicleid][eVehicleEngine] = cache_get_field_content_float(i, "VehicleEngine", ourConnection);
			VehicleInfo[vehicleid][eVehicleBattery] = cache_get_field_content_float(i, "VehicleBattery", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleAlarmLevel] = cache_get_field_content_int(i, "VehicleAlarmLevel", ourConnection);
			VehicleInfo[vehicleid][eVehicleLockLevel] = cache_get_field_content_int(i, "VehicleLockLevel", ourConnection);
			VehicleInfo[vehicleid][eVehicleImmobLevel] = cache_get_field_content_int(i, "VehicleImmobLevel", ourConnection);
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				VehicleInfo[vehicleid][eVehicleWeapons][j] = cache_get_field_content_int(i, str, ourConnection);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j] = cache_get_field_content_int(i, str, ourConnection);
			}
			
			for(new d = 1; d < 5; d++)
			{
				format(str, sizeof(str), "VehicleLastDrivers%d", d);
				VehicleInfo[vehicleid][eVehicleLastDrivers][d] = cache_get_field_content_int(i, str, ourConnection);
				
				format(str, sizeof(str), "VehicleLastPassengers%d", d);
				VehicleInfo[vehicleid][eVehicleLastPassengers][d] = cache_get_field_content_int(i, str, ourConnection);
			}
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleLocked] == false)
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
				
			else SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			
			if(HasNoEngine(playerid))
				ToggleVehicleEngine(vehicleid, true); 
		}
	}
	
	PlayerInfo[playerid][pVehicleSpawned] = true;
	PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid; 
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "%s has been spawned at its parking place.", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lifespan: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%d]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	if(VehicleInfo[vehicleid][eVehicleImpounded]) SendClientMessage(playerid, COLOR_RED, "Your vehicle is impounded.");
	
	SendClientMessage(playerid, 0xFF00FFFF, "Hint: Follow the red marker to your parking place.");
	SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 3.0);
	
	PlayerCheckpoint[playerid] = 1; 
	return 1;
}

function:Query_LoadProperties()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No properties were loaded from \"%s\" database...", SQL_DATABASE);
	
	new rows, fields; cache_get_data(rows, fields, ourConnection);
	new countProperties = 0, str[128];

	for(new i = 0; i < rows && i < MAX_PROPERTY; i++)
	{
		PropertyInfo[i+1][ePropertyDBID] = cache_get_field_content_int(i, "PropertyDBID", ourConnection);
		PropertyInfo[i+1][ePropertyOwnerDBID] = cache_get_field_content_int(i, "PropertyOwnerDBID", ourConnection);
		
		PropertyInfo[i+1][ePropertyType] = cache_get_field_content_int(i, "PropertyType", ourConnection);
		PropertyInfo[i+1][ePropertyFaction] = cache_get_field_content_int(i, "PropertyFaction", ourConnection);
		
		PropertyInfo[i+1][ePropertyEntrance][0] = cache_get_field_content_float(i, "PropertyEntranceX", ourConnection);
		PropertyInfo[i+1][ePropertyEntrance][1] = cache_get_field_content_float(i, "PropertyEntranceY", ourConnection);
		PropertyInfo[i+1][ePropertyEntrance][2] = cache_get_field_content_float(i, "PropertyEntranceZ", ourConnection);
		
		PropertyInfo[i+1][ePropertyEntranceInterior] = cache_get_field_content_int(i, "PropertyEntranceInterior", ourConnection);
		PropertyInfo[i+1][ePropertyEntranceWorld] = cache_get_field_content_int(i, "PropertyEntranceWorld", ourConnection);
		
		PropertyInfo[i+1][ePropertyInterior][0] = cache_get_field_content_float(i, "PropertyInteriorX", ourConnection);
		PropertyInfo[i+1][ePropertyInterior][1] = cache_get_field_content_float(i, "PropertyInteriorY", ourConnection);
		PropertyInfo[i+1][ePropertyInterior][2] = cache_get_field_content_float(i, "PropertyInteriorZ", ourConnection);
		
		PropertyInfo[i+1][ePropertyInteriorIntID] = cache_get_field_content_int(i, "PropertyInteriorIntID", ourConnection);
		PropertyInfo[i+1][ePropertyInteriorWorld] = cache_get_field_content_int(i, "PropertyInteriorWorld", ourConnection);
		
		PropertyInfo[i+1][ePropertyMarketPrice] = cache_get_field_content_int(i, "PropertyMarketPrice", ourConnection);
		PropertyInfo[i+1][ePropertyLevel] = cache_get_field_content_int(i, "PropertyLocked", ourConnection);
		
		PropertyInfo[i+1][ePropertyLocked] = bool:cache_get_field_content_int(i, "PropertyLocked", ourConnection);
		
		PropertyInfo[i+1][ePropertyCashbox] = cache_get_field_content_int(i, "PropertyCashbox", ourConnection);
		
		PropertyInfo[i+1][ePropertyPlacePos][0] = cache_get_field_content_float(i, "PropertyPlacePosX", ourConnection);
		PropertyInfo[i+1][ePropertyPlacePos][1] = cache_get_field_content_float(i, "PropertyPlacePosY", ourConnection);
		PropertyInfo[i+1][ePropertyPlacePos][2] = cache_get_field_content_float(i, "PropertyPlacePosZ", ourConnection);
		
		for(new w = 1; w < 21; w++)
		{
			format(str, sizeof(str), "PropertyWeapon%i", w);
			PropertyInfo[i+1][ePropertyWeapons][w] = cache_get_field_content_int(i, str, ourConnection);
			
			format(str, sizeof(str), "PropertyWeaponAmmo%i", w);
			PropertyInfo[i+1][ePropertyWeaponsAmmo][w] = cache_get_field_content_int(i, str, ourConnection);
		}
		
		PropertyInfo[i+1][ePropertyHasBoombox] = bool:cache_get_field_content_int(i, "PropertyHasBoombox", ourConnection);
		
		PropertyInfo[i+1][ePropertyBoomboxPos][0] = cache_get_field_content_float(i, "PropertyBoomboxPosX", ourConnection);
		PropertyInfo[i+1][ePropertyBoomboxPos][1] = cache_get_field_content_float(i, "PropertyBoomboxPosY", ourConnection);
		PropertyInfo[i+1][ePropertyBoomboxPos][2] = cache_get_field_content_float(i, "PropertyBoomboxPosZ", ourConnection);
		
		PropertyInfo[i+1][ePropertyBoomboxRot][0] = cache_get_field_content_float(i, "PropertyBoomboxRotX", ourConnection);
		PropertyInfo[i+1][ePropertyBoomboxRot][1] = cache_get_field_content_float(i, "PropertyBoomboxRotY", ourConnection);
		PropertyInfo[i+1][ePropertyBoomboxRot][2] = cache_get_field_content_float(i, "PropertyBoomboxRotZ", ourConnection);
		
		if(PropertyInfo[i+1][ePropertyHasBoombox])
		{
			PropertyInfo[i+1][ePropertyBoomboxObject] = CreateDynamicObject(2103, PropertyInfo[i+1][ePropertyBoomboxPos][0], PropertyInfo[i+1][ePropertyBoomboxPos][1], PropertyInfo[i+1][ePropertyBoomboxPos][2],
				PropertyInfo[i+1][ePropertyBoomboxRot][0], PropertyInfo[i+1][ePropertyBoomboxRot][1], PropertyInfo[i+1][ePropertyBoomboxRot][2], PropertyInfo[i+1][ePropertyInteriorWorld], PropertyInfo[i+1][ePropertyInteriorIntID]);
		}
		
		countProperties++; 
	}
	
	printf("[SERVER]: %i properties were loaded from \"%s\" database...", countProperties, SQL_DATABASE);
	return 1;
}

function:Query_LoadVehicles()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No vehicles were loaded from \"%s\" database...", SQL_DATABASE);
	
	new rows, fields; cache_get_data(rows, fields, ourConnection);
	new endCount = 0, str[128], vehicleid = INVALID_VEHICLE_ID; 
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i ++)
	{
		vehicleid = CreateVehicle(cache_get_field_content_int(i, "VehicleModel", ourConnection), 
			cache_get_field_content_float(i, "VehicleParkPosX", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosY", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosZ", ourConnection),
			cache_get_field_content_float(i, "VehicleParkPosA", ourConnection),
			cache_get_field_content_int(i, "VehicleColor1", ourConnection),
			cache_get_field_content_int(i, "VehicleColor2", ourConnection),
			-1,
			cache_get_field_content_int(i, "VehicleSirens", ourConnection));
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			VehicleInfo[vehicleid][eVehicleDBID] = cache_get_field_content_int(i, "VehicleDBID", ourConnection); 
			
			VehicleInfo[vehicleid][eVehicleOwnerDBID] = cache_get_field_content_int(i, "VehicleOwnerDBID", ourConnection);
			VehicleInfo[vehicleid][eVehicleFaction] = cache_get_field_content_int(i, "VehicleFaction", ourConnection); 
			
			VehicleInfo[vehicleid][eVehicleModel] = cache_get_field_content_int(i, "VehicleModel", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleColor1] = cache_get_field_content_int(i, "VehicleColor1", ourConnection);
			VehicleInfo[vehicleid][eVehicleColor2] = cache_get_field_content_int(i, "VehicleColor2", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleParkPos][0] = cache_get_field_content_float(i, "VehicleParkPosX", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][1] = cache_get_field_content_float(i, "VehicleParkPosY", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][2] = cache_get_field_content_float(i, "VehicleParkPosZ", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkPos][3] = cache_get_field_content_float(i, "VehicleParkPosA", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleParkInterior] = cache_get_field_content_int(i, "VehicleParkInterior", ourConnection);
			VehicleInfo[vehicleid][eVehicleParkWorld] = cache_get_field_content_int(i, "VehicleParkWorld", ourConnection);
			
			cache_get_field_content(i, "VehiclePlates", VehicleInfo[vehicleid][eVehiclePlates], ourConnection, 32);
			VehicleInfo[vehicleid][eVehicleLocked] = bool:cache_get_field_content_int(i, "VehicleLocked", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleImpounded] = bool:cache_get_field_content_int(i, "VehicleImpounded", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleImpoundPos][0] = cache_get_field_content_float(i, "VehicleImpoundPosX", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][1] = cache_get_field_content_float(i, "VehicleImpoundPosY", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][2] = cache_get_field_content_float(i, "VehicleImpoundPosZ", ourConnection);
			VehicleInfo[vehicleid][eVehicleImpoundPos][3] = cache_get_field_content_float(i, "VehicleImpoundPosA", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleFuel] = cache_get_field_content_int(i, "VehicleFuel", ourConnection); 
			VehicleInfo[vehicleid][eVehicleSirens] = cache_get_field_content_int(i, "VehicleSirens", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleHasXMR] = bool:cache_get_field_content_int(i, "VehicleXMR", ourConnection);
			VehicleInfo[vehicleid][eVehicleTimesDestroyed] = cache_get_field_content_int(i, "VehicleTimesDestroyed", ourConnection);
						
			VehicleInfo[vehicleid][eVehicleEngine] = cache_get_field_content_float(i, "VehicleEngine", ourConnection);
			VehicleInfo[vehicleid][eVehicleBattery] = cache_get_field_content_float(i, "VehicleBattery", ourConnection);
			
			VehicleInfo[vehicleid][eVehicleAlarmLevel] = cache_get_field_content_int(i, "VehicleAlarmLevel", ourConnection);
			VehicleInfo[vehicleid][eVehicleLockLevel] = cache_get_field_content_int(i, "VehicleLockLevel", ourConnection);
			VehicleInfo[vehicleid][eVehicleImmobLevel] = cache_get_field_content_int(i, "VehicleImmobLevel", ourConnection);
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				VehicleInfo[vehicleid][eVehicleWeapons][j] = cache_get_field_content_int(i, str, ourConnection);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j] = cache_get_field_content_int(i, str, ourConnection);
			}
			
			for(new d = 1; d < 5; d++)
			{
				format(str, sizeof(str), "VehicleLastDrivers%d", d);
				VehicleInfo[vehicleid][eVehicleLastDrivers][d] = cache_get_field_content_int(i, str, ourConnection);
				
				format(str, sizeof(str), "VehicleLastPassengers%d", d);
				VehicleInfo[vehicleid][eVehicleLastPassengers][d] = cache_get_field_content_int(i, str, ourConnection);
			}
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			endCount++;
		}
	}
	printf("[SERVER]: %d vehicles were loaded from \"%s\" database...", endCount, SQL_DATABASE);
	return 1;
}

function:Query_LoadXMRCategories()
{
	if(!cache_num_rows())
		return  printf("[SERVER]: No XMR categories were loaded from \"%s\" database...", SQL_DATABASE); 
	
	new rows, fields; cache_get_data(rows, fields, ourConnection); 
	
	for(new i = 0; i < rows && i < MAX_XMR_CATEGORY; i++)
	{
		XMRCategoryInfo[i+1][eXMRID] = cache_get_field_content_int(i, "XMRDBID", ourConnection); 
		cache_get_field_content(i, "XMRCategoryName", XMRCategoryInfo[i+1][eXMRCategoryName], ourConnection, 90); 
	}
	
	printf("[SERVER]: %i XMR categories were loaded from \"%s\" database...", rows, SQL_DATABASE); 
	return 1;
}

function:Query_LoadXMRStations()
{
	if(!cache_num_rows())
		return  printf("[SERVER]: No XMR stations were loaded from \"%s\" database...", SQL_DATABASE); 
	
	new rows, fields; cache_get_data(rows, fields, ourConnection); 
	
	for(new i = 0; i < rows && i < MAX_XMR_CATEGORY_STATIONS; i++)
	{
		XMRStationInfo[i+1][eXMRStationID] = cache_get_field_content_int(i, "XMRStationDBID", ourConnection);
		XMRStationInfo[i+1][eXMRCategory] = cache_get_field_content_int(i, "XMRCategory", ourConnection);
		
		cache_get_field_content(i, "XMRStationName", XMRStationInfo[i+1][eXMRStationName], ourConnection, 90);
		cache_get_field_content(i, "XMRStationURL", XMRStationInfo[i+1][eXMRStationURL], ourConnection, 128);
	}
	
	printf("[SERVER]: %i XMR stations were loaded from \"%s\" database...", rows, SQL_DATABASE); 
	return 1;
}

function:Query_LoadBusinesses()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No businesses were loaded from \"%s\" database...", SQL_DATABASE); 
		
	new rows, fields; cache_get_data(rows, fields, ourConnection);
	
	for(new i = 0; i < rows && i < MAX_BUSINESS; i++)
	{
		BusinessInfo[i+1][eBusinessDBID] = cache_get_field_content_int(i, "BusinessDBID", ourConnection);
		BusinessInfo[i+1][eBusinessOwnerDBID] = cache_get_field_content_int(i, "BusinessOwnerDBID", ourConnection); 
		
		BusinessInfo[i+1][eBusinessInterior][0] = cache_get_field_content_float(i, "BusinessInteriorX", ourConnection);
		BusinessInfo[i+1][eBusinessInterior][1] = cache_get_field_content_float(i, "BusinessInteriorY", ourConnection);
		BusinessInfo[i+1][eBusinessInterior][2] = cache_get_field_content_float(i, "BusinessInteriorZ", ourConnection);
		
		BusinessInfo[i+1][eBusinessInteriorWorld] = cache_get_field_content_int(i, "BusinessInteriorWorld", ourConnection);
		BusinessInfo[i+1][eBusinessInteriorIntID] = cache_get_field_content_int(i, "BusinessInteriorIntID", ourConnection);
		
		BusinessInfo[i+1][eBusinessEntrance][0] = cache_get_field_content_float(i, "BusinessEntranceX", ourConnection);
		BusinessInfo[i+1][eBusinessEntrance][1] = cache_get_field_content_float(i, "BusinessEntranceY", ourConnection);
		BusinessInfo[i+1][eBusinessEntrance][2] = cache_get_field_content_float(i, "BusinessEntranceZ", ourConnection);
		
		cache_get_field_content(i, "BusinessName", BusinessInfo[i+1][eBusinessName], ourConnection, 90); 
		BusinessInfo[i+1][eBusinessType] = cache_get_field_content_int(i, "BusinessType", ourConnection);
		
		BusinessInfo[i+1][eBusinessLocked] = bool:cache_get_field_content_int(i, "BusinessLocked", ourConnection); 
		BusinessInfo[i+1][eBusinessEntranceFee] = cache_get_field_content_int(i, "BusinessEntranceFee", ourConnection); 
		
		BusinessInfo[i+1][eBusinessLevel] = cache_get_field_content_int(i, "BusinessLevel", ourConnection); 
		BusinessInfo[i+1][eBusinessMarketPrice] = cache_get_field_content_int(i, "BusinessMarketPrice", ourConnection);
		
		BusinessInfo[i+1][eBusinessCashbox] = cache_get_field_content_int(i, "BusinessCashbox", ourConnection);
		BusinessInfo[i+1][eBusinessProducts] = cache_get_field_content_int(i, "BusinessProducts", ourConnection);
		
		BusinessInfo[i+1][eBusinessBankPickupLoc][0] = cache_get_field_content_float(i, "BusinessBankPickupLocX", ourConnection);
		BusinessInfo[i+1][eBusinessBankPickupLoc][1] = cache_get_field_content_float(i, "BusinessBankPickupLocY", ourConnection);
		BusinessInfo[i+1][eBusinessBankPickupLoc][2] = cache_get_field_content_float(i, "BusinessBankPickupLocZ", ourConnection);
		
		BusinessInfo[i+1][eBusinessBankPickupWorld] = cache_get_field_content_int(i, "BusinessBankPickupWorld", ourConnection); 
		
		if(BusinessInfo[i+1][eBusinessType] == BUSINESS_TYPE_RESTAURANT)
		{
			if(!BusinessInfo[i+1][eBusinessOwnerDBID])
				BusinessInfo[i+1][eBusinessPickup] = CreateDynamicPickup(1272, 14, BusinessInfo[i+1][eBusinessEntrance][0], BusinessInfo[i+1][eBusinessEntrance][1], BusinessInfo[i+1][eBusinessEntrance][2], 0);
					
			else BusinessInfo[i+1][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[i+1][eBusinessEntrance][0], BusinessInfo[i+1][eBusinessEntrance][1], BusinessInfo[i+1][eBusinessEntrance][2], 0);
		}
		else BusinessInfo[i+1][eBusinessPickup] = CreateDynamicPickup(1239, 14, BusinessInfo[i+1][eBusinessEntrance][0], BusinessInfo[i+1][eBusinessEntrance][1], BusinessInfo[i+1][eBusinessEntrance][2], 0);
		
		if(BusinessInfo[i+1][eBusinessType] == BUSINESS_TYPE_BANK)
		{
			BusinessInfo[i+1][eBusinessBankPickup] = CreateDynamicPickup(1274, 2, BusinessInfo[i+1][eBusinessBankPickupLoc][0], BusinessInfo[i+1][eBusinessBankPickupLoc][1], BusinessInfo[i+1][eBusinessBankPickupLoc][2], BusinessInfo[i+1][eBusinessBankPickupWorld]);
		}
	}
	
	printf("[SERVER]: %i businesses were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return 1;
}

function:Query_AddPlayerVehicle(playerid, playerb)
{
	PlayerInfo[playerb][pOwnedVehicles][playerInsertID[playerb]] = cache_insert_id(); 
	
	SendServerMessage(playerb, "You received a vehicle from %s in slot %i.", ReturnName(playerid), playerInsertID[playerb]);
	SendServerMessage(playerid, "You issued %s a new vehicle.", ReturnName(playerb));
	
	playerInsertID[playerb] = 0;
	SaveCharacter(playerb);
	return 1;
}

function:GivePlayerGun(playerid, weaponid, ammo)
{
	new idx = ReturnWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerid][pWeapons][idx])
	{
		RemovePlayerWeapon(playerid, PlayerInfo[playerid][pWeapons][idx]);
		printf("A weapon was removed. Slot: %i, Weapon: %i", idx, PlayerInfo[playerid][pWeapons][idx]);
	}
	
	GivePlayerWeapon(playerid, weaponid, ammo); 
	
	PlayerInfo[playerid][pWeapons][idx] = weaponid;
	PlayerInfo[playerid][pWeaponsAmmo][idx] = ammo;
	
	PlayerInfo[playerid][pWeaponsImmune] = gettime();
	
	printf("Weapon given: IDX: %i, Weapon ID: %i", idx, PlayerInfo[playerid][pWeapons][idx]); 
	return 1;
}

function:ReturnPlayerGuns(playerid)
{
	for(new i = 0; i < 4; i++) if(PlayerInfo[playerid][pWeaponsAmmo][i])
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapons][i], PlayerInfo[playerid][pWeaponsAmmo][i]); 
	
	return 1; 
}

function:TakePlayerGuns(playerid)
{
	for(new i = 0; i < 4; i++) if(PlayerInfo[playerid][pWeaponsAmmo][i])
		PlayerInfo[playerid][pWeapons][i] = 0;  
		
	ResetPlayerWeapons(playerid); 
	return 1;
}

function:OnPlayerUnscramble(playerid)
{	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		KillTimer(PlayerInfo[playerid][pUnscrambleTimer]); 
		
		ShowUnscrambleTextdraw(playerid, false);
		return 1;
	}
	
	PlayerInfo[playerid][pUnscramblerTime]--;
	
	new timerString[20];
	
	format(timerString, 20, "%d", PlayerInfo[playerid][pUnscramblerTime]);
	PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], timerString);
	
	if(PlayerInfo[playerid][pUnscramblerTime] < 1)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		KillTimer(PlayerInfo[playerid][pUnscrambleTimer]); 
		
		ShowUnscrambleTextdraw(playerid, false);
		
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
			
		ToggleVehicleAlarms(vehicleid, true);
		NotifyVehicleOwner(vehicleid);
		
		ClearAnimations(playerid);
	}
	return 1;
}

function:OnVehicleAlarm(vehicleid)
{
	return ToggleVehicleAlarms(vehicleid, false);
}

function:OnPlayerLeaveWeapon(index)
{
	WeaponDropInfo[index][eWeaponDropped] = false;
	WeaponDropInfo[index][eWeaponDroppedBy] = 0;
	
	WeaponDropInfo[index][eWeaponWepAmmo] = 0;
	WeaponDropInfo[index][eWeaponWepID] = 0;
	
	for(new i = 0; i < 3; i++)
	{
		WeaponDropInfo[index][eWeaponPos][i] = 0.0;
	}
	
	if(IsValidDynamicObject(WeaponDropInfo[index][eWeaponObject]))
	{
		DestroyDynamicObject(WeaponDropInfo[index][eWeaponObject]);
	}
	
	return 1;
}

function:OnPropertyCreate(playerid, type)
{
	new
		idx,
		str[128]
	;
	
	for(new i = 1; i < MAX_PROPERTY; i++)
	{
		if(!PropertyInfo[i][ePropertyDBID])
			continue;
			
		idx = i; 
		break;
	}
	
	PropertyInfo[idx][ePropertyDBID] = cache_insert_id(); 
	PropertyInfo[idx][ePropertyType] = type; 
	
	format(str, sizeof(str), "%s created Property ID %i.", ReturnName(playerid), cache_insert_id());
	SendAdminMessage(4, str);
	
	SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} Use \"/editproperty\" to continue the next part.");
	return 1;
}

function:OnEntranceChange(playerid, response, property)
{
	if(response)
	{
		GetPlayerPos(playerid, PropertyInfo[property][ePropertyEntrance][0], PropertyInfo[property][ePropertyEntrance][1], PropertyInfo[property][ePropertyEntrance][2]);
		
		PropertyInfo[property][ePropertyEntranceInterior] = GetPlayerInterior(playerid);
		PropertyInfo[property][ePropertyEntranceWorld] = GetPlayerVirtualWorld(playerid);
		
		SaveProperty(property);
		SendServerMessage(playerid, "You set Property %i's entrance.", property);
	}
	return 1;
}

function:OnInteriorChange(playerid, response, property)
{
	if(response)
	{
		GetPlayerPos(playerid, PropertyInfo[property][ePropertyInterior][0], PropertyInfo[property][ePropertyInterior][1], PropertyInfo[property][ePropertyInterior][2]);
		
		new
			world = random(40000)+playerid+2;
		
		PropertyInfo[property][ePropertyInteriorIntID] = GetPlayerInterior(playerid);
		PropertyInfo[property][ePropertyInteriorWorld] = world;
		
		foreach(new i : Player) if(IsPlayerInProperty(i) == property)
		{
			SetPlayerPos(i, PropertyInfo[property][ePropertyInterior][0], PropertyInfo[property][ePropertyInterior][1], PropertyInfo[property][ePropertyInterior][2]);
			SetPlayerInterior(i, GetPlayerInterior(playerid)); SetPlayerVirtualWorld(i, world); 
			
			SendServerMessage(i, "The property you were in was amended."); 
		}
		
		SaveProperty(property);
		SendServerMessage(playerid, "You set Property %i's interior.", property);
	}
	return 1;
}

function:OnPlayerEnterProperty(playerid, id)
{
	SetPlayerPos(playerid, PropertyInfo[id][ePropertyInterior][0], PropertyInfo[id][ePropertyInterior][1], PropertyInfo[id][ePropertyInterior][2]);
	return TogglePlayerControllable(playerid, 1);
}

function:Query_ShowVehicleList(playerid, idx)
{
	new rows, fields; cache_get_data(rows, fields, ourConnection);
	
	new 
		vehicleDBID,
		vehicleModel,
		vehicleLockLevel,
		vehicleAlarmLevel,
		vehicleImmobLevel,
		vehicleTimesDestroyed,
		vehiclePlates[32],
		bool:isSpawned = false,
		color
	;
	
	for(new i = 0; i < rows; i++)
	{
		vehicleDBID = cache_get_field_content_int(0, "VehicleDBID", ourConnection);
		vehicleModel = cache_get_field_content_int(0, "VehicleModel", ourConnection);
		
		vehicleLockLevel = cache_get_field_content_int(0, "VehicleLockLevel", ourConnection);
		vehicleAlarmLevel = cache_get_field_content_int(0, "VehicleAlarmLevel", ourConnection);
		vehicleImmobLevel = cache_get_field_content_int(0, "VehicleImmobLevel", ourConnection); 
		
		vehicleTimesDestroyed = cache_get_field_content_int(0, "VehicleTimesDestroyed", ourConnection);
		
		cache_get_field_content(0, "VehiclePlates", vehiclePlates, ourConnection, 32); 
	}
	
	for(new id = 0; id < MAX_VEHICLES; id++)
	{
		if(VehicleInfo[id][eVehicleDBID] == vehicleDBID)
		{
			isSpawned = true;
		}
	}
	
	if(isSpawned)
		color = COLOR_DARKGREEN;
	
	else color = COLOR_WHITE;
	
	SendClientMessageEx(playerid, color, "Vehicle %i: %s, Lock[%i], Alarm[%i], Immobiliser[%i], Times destroyed[%i], Plates[%s]", idx, ReturnVehicleModelName(vehicleModel), vehicleLockLevel, vehicleAlarmLevel, vehicleImmobLevel, vehicleTimesDestroyed, vehiclePlates);
	return 1;
}

function:OnOfflineAjail(playerid, jailing[], reason[], length)
{
	SendServerMessage(playerid, "%s was successfully admin jailed.", jailing); 
	
	new
		logQuery[256]
	;
	
	mysql_format(ourConnection, logQuery, sizeof(logQuery), "INSERT INTO ajail_logs (JailedDBID, JailedName, Reason, Date, JailedBy) VALUES(%i, '%e', '%e', '%e', '%e')", ReturnDBIDFromName(jailing), jailing, reason, ReturnDate(), ReturnName(playerid));
	mysql_tquery(ourConnection, logQuery); 
	return 1;
}

function:OnOfflineBan(playerid, banning[], dbid, masterdbid, reason[], date[])
{
	SendServerMessage(playerid, "%s was successfully banned.", banning);
	
	new
		logQuery[256]
	;
	
	mysql_format(ourConnection, logQuery, sizeof(logQuery), "INSERT INTO ban_logs (CharacterDBID, MasterDBID, CharacterName, Reason, BannedBy, Date) VALUES(%i, %i, '%e', '%e', '%e', '%e')",
		dbid, masterdbid, banning, reason, date);
		
	mysql_tquery(ourConnection, logQuery);
	return 1;
}

function:OnXMRCategory(playerid, newid, cat[])
{
	XMRCategoryInfo[newid][eXMRID] = cache_insert_id(); 
	format(XMRCategoryInfo[newid][eXMRCategoryName], 90, "%s", cat);
	
	SendServerMessage(playerid, "You made a new XMR category. \"%s\" (ID: %i)", cat, newid); 
	return 1;
}

function:OnXMRStation(playerid, category, newid, url[], name[])
{
	XMRStationInfo[newid][eXMRStationID] = cache_insert_id(); 
	
	format(XMRStationInfo[newid][eXMRStationName], 90, "%s", name);
	format(XMRStationInfo[newid][eXMRStationURL], 128, "%s", url); 
	
	SendServerMessage(playerid, "You made a new XMR station. \"%s\" (ID: %i)", name, newid);
	SendClientMessageEx(playerid, COLOR_WHITE, "Category: %s (%i). URL: %s", XMRCategoryInfo[category][eXMRCategoryName], category, url);
	return 1;
}

function:Float:GetVehicleTopSpeed(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
 
    if (model)
    {
        return float(s_TopSpeed[(model - 400)]);
    }
    return 0.0;
}

function:SetPlayersSpawn(playerid)
{
	switch(PlayerInfo[playerid][pSpawnPoint])
	{
		case SPAWN_POINT_AIRPORT:
		{
			SetPlayerPos(playerid, 1642.02, -2334.05, 13.5469); 
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
		case SPAWN_POINT_PROPERTY:
		{
			new
				id;
				
			id = PlayerInfo[playerid][pSpawnPointHouse]; 
			
			if(!PropertyInfo[id][ePropertyDBID] || PropertyInfo[id][ePropertyOwnerDBID] != PlayerInfo[playerid][pDBID])
			{
				PlayerInfo[playerid][pSpawnPoint] = SPAWN_POINT_AIRPORT; 
				PlayerInfo[playerid][pSpawnPointHouse] = 0;
				
				return SetPlayersSpawn(playerid); 
			}
			
			SetPlayerPos(playerid, PropertyInfo[id][ePropertyInterior][0], PropertyInfo[id][ePropertyInterior][1], PropertyInfo[id][ePropertyInterior][2]);
			
			SetPlayerInterior(playerid, PropertyInfo[id][ePropertyInteriorIntID]);
			SetPlayerVirtualWorld(playerid, PropertyInfo[id][ePropertyInteriorWorld]); 
			
			PlayerInfo[playerid][pInsideProperty] = id;
		}
		case SPAWN_POINT_FACTION:
		{
			if(!PlayerInfo[playerid][pFaction])
			{
				PlayerInfo[playerid][pSpawnPoint] = SPAWN_POINT_AIRPORT;
				return SetPlayersSpawn(playerid); 
			}
			
			new 
				idx 
			; 
			
			idx = PlayerInfo[playerid][pFaction];
			
			if(!FactionInfo[idx][eFactionDBID])
			{
				PlayerInfo[playerid][pSpawnPoint] = SPAWN_POINT_AIRPORT;
				return SetPlayersSpawn(playerid); 
			}
			
			SetPlayerPos(playerid, FactionInfo[idx][eFactionSpawn][0], FactionInfo[idx][eFactionSpawn][1], FactionInfo[idx][eFactionSpawn][2]);
			
			SetPlayerInterior(playerid, FactionInfo[idx][eFactionSpawnInt]);
			SetPlayerVirtualWorld(playerid, FactionInfo[idx][eFactionSpawnWorld]); 
		}
	}
	return 1;
}

function:OnTaserShoot(playerid)
{
	return SetPlayerArmedWeapon(playerid, WEAPON_SILENCED); 
}

function:OnPlayerTasered(playerid)
{
	SetPlayerDrunkLevel(playerid, 1000);
	TogglePlayerControllable(playerid, 1);
	
	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
	return 1; 
}

function:OnPhoneCall(playerid, type)
{
	switch(type)
	{
		case 1:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] The number you dialed is out of service."); 
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 2:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] The number you dialed cannot be reached at this time.");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 3:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] You received a busy tone.");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 4:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] You received a busy tone.");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
	}
	return 1;
}

function:On911Call(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "[ ! ] They picked up. You can talk now by using the chat box.");
	Player911Timer[1][playerid] = SetTimerEx("On911Pickup", 1500, false, "i", playerid);
	return 1;
}

function:On911Pickup(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOWEX, "911 Operator says: 911, what service do you require?"); 
	
	PlayerInfo[playerid][pPhoneline] = 911;
	PlayerInfo[playerid][pCalling] = 0; 
	return 1; 
}

function:OnSuccessCall(playerid)
{
	if(playerid != INVALID_PLAYER_ID){
		PlayNearbySound(playerid, 23000);
		return 1;
	}
	
	return 0;
}

function:OnPhoneSMS(playerid, type, playerb, text[])
{
	switch(type)
	{
		case 1:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] Your text failed to deliver."); 
			playerText[playerid] = 0; 
			return 1; 
		}
		case 2:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] Your text failed to deliver."); 
			playerText[playerid] = 0; 
			return 1;
		}
		case 3:
		{
			if(!IsPlayerConnected(playerb)) //Possible they disconnect while timer plays;
			{
				SendClientMessage(playerid, COLOR_GREY, "[ ! ] Your text failed to deliver."); 
				playerText[playerid] = 0; 
				return 1;
			}
			
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] Your text message delivered."); 
			
			if(strlen(text) > 80)
			{
				SendClientMessageEx(playerb, COLOR_YELLOWEX, "SMS: %.80s ...", text, PlayerInfo[playerid][pPhone]); 
				SendClientMessageEx(playerb, COLOR_YELLOWEX, "SMS: ...%s, Sender: %i", text[80], PlayerInfo[playerid][pPhone]); 
				printf("Call ;");
			}
			else SendClientMessageEx(playerb, COLOR_YELLOWEX, "SMS: %s, Sender: %i", text, PlayerInfo[playerid][pPhone]);
			
			playerText[playerid] = 0;
			return 1;
		}
	}
	printf("[OnPhoneSMS] Call 4");
	return 1;
}

function:Float:GetDistanceBetweenPoints(Float:rx1,Float:ry1,Float:rz1,Float:rx2,Float:ry2,Float:rz2)
{
	return floatadd(floatadd(floatsqroot(floatpower(floatsub(rx1,rx2),2)),floatsqroot(floatpower(floatsub(ry1,ry2),2))),floatsqroot(floatpower(floatsub(rz1,rz2),2)));
}

function:OnAjailRecord(playerid)
{
	if(!cache_num_rows())
		return SendClientMessage(playerid, COLOR_RED, "[ ! ] {FFFFFF}This player hasn't been admin jailed.");
	
	new rows, fields;
	cache_get_data(rows, fields, ourConnection); 
	
	new
		JailedName[32], 
		Reason[128],
		Date[90],
		JailedBy[32],
		Time
	;
	
	for(new i = 0; i < rows; i++)
	{
		cache_get_field_content(i, "JailedName", JailedName, ourConnection, 32); 
		cache_get_field_content(i, "Reason", Reason, ourConnection, 128);
		
		cache_get_field_content(i, "Date", Date, ourConnection, 90);
		cache_get_field_content(i, "JailedBy", JailedBy, ourConnection, 32); 
		
		Time = cache_get_field_content_int(i, "Time", ourConnection); 
		
		SendClientMessageEx(playerid, COLOR_ACTION, "[%s] %s was admin jailed by %s for %d minutes, Reason: %s", Date, JailedName, JailedBy, Time, Reason);
	}
		
	return 1;
}

//Stock functions:
stock PreloadAnimations(playerid)
{
	for (new i = 0; i < sizeof(g_aPreloadLibs); i ++) {
	    ApplyAnimation(playerid, g_aPreloadLibs[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
	}
	return 1;
} // Credits to Emmet, South Central Roleplay

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[156]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 156
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
} // Credits to Emmet, South Central Roleplay

stock SendClientMessageToAllEx(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) {
			SendClientMessage(i, color, string);
		}
		return 1;
	}
	return SendClientMessageToAll(color, str);
} // Credits to Emmet, South Central Roleplay

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius)) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
} // Credits to Emmet, South Central Roleplay

stock SendAdminMessage(level, const str[])
{
	new 
		newString[128]
	;
	
	format(newString, sizeof(newString), "AdmWarn(%i): %s", level, str);
	
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pAdmin] >= level)
		{
			SendClientMessage(i, COLOR_YELLOWEX, newString);
		}
	}
	return 1;
}

stock SendAdminMessageEx(color, level, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerInfo[i][pAdmin] >= level) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
} // Credits to Emmet, South Central Roleplay

stock SendFactionMessage(playerid, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
				if(PlayerInfo[i][pFactionChat] == false)
  				{ 
					SendClientMessage(i, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor], string);
				}
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
			if(PlayerInfo[i][pFactionChat] == false)
  			{ 
				SendClientMessage(i, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor], str);
			}
		}
	}
	return 1;
} // Credits to Emmet, South Central Roleplay

stock SendFactionMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
} // Credits to Emmet, South Central Roleplay

stock SendPoliceMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (FactionInfo[PlayerInfo[i][pFaction]][eFactionType] == FACTION_TYPE_POLICE) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (FactionInfo[PlayerInfo[i][pFaction]][eFactionType] == FACTION_TYPE_POLICE) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
} // Credits to Emmet, South Central Roleplay
	
stock SendUnauthMessage(playerid)
{
	return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} You aren't authorized to use this.");
}

stock SendTeleportMessage(playerid)
{
	return SendClientMessage(playerid, COLOR_GREY, "You were teleported."); 
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock IsValidRoleplayName(const name[]) {
	if (!name[0] || strfind(name, "_") == -1)
	    return 0;

	else for (new i = 0, len = strlen(name); i != len; i ++) {
	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return 0;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return 0;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return 0;
	}
	return 1;
}

stock ReturnName(playerid, underScore = 1)
{
	new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName)); 
	
	if(!underScore)
	{
		if(PlayerInfo[playerid][pMasked])
			format(playersName, sizeof(playersName), "[Mask %i_%i]", PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1]); 
			
		else
		{
			for(new i = 0, j = strlen(playersName); i < j; i ++) 
			{ 
				if(playersName[i] == '_') 
				{ 
					playersName[i] = ' '; 
				} 
			} 
		}
	}
	
	return playersName;
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

stock ClearLines(playerid, lines)
{
	if (lines > 20 || lines < 1)
		return 0;
		
	for (new i = 0; i < lines; i++)
	{
		SendClientMessage(playerid, -1, " ");
	}
	return 1;
}

stock strreplace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
	{
        if(string[i] == find)
		{
            string[i] = replace;
        }
    }
}

stock ReturnDate()
{
	new sendString[90], MonthStr[40], month, day, year;
	new hour, minute, second;
	
	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}
	
	format(sendString, 90, "%s %d, %d %02d:%02d:%02d", MonthStr, day, year, hour, minute, second);
	return sendString;
}

stock ShowCharacterStats(playerid, playerb)
{
	// playerid = player's statistics;
	// playerb = player receiving stats;
	
	new 
		vehicle_key[20],
		duplicate_key[20],
		business_key[20] = "None"
	;
	
	if(!PlayerInfo[playerid][pVehicleSpawned])
		vehicle_key = "None";
	else format(vehicle_key, 32, "%d", PlayerInfo[playerid][pVehicleSpawnedID]);
	
	if(PlayerInfo[playerid][pDuplicateKey] == INVALID_VEHICLE_ID)
		duplicate_key = "None";
	else format(duplicate_key, 32, "%d", PlayerInfo[playerid][pDuplicateKey]); 
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][eBusinessDBID])
			continue;
			
		if(BusinessInfo[i][eBusinessOwnerDBID] == PlayerInfo[playerid][pDBID])
			format(business_key, 20, "%d", BusinessInfo[i][eBusinessDBID]); 
	}
	
	SendClientMessageEx(playerb, COLOR_DARKGREEN, "|__________________%s [%s]__________________|", ReturnName(playerid), ReturnDate());

	SendClientMessageEx(playerb, COLOR_GRAD2, "CHARACTER: Faction:[%s] Rank:[%s]", ReturnFactionName(playerid), ReturnFactionRank(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD1, "EXPERIENCE: Level:[%d] Experience:[%d/%d] Time played:[%d hours]", PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEXP], ((PlayerInfo[playerid][pLevel]) * 4 + 2), PlayerInfo[playerid][pTimeplayed]);
	SendClientMessageEx(playerb, COLOR_GRAD2, "WEAPONS: Primary weapon:[%s] Ammo:[%d] Secondary weapon:[%s] Ammo:[%d]", ShowPlayerWeapons(playerid, 4), PlayerInfo[playerid][pWeaponsAmmo][3], ShowPlayerWeapons(playerid, 3), PlayerInfo[playerid][pWeaponsAmmo][2]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "INVENTORY: Phone:[%d] Radio:[%s] Channel:[%d] Mask:[%s] Melee:[%s]", PlayerInfo[playerid][pPhone], (PlayerInfo[playerid][pHasRadio] != true) ? ("No") : ("Yes"), PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]], (PlayerInfo[playerid][pHasMask] != true) ? ("No") : ("Yes"), ShowPlayerWeapons(playerid, 1));
	SendClientMessageEx(playerb, COLOR_GRAD2, "MONEY: Cash:[$%s] Bank:[$%s] Paycheck:[$%s]", MoneyFormat(PlayerInfo[playerid][pMoney]), MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]));
	SendClientMessageEx(playerb, COLOR_GRAD1, "OTHER: VehicleKey:[%s] DuplicateKey:[%s] BusinessKey:[%s]", vehicle_key, duplicate_key, business_key);	
	
	if(PlayerInfo[playerb][pAdmin])
	{
		SendClientMessageEx(playerb, COLOR_GRAD1, "FOR ADMIN: DBID:[%d] Master:[%s (%d)] Interior:[%d] Local:[%d]", PlayerInfo[playerid][pDBID], e_pAccountData[playerid][mAccName], e_pAccountData[playerid][mDBID], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		
		SendClientMessageEx(playerb, COLOR_GRAD2, "CONNECTION: IP:[%s] Last Online:[%s] Duration:[%d Minutes]", ReturnIP(playerid), ReturnLastOnline(playerid), PlayerInfo[playerid][pLastOnlineTime]);
		
		SendClientMessageEx(playerb, COLOR_GRAD1, "MISC: InsideProperty:[%i] InsideBusiness:[%i]", IsPlayerInProperty(playerid), IsPlayerInBusiness(playerid)); 
	}
	
	SendClientMessageEx(playerb, COLOR_DARKGREEN, "|__________________%s [%s]__________________|", ReturnName(playerid), ReturnDate());
	
	return 1;
}

stock ReturnIP(playerid)
{
	new
		ipAddress[20];

	GetPlayerIp(playerid, ipAddress, sizeof(ipAddress));
	return ipAddress; 
}

stock ReturnGPCI(playerid)
{
	new szSerial[41]; // 40 + \0
 
	gpci(playerid, szSerial, sizeof(szSerial));
	return szSerial;
}

stock ReturnLastOnline(playerid)
{
	new returnString[90]; 
	
	if(isnull(PlayerInfo[playerid][pLastOnline]))
		returnString = "Never";
	
	else
		format(returnString, 90, "%s", PlayerInfo[playerid][pLastOnline]);
	
	return returnString;
}

stock ConfirmDialog(playerid, caption[], info[], callback[], {Float,_}:...)
{
	new n = numargs(), 		// number of arguments, static + optional
		szParamHash[256];	// variable where the passed arguments will be stored
	for(new arg = 4; arg < n; arg++){	// loop all additional arguments
		format(szParamHash, sizeof(szParamHash), "%s%d|", szParamHash, getarg(arg)); // store them in szParamHash
	}
	SetPVarInt(playerid, "confDialogArgs", n -4);			// store the amount of additional arguments
	SetPVarString(playerid, "confDialCallback", callback);	// store the callback that needs to be called after response
	SetPVarString(playerid, "confDialog_arg", szParamHash);	// store the additional arguments
	
	ShowPlayerDialog(playerid, DIALOG_CONFIRM_SYS, DIALOG_STYLE_MSGBOX, caption, info, "Yes", "No"); // display the dialog message itself
	
	return;
} // Credits to Mmartin (SA-MP forums)

stock ConfirmDialog_Response(playerid, response)
{
	new szCallback[33],		// variable to fetch our callback to
		szParamHash[64], 	// variable to check raw compressed argument string
		n,					// variable to fetch the amount of additional arguments
		szForm[12];			// variable to generate the CallLocalFunction() "format" argument
		
	n = GetPVarInt(playerid, "confDialogArgs");	// Fetch the amount of additional arguments
	GetPVarString(playerid, "confDialCallback", szCallback, sizeof(szCallback));	// fetch the callback
	GetPVarString(playerid, "confDialog_arg", szParamHash, sizeof(szParamHash));	// fetch the raw compressed additional arguments
	
	new hashDecoded[12];	// variable to store extracted additional arguments from the ConfirmDialog() generated string
	
	sscanf(szParamHash, "p<|>A<d>(0)[12]", hashDecoded);	// extraction of the additional arguments
	
	new args, 	// amount of cells passed to CallLocalFunction
		addr, 	// pointer address variable for later use
		i;		// i
		
	format(szForm, sizeof(szForm), "dd");	// static parameters for the callback, "playerid" and "response"
	
	#emit ADDR.pri hashDecoded	// get pointer address of the extracted additional arguments
	#emit STOR.S.pri addr		// store the pointer address in variable 'addr'
	if(n){	// if there's any additional arguments
		for(i = addr + ((n-1) * 4); i >= addr; i-=4){ // loops all additional arguments by their addresses
			format(szForm, sizeof(szForm), "%sd", szForm); // adds an aditional specifier to the "format" parameter of CallLocalFunction
			#emit load.s.pri i	// load the argument at the current address
			#emit push.pri		// push it to the CallLocalFunction argument list
			args+=4;			// increase used cell number by 4
		}
	}
	
	
	args+=16;	// preserve 4 more arguments for CallLocalFunction (16 cause 4 args by 4 cells (4*4))
	
	#emit ADDR.pri response				// fetch "response" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list
	
	#emit ADDR.pri playerid				// fetch "playerid" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list
	
	#emit push.adr szForm				// push the szForm ("format") to the argument list by its referenced address
	#emit push.adr szCallback			// push the szCallback (custom callback) to the argument list by its referenced address
	#emit push.s args					// push the amount of arguments
	#emit sysreq.c CallLocalFunction	// call the function
	
	// Clear used data
	#emit LCTRL 4
	#emit LOAD.S.ALT args
	#emit ADD.C 4
	#emit ADD
	#emit SCTRL 4
	
	// Clear used PVars
	DeletePVar(playerid, "confDialCallback");
	DeletePVar(playerid, "confDialog_arg");
	DeletePVar(playerid, "confDialogArgs");
	
	return;
} // Credits to Mmartin (SA-MP forums)

stock PlayNearbySound(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 15.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}

stock SaveFactions()
{
	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(FactionInfo[i][eFactionDBID])
		{
			SaveFaction(i);
		}
	}
	return 1;
}

stock SaveProperties()
{
	for(new i = 1; i < MAX_PROPERTY; i++)
	{
		if(!PropertyInfo[i][ePropertyDBID])
			continue;
			
		SaveProperty(i); 
	}
	return 1;
}

stock SaveBusinesses()
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][eBusinessDBID])
			continue;
			
		SaveBusiness(i);
	}
	return 1;
}

stock SaveFaction(id)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new threadSave[256];
	
	mysql_format(ourConnection, threadSave, sizeof(threadSave), "UPDATE factions SET FactionName = '%e', FactionAbbrev = '%e', FactionJoinRank = %i, FactionAlterRank = %i, FactionChatRank = %i, FactionTowRank = %i, FactionType = %i, FactionChatColor = %i WHERE DBID = %i",
		FactionInfo[id][eFactionName],
		FactionInfo[id][eFactionAbbrev],
		FactionInfo[id][eFactionJoinRank],
		FactionInfo[id][eFactionAlterRank],
		FactionInfo[id][eFactionChatRank],
		FactionInfo[id][eFactionTowRank],
		FactionInfo[id][eFactionType],
		FactionInfo[id][eFactionChatColor],
		FactionInfo[id][eFactionDBID]);
	mysql_tquery(ourConnection, threadSave);
	
	mysql_format(ourConnection, threadSave, sizeof(threadSave), "UPDATE factions SET FactionSpawnX = %f, FactionSpawnY = %f, FactionSpawnZ = %f, FactionInterior = %i, FactionWorld = %i WHERE DBID = %i",
		FactionInfo[id][eFactionSpawn][0],
		FactionInfo[id][eFactionSpawn][1],
		FactionInfo[id][eFactionSpawn][2],
		FactionInfo[id][eFactionSpawnInt],
		FactionInfo[id][eFactionSpawnWorld],
		FactionInfo[id][eFactionDBID]);
	mysql_tquery(ourConnection, threadSave);
	return 1;
}

stock SaveFactionRanks(id)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new threadSave[256];
	
	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		mysql_format(ourConnection, threadSave, sizeof(threadSave), "UPDATE faction_ranks SET FactionRank%i = %i WHERE factionid = %i", i, FactionRanks[id][i], FactionInfo[id][eFactionDBID]); 
		mysql_tquery(ourConnection, threadSave);
	}
	
	return 1;
}

stock SaveVehicle(vehicleid)
{
	new query[256];
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleOwnerDBID = %i, VehicleFaction = %i, VehicleColor1 = %i, VehicleColor2 = %i, VehiclePaintjob = %i, VehiclePlates = '%e', VehicleLocked = %i, VehicleSirens = %i, VehicleFuel = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleOwnerDBID], 
		VehicleInfo[vehicleid][eVehicleFaction],
		VehicleInfo[vehicleid][eVehicleColor1],
		VehicleInfo[vehicleid][eVehicleColor2],
		VehicleInfo[vehicleid][eVehiclePaintjob],
		VehicleInfo[vehicleid][eVehiclePlates],
		VehicleInfo[vehicleid][eVehicleLocked],
		VehicleInfo[vehicleid][eVehicleSirens],
		VehicleInfo[vehicleid][eVehicleFuel],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleXMR = %i, VehicleBattery = %f, VehicleEngine = %f, VehicleTimesDestroyed = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleHasXMR],
		VehicleInfo[vehicleid][eVehicleBattery],
		VehicleInfo[vehicleid][eVehicleEngine],
		VehicleInfo[vehicleid][eVehicleTimesDestroyed],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleParkPosX = %f, VehicleParkPosY = %f, VehicleParkPosZ = %f, VehicleParkPosA = %f, VehicleParkInterior = %i, VehicleParkWorld = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleParkPos][0],
		VehicleInfo[vehicleid][eVehicleParkPos][1], 
		VehicleInfo[vehicleid][eVehicleParkPos][2],
		VehicleInfo[vehicleid][eVehicleParkPos][3],
		VehicleInfo[vehicleid][eVehicleParkInterior],
		VehicleInfo[vehicleid][eVehicleParkWorld],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleImpounded = %i, VehicleImpoundPosX = %f, VehicleImpoundPosY = %f, VehicleImpoundPosZ = %f, VehicleImpoundPosA = %f WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleImpounded],
		VehicleInfo[vehicleid][eVehicleImpoundPos][0],
		VehicleInfo[vehicleid][eVehicleImpoundPos][1],
		VehicleInfo[vehicleid][eVehicleImpoundPos][2],
		VehicleInfo[vehicleid][eVehicleImpoundPos][3],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(ourConnection, query);
	
	for(new i = 1; i < 6; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleWeapons%d = %i, VehicleWeaponsAmmo%d = %i WHERE VehicleDBID = %i",
			i,
			VehicleInfo[vehicleid][eVehicleWeapons][i],
			i,
			VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i],
			VehicleInfo[vehicleid][eVehicleDBID]);
		mysql_tquery(ourConnection, query);
	}
	
	for(new j = 1; j < 5; j++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE vehicles SET VehicleLastDrivers%d = %i, VehicleLastPassengers%d = %i WHERE VehicleDBID = %i",
			j,
			VehicleInfo[vehicleid][eVehicleLastDrivers][j],
			j,
			VehicleInfo[vehicleid][eVehicleLastPassengers][j],
			VehicleInfo[vehicleid][eVehicleDBID]);
		mysql_tquery(ourConnection, query);
			
	}
	return 1;
}

stock SaveProperty(id)
{
	new query[256]; 
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE properties SET PropertyOwnerDBID = %i, PropertyType = %i, PropertyFaction = %i, PropertyLocked = %i, PropertyCashbox = %i, PropertyLevel = %i, PropertyMarketPrice = %i, PropertyHasBoombox = %i WHERE PropertyDBID = %i",
		PropertyInfo[id][ePropertyOwnerDBID], 
		PropertyInfo[id][ePropertyType],
		PropertyInfo[id][ePropertyFaction],
		PropertyInfo[id][ePropertyLocked],
		PropertyInfo[id][ePropertyCashbox],
		PropertyInfo[id][ePropertyLevel],
		PropertyInfo[id][ePropertyMarketPrice],
		PropertyInfo[id][ePropertyHasBoombox],
		PropertyInfo[id][ePropertyDBID]);
	mysql_tquery(ourConnection, query); 
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE properties SET PropertyEntranceX = %f, PropertyEntranceY = %f, PropertyEntranceZ = %f, PropertyEntranceInterior = %i, PropertyEntranceWorld = %i WHERE PropertyDBID = %i",
		PropertyInfo[id][ePropertyEntrance][0],
		PropertyInfo[id][ePropertyEntrance][1],
		PropertyInfo[id][ePropertyEntrance][2],
		PropertyInfo[id][ePropertyEntranceInterior],
		PropertyInfo[id][ePropertyEntranceWorld],
		PropertyInfo[id][ePropertyDBID]);
	mysql_tquery(ourConnection, query);
	 
	mysql_format(ourConnection, query, sizeof(query), "UPDATE properties SET PropertyInteriorX = %f, PropertyInteriorY = %f, PropertyInteriorZ = %f, PropertyInteriorIntID = %i, PropertyInteriorWorld = %i WHERE PropertyDBID = %i",
		PropertyInfo[id][ePropertyInterior][0],
		PropertyInfo[id][ePropertyInterior][1],
		PropertyInfo[id][ePropertyInterior][2],
		PropertyInfo[id][ePropertyInteriorIntID],
		PropertyInfo[id][ePropertyInteriorWorld],
		PropertyInfo[id][ePropertyDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE properties SET PropertyPlacePosX = %f, PropertyPlacePosY = %f, PropertyPlacePosZ = %f WHERE PropertyDBID = %i",
		PropertyInfo[id][ePropertyPlacePos][0],
		PropertyInfo[id][ePropertyPlacePos][1],
		PropertyInfo[id][ePropertyPlacePos][2],
		PropertyInfo[id][ePropertyDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE properties SET PropertyBoomboxPosX = %f, PropertyBoomboxPosY = %f, PropertyBoomboxPosZ = %f, PropertyBoomboxRotX = %f, PropertyBoomboxRotY = %f, PropertyBoomboxRotZ = %f WHERE PropertyDBID = %i",
		PropertyInfo[id][ePropertyBoomboxPos][0],
		PropertyInfo[id][ePropertyBoomboxPos][1],
		PropertyInfo[id][ePropertyBoomboxPos][2],
		PropertyInfo[id][ePropertyBoomboxRot][0],
		PropertyInfo[id][ePropertyBoomboxRot][1],
		PropertyInfo[id][ePropertyBoomboxRot][2],
		PropertyInfo[id][ePropertyDBID]);
	mysql_tquery(ourConnection, query);

	return 1;
}

stock SaveBusiness(id)
{
	new query[400];
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE businesses SET BusinessOwnerDBID = %i, BusinessName = '%e', BusinessType = %i, BusinessLocked = %i, BusinessEntranceFee = %i, BusinessLevel = %i, BusinessCashbox = %i, BusinessProducts = %i, BusinessMarketPrice = %i WHERE BusinessDBID = %i",
		BusinessInfo[id][eBusinessOwnerDBID],
		BusinessInfo[id][eBusinessName],
		BusinessInfo[id][eBusinessType],
		BusinessInfo[id][eBusinessLocked], 
		BusinessInfo[id][eBusinessEntranceFee],
		BusinessInfo[id][eBusinessLevel],
		BusinessInfo[id][eBusinessCashbox],
		BusinessInfo[id][eBusinessProducts],
		BusinessInfo[id][eBusinessMarketPrice],
		BusinessInfo[id][eBusinessDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE businesses SET BusinessInteriorX = %f, BusinessInteriorY = %f, BusinessInteriorZ = %f, BusinessInteriorWorld = %i, BusinessInteriorIntID = %i WHERE BusinessDBID = %i",
		BusinessInfo[id][eBusinessInterior][0],
		BusinessInfo[id][eBusinessInterior][1],
		BusinessInfo[id][eBusinessInterior][2],
		BusinessInfo[id][eBusinessInteriorWorld],
		BusinessInfo[id][eBusinessInteriorIntID],
		BusinessInfo[id][eBusinessDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE businesses SET BusinessEntranceX = %f, BusinessEntranceY = %f, BusinessEntranceZ = %f WHERE BusinessDBID = %i",
		BusinessInfo[id][eBusinessEntrance][0],
		BusinessInfo[id][eBusinessEntrance][1],
		BusinessInfo[id][eBusinessEntrance][2],
		BusinessInfo[id][eBusinessDBID]);
	mysql_tquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE businesses SET BusinessBankPickupLocX = %f, BusinessBankPickupLocY = %f, BusinessBankPickupLocZ = %f, BusinessBankPickupWorld = %i WHERE BusinessDBID = %i",
		BusinessInfo[id][eBusinessBankPickupLoc][0],
		BusinessInfo[id][eBusinessBankPickupLoc][1],
		BusinessInfo[id][eBusinessBankPickupLoc][2],
		BusinessInfo[id][eBusinessBankPickupWorld],
		BusinessInfo[id][eBusinessDBID]);
	mysql_tquery(ourConnection, query);
	
	return 1;
}

stock ReturnTotalMembers(factionid)
{
	if(factionid == 0 || !FactionInfo[factionid][eFactionDBID])
		return 0; 
		
	new threadCheck[128], counter;
	
	mysql_format(ourConnection, threadCheck, sizeof(threadCheck), "SELECT COUNT(*) FROM characters WHERE pFaction = %i", factionid);
	mysql_query(ourConnection, threadCheck); 
	
	counter = cache_get_row_int(0, 0);
	return counter;
}

stock ReturnOnlineMembers(factionid)
{
	new counter;
		
	foreach(new i : Player)
	{
		if(e_pAccountData[i][mLoggedin] == false)
			continue;
		
		if(PlayerInfo[i][pFaction] == factionid)
		{
			counter++;
		}
	}
	return counter;
}

stock ReturnFactionName(playerid)
{
	new factionName[90];
	
	if(!PlayerInfo[playerid][pFaction])
		factionName = "Civilian";
		
	else
		format(factionName, sizeof(factionName), "%s", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionName]);
		
	return factionName;
}

stock ReturnFactionNameEx(factionid)
{
	new factionName[90];
	
	format(factionName, sizeof(factionName), "%s", FactionInfo[factionid][eFactionName]);
	return factionName;
}

stock ReturnFactionAbbrev(factionid)
{		
	 new facAbbrev[90];
	 
	 format(facAbbrev, sizeof(facAbbrev), "%s", FactionInfo[factionid][eFactionAbbrev]);
	 return facAbbrev; 
}

stock ReturnFactionRank(playerid)
{
	new rankStr[90]; 
	
	if(!PlayerInfo[playerid][pFaction])
	{
		rankStr = "No Rank";
	}
	else
	{
		new 
			factionid = PlayerInfo[playerid][pFaction],
			rank = PlayerInfo[playerid][pFactionRank];
			
		format(rankStr, sizeof(rankStr), "%s", FactionRanks[factionid][rank]);
	}
	return rankStr;
}

stock ReturnFactionType(playerid)
{
	if(!PlayerInfo[playerid][pFaction])
		return 0;
	
	return FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType];
}

static stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock ResetVehicleVars(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;
		
	VehicleInfo[vehicleid][eVehicleDBID] = 0; 
	VehicleInfo[vehicleid][eVehicleExists] = false;
	
	VehicleInfo[vehicleid][eVehicleOwnerDBID] = 0;
	VehicleInfo[vehicleid][eVehicleFaction] = 0;
	
	VehicleInfo[vehicleid][eVehicleImpounded] = false;
	VehicleInfo[vehicleid][eVehiclePaintjob] = -1; 
	
	VehicleInfo[vehicleid][eVehicleFuel] = 100; 
	
	for(new i = 1; i < 6; i++)
	{
		VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0;
	}
	
	for(new i = 1; i < 5; i++)
	{
		VehicleInfo[vehicleid][eVehicleLastDrivers][i] = 0;
		VehicleInfo[vehicleid][eVehicleLastPassengers][i] = 0;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount] = 0;
	
	VehicleInfo[vehicleid][eVehicleHasXMR] = false;
	VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
	VehicleInfo[vehicleid][eVehicleEngine] = 100.0;
	VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
	
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	VehicleInfo[vehicleid][eVehicleLights] = false;
	return 1;
}

stock ToggleVehicleAlarms(vehicleid, bool:alarmstate, time = 5000)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
 
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarmstate, doors, bonnet, boot, alarmstate);
	
	if(alarmstate) SetTimerEx("OnVehicleAlarm", time, false, "i", vehicleid);
	return 1;
}

stock ToggleVehicleEngine(vehicleid, bool:enginestate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, enginestate, lights, alarm, doors, bonnet, boot, objective);
	return 1;
}

stock ToggleVehicleLights(vehicleid, bool:lightstate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lightstate, alarm, doors, bonnet, boot, objective);
	
	VehicleInfo[vehicleid][eVehicleLights] = lightstate;
	return 1;
}

stock GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][pMoney] += amount;
	GivePlayerMoney(playerid, amount);
	
	new string[128]; 
	
	if(amount < 0) {
		format(string, sizeof(string), "~r~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
	}
	else{
		format(string, sizeof(string), "~g~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
	}
	return 1;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player){
		if(IsPlayerInVehicle(i, vehicleid))return true; 
	}
	return false;
}

stock PlayerHasWeapons(playerid)
{
	new countWeapons = 0;
	
	for(new i = 0; i < 4; i ++)
	{
		if(PlayerInfo[playerid][pWeapons][i] != 0)
			countWeapons++;
	}
	if(countWeapons == 0)
		return 0;
		
	if(countWeapons > 0)
		return 1;
		
	return 1;
}

stock PlayerHasWeapon(playerid, weaponid)
{
	if(PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] != weaponid)
		return 0;

	return 1;
}

stock ReturnWeaponIDSlot(weaponid)
{
	new returnID; 
	
	switch(weaponid)
	{
		case 1 .. 10: returnID = 0;
		case 11 .. 18, 41, 43: returnID = 1;
		case 22 .. 24: returnID = 2;
		case 25, 27 .. 34: returnID = 3;
	}
	return returnID;
}

stock WeaponDataSlot(weaponid)
{
	new slot;
	
	switch (weaponid)
	{
		case 1: slot = 0;
		case 2 .. 9: slot = 1; 
		case 10 .. 15: slot = 10; 
		case 16 .. 18: slot = 8;
		case 41, 43: slot = 9; 
		case 24: slot = 2;
		case 25: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6; 
	}
	return slot;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;
	new saveweapon[13], saveammo[13];
	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
	ResetPlayerWeapons(playerid);
	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;
		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	GivePlayerWeapon(playerid, 0, 1);
}

stock ReturnWeaponName(weaponid)
{
	new weapon[22];
    switch(weaponid)
    {
        case 0: weapon = "Fists";
        case 18: weapon = "Molotov Cocktail";
        case 44: weapon = "Night Vision Goggles";
        case 45: weapon = "Thermal Goggles";
		case 54: weapon = "Fall";
        default: GetWeaponName(weaponid, weapon, sizeof(weapon));
    }
    return weapon;
}

stock ShowFactionConfig(playerid)
{
	new rankCount, infoString[128], showString[256]; 
	
	format(infoString, sizeof(infoString), "Name: %s\n", ReturnFactionName(playerid));
	strcat(showString, infoString); 
	
	format(infoString, sizeof(infoString), "Abbreviation: %s\n", ReturnFactionAbbrev(PlayerInfo[playerid][pFaction]));
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "Alter Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "Join Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJoinRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "Chat Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "Chat Color\n", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor]);
	strcat(showString, infoString);
	
	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
			continue;
			
		rankCount++;
	}
	
	format(infoString, sizeof(infoString), "Faction Ranks (%i)\n", rankCount);
	strcat(showString, infoString);
	
	strcat(showString, "Faction Spawn\n"); 
	
	format(infoString, sizeof(infoString), "Tow Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank]);
	strcat(showString, infoString);
	
	ShowPlayerDialog(playerid, DIALOG_FACTION_CONFIG, DIALOG_STYLE_LIST, "{ADC3E7}Faction Configuration", showString, "Select", "<<");
	return 1;
}

stock HexToInt(string[])
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

stock ShowUnscrambleTextdraw(playerid, bool:showTextdraw = true)
{
	if(showTextdraw)
	{
		for(new i = 0; i < 7; i++)
		{
			PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][i]);
		}
	}
	else
	{
		for(new i = 0; i < 7; i++)
		{
			PlayerTextDrawHide(playerid, Unscrambler_PTD[playerid][i]);
		}
	}
	return 1;
}

stock ShowPlayerWeapons(playerid, slotid)
{
	new returnStr[60];
	
	switch(slotid)
	{
		case 1:
		{
			new str_1slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][0])
				str_1slot = "None"; 
				
			else
				format(str_1slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][0]));
				
			returnStr = str_1slot;
		}
		case 2:
		{
			new str_2slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][1])
				str_2slot = "None"; 
				
			else
				format(str_2slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][1]));
				
			returnStr = str_2slot;
		}
		case 3:
		{
			new str_3slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][2])
				str_3slot = "None"; 
				
			else
				format(str_3slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][2]));
				
			returnStr = str_3slot;
		}
		case 4:
		{
			new str_4slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][3])
				str_4slot = "None"; 
				
			else
				format(str_4slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][3]));
				
			returnStr = str_4slot;
		}
	}
	return returnStr;
}

stock ReturnDBIDName(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(ourConnection, query, sizeof(query), "SELECT char_name FROM characters WHERE char_dbid = %i", dbid); 
	new Cache:cache = mysql_query(ourConnection, query);
	
	if(!cache_num_rows())
		returnString = "None";
		
	else
		cache_get_field_content(0, "char_name", returnString);
	
	cache_delete(cache);
	return returnString;
}

stock NotifyVehicleOwner(vehicleid)
{
	new playerid = INVALID_PLAYER_ID;

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID])))
		{
			playerid = i;
		}
	}
	if(playerid != INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOR_YELLOWEX, "SMS: Your vehicle alarm has been set off, Sender: Vehicle Alarm (Unknown)");
	}
	else return 1;
	return 1;
}

stock GetNearestVehicle(playerid)
{
 	new
	 	Float:fX,
	 	Float:fY,
	 	Float:fZ,
	 	Float:fSX,
	    Float:fSY,
		Float:fSZ,
		Float:fRadius;

	for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
	{
	    if (!IsVehicleStreamedIn(i, playerid))
		{
			continue;
	    }
	    else
	    {
			GetVehiclePos(i, fX, fY, fZ);

			GetVehicleModelInfo(GetVehicleModel(i), VEHICLE_MODEL_INFO_SIZE, fSX, fSY, fSZ);

			fRadius = floatsqroot((fSX + fSX) + (fSY + fSY));

			if (IsPlayerInRangeOfPoint(playerid, fRadius, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i))
			{
				return i;
			}
		}
	}
	return INVALID_VEHICLE_ID;
}

stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
} 

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
}  

stock ReturnWeaponsModel(weaponid)
{
    new WeaponModels[] =
    {
        0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
        325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
        353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
        367, 368, 368, 371
    };
    return WeaponModels[weaponid];
}

stock IsPlayerInProperty(playerid)
{
	if(PlayerInfo[playerid][pInsideProperty])
	{
		for(new i = 1; i < MAX_PROPERTY; i++)
		{
			if(i == PlayerInfo[playerid][pInsideProperty] && GetPlayerVirtualWorld(playerid) == PropertyInfo[i][ePropertyInteriorWorld])
				return i;
		}
	}
	return 0;
}

stock IsPlayerNearProperty(playerid)
{
	for(new i = 1; i < MAX_PROPERTY; i++)
	{
		if(!PropertyInfo[i][ePropertyDBID])
			continue; 
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyInfo[i][ePropertyEntrance][0], PropertyInfo[i][ePropertyEntrance][1], PropertyInfo[i][ePropertyEntrance][2]) && GetPlayerVirtualWorld(playerid) == PropertyInfo[i][ePropertyEntranceWorld])
			return i;
	} 
	return 0; 
}

stock IsPlayerNearBusiness(playerid)
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][eBusinessDBID])
			continue;
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][eBusinessEntrance][0], BusinessInfo[i][eBusinessEntrance][1], BusinessInfo[i][eBusinessEntrance][2]))
			return i;
	}
	return 0;
}

stock IsPlayerInBusiness(playerid)
{
	if(PlayerInfo[playerid][pInsideBusiness])
	{
		for(new i = 1; i < MAX_BUSINESS; i++)
		{
			if(!BusinessInfo[i][eBusinessDBID])
				continue;
				
			if(i == PlayerInfo[playerid][pInsideBusiness] && GetPlayerVirtualWorld(playerid) == BusinessInfo[i][eBusinessInteriorWorld])
				return i;
		}
	}
	return 0;
}

stock CountPlayerProperties(playerid)
{
	new
		count = 0
	;

	for(new i = 1; i < MAX_PROPERTY; i++)
	{
		if(!PropertyInfo[i][ePropertyDBID])
			continue;
			
		if(PropertyInfo[i][ePropertyOwnerDBID] == PlayerInfo[playerid][pDBID])
			count++; 
	}
	return count; 
}

stock CountPlayerBusiness(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][eBusinessDBID])
			continue;
			
		if(BusinessInfo[i][eBusinessOwnerDBID] == PlayerInfo[playerid][pDBID])
			count++;
	}
	return count;
}

stock CountPlayerVehicles(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < 6; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			count++;
		}
	}
	return count;
}

stock ShowVehicleList(playerid)
{
	new thread[128]; 
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "_________________Your vehicles(%i)_________________", CountPlayerVehicles(playerid));
	
	for(new i = 1; i < 6; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			mysql_format(ourConnection, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]); 
			mysql_tquery(ourConnection, thread, "Query_ShowVehicleList", "ii", playerid, i);
		}
	}

	return 1;
}

stock DoesPlayerExist(name[])
{
	new checkQuery[128];
	
	mysql_format(ourConnection, checkQuery, sizeof(checkQuery), "SELECT char_name FROM characters WHERE char_name = '%e'", name); 
	new Cache:cache = mysql_query(ourConnection, checkQuery); 
	
	if(cache_num_rows())
	{
		cache_delete(cache); 
		return 1; 
	}
	
	cache_delete(cache);
	return 0;	
}

stock ReturnDBIDFromName(name[])
{
	new checkQuery[128], dbid;
	
	mysql_format(ourConnection, checkQuery, sizeof(checkQuery), "SELECT char_dbid FROM characters WHERE char_name = '%e'", name);
	new Cache:cache = mysql_query(ourConnection, checkQuery); 
	
	
	if(!cache_num_rows())
	{
		cache_delete(cache);
		return 0;
	}
	
	dbid = cache_get_field_content_int(0, "char_dbid", ourConnection); 
	cache_delete(cache);
	return dbid; 
}

stock MoneyFormat(integer)
{
	new value[20], string[20];

	valstr(value, integer);

	new charcount;

	for(new i = strlen(value); i >= 0; i --)
	{
		format(string, sizeof(string), "%c%s", value[i], string);
		if(charcount == 3)
		{
			if(i != 0)
				format(string, sizeof(string), ",%s", string);
			charcount = 0;
		}
		charcount ++;
	}

	return string;
}

stock ReturnXMRCategories(playerid)
{
	new 
		liststr[500];
		
	for (new i = 1; i < MAX_XMR_CATEGORY; i++)
	{
		if(XMRCategoryInfo[i][eXMRID])
		{			
			format (liststr, sizeof(liststr), "%s%s\n", liststr, XMRCategoryInfo[i][eXMRCategoryName]);
			ShowPlayerDialog(playerid, DIALOG_XMR_CATEGORIES, DIALOG_STYLE_LIST, "Genres:", liststr, "Select", "Cancel");
		}
	}
		
	return 1;
}

stock PlayXMRStation(playerid, vehicleid = INVALID_VEHICLE_ID, propertyid = 0, bool:disableXMR = false)
{
	new
		string[128]; 
		
	if(disableXMR == true)
	{
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			foreach(new i : Player)
			{
				if(IsPlayerInVehicle(i, vehicleid))
				{
					StopAudioStreamForPlayer(i);
					SendClientMessage(i, COLOR_RED, "Radio has been stopped."); 
				}
			}
			
			VehicleInfo[vehicleid][eVehicleXMROn] = false; 
			format(VehicleInfo[vehicleid][eVehicleXMRURL], 128, " ");
			
			return 1;
		}
		
		if(propertyid != 0)
		{
			foreach(new i : Player)
			{
				if(IsPlayerInProperty(playerid) == propertyid)
				{
					StopAudioStreamForPlayer(i);
					SendClientMessage(i, COLOR_RED, "Radio has been stopped."); 
				}
			}
			
			PropertyInfo[propertyid][ePropertyBoomboxOn] = false;
			format(PropertyInfo[propertyid][ePropertyBoomboxURL], 128, " ");
			
			return 1;
		}
	
		return 1;
	}

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		format(string, sizeof(string), "> %s has turned the radio to %s.", ReturnName(playerid, 0), XMRStationInfo[SubXMRHolder[playerid]][eXMRStationName]);
		SetPlayerChatBubble(playerid, string, COLOR_ACTION, 20.0, 3000);
		SendClientMessage(playerid, 0x88AA62FF, string);
		
		foreach(new i : Player)
		{
			if(IsPlayerInVehicle(i, vehicleid))
			{
				PlayAudioStreamForPlayer(i, XMRStationInfo[SubXMRHolder[playerid]][eXMRStationURL]); 
				SendClientMessageEx(i, COLOR_RED, "Radio changed to station %s.", XMRStationInfo[SubXMRHolder[playerid]][eXMRStationName]); 
			}
		}
		
		if(!VehicleInfo[vehicleid][eVehicleXMROn])
			VehicleInfo[vehicleid][eVehicleXMROn] = true;
			
		format(VehicleInfo[vehicleid][eVehicleXMRURL], 128, "%s", XMRStationInfo[SubXMRHolder[playerid]][eXMRStationURL]); 
		SubXMRHolder[playerid] = 0;
		
		return 1;
	}
	
	if(propertyid != 0)
	{
		format(string, sizeof(string), "> %s has turned the radio to %s.", ReturnName(playerid, 0), XMRStationInfo[SubXMRHolder[playerid]][eXMRStationName]);
		SetPlayerChatBubble(playerid, string, COLOR_ACTION, 20.0, 3000);
		SendClientMessage(playerid, 0x88AA62FF, string);
		
		foreach(new i : Player)
		{
			if(IsPlayerInProperty(i) == propertyid)
			{
				PlayAudioStreamForPlayer(i, XMRStationInfo[SubXMRHolder[playerid]][eXMRStationURL]); 
				SendClientMessageEx(i, COLOR_RED, "Radio changed to station %s.", XMRStationInfo[SubXMRHolder[playerid]][eXMRStationName]); 
			}
		}
		
		if(!PropertyInfo[propertyid][ePropertyBoomboxOn])
			PropertyInfo[propertyid][ePropertyBoomboxOn] = true;
			
		format(PropertyInfo[propertyid][ePropertyBoomboxURL], 128, "%s", XMRStationInfo[SubXMRHolder[playerid]][eXMRStationURL]);
		SubXMRHolder[playerid] = 0; 
		
		return 1;
	}

	return 1; 
}

stock ReturnNameLetter(playerid)
{
	new 
		playersName[MAX_PLAYER_NAME]
	; 
	
	GetPlayerName(playerid, playersName, sizeof(playersName));
	
	format(playersName, sizeof(playersName), "%c. %s", playersName[0], playersName[strfind(playersName, "_") + 1]);
	return playersName;
}

stock SendBusinessType(playerid, id)
{
	switch(BusinessInfo[id][eBusinessType])
	{
		case BUSINESS_TYPE_AMMUNATION:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "Welcome to %s.", BusinessInfo[id][eBusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buygun, /buyammo."); 
		}
		case BUSINESS_TYPE_BANK:
		{
			SendClientMessage(playerid, COLOR_DARKGREEN, "Bank: /bank, /withdraw, /balance."); 
		}
		case BUSINESS_TYPE_GENERAL:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "Welcome to %s.", BusinessInfo[id][eBusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buy, /withdraw, /balance."); 
		}
		case BUSINESS_TYPE_CLUB:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "Welcome to %s.", BusinessInfo[id][eBusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buydrink."); 
		}
		case BUSINESS_TYPE_RESTAURANT:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "Welcome to %s. This is a fast food restaurant.", BusinessInfo[id][eBusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /eat."); 
		}
	}
	return 1;
}

stock GetChannelSlot(playerid, chan)
{
	for(new i = 1; i < 3; i++)
	{
		if(PlayerInfo[playerid][pRadio][i] == chan)
			return i;
	}
	return 0; 
}

stock ResetDealershipVars(playerid)
{
	DealershipPlayerCar[playerid] = INVALID_VEHICLE_ID; 
	DealershipTotalCost[playerid] = 0;

	DealershipAlarmLevel[playerid] = 0;
	DealershipImmobLevel[playerid] = 1;
	
	DealershipLockLevel[playerid] = 0;
	DealershipXMR[playerid] = 0; 
	
	for(new i = 0; i <2 ;i++) { DealershipCarColors[playerid][i] = 0; }
	return 1;
}

stock ShowDealerAppend(playerid)
{
	new
		caption[60],
		str[255]
	;

	format(caption, 60, "%s - {33AA33}%s", g_aDealershipData[SubDealershipHolder[playerid]][eDealershipModel], MoneyFormat(DealershipTotalCost[playerid])); 
				
	strcat(str, "Alarm\n");
	strcat(str, "Lock\n");
	strcat(str, "Immobiliser\n");
	strcat(str, "Colors\n");
				
	if(DealershipXMR[playerid])
		strcat(str, "{FFFF00}XM-Radio Installed\n");
					
	else strcat(str, "No XM Installed\n");
				
	strcat(str, "{FFFF00}Purchase Vehicle\n"); 
			
	ShowPlayerDialog(playerid, DIALOG_DEALERSHIP_APPEND, DIALOG_STYLE_LIST, caption, str, "Append", "<<"); 
	return 1; 
}

stock IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

stock ShowPlayerPlates(playerid, str[])
{
	for(new i = 0; i < 2; i++)
	{
		PlayerTextDrawShow(playerid, CarBought_PTD[playerid][i]);
	}
	
	PlayerTextDrawSetString(playerid, CarBought_PTD[playerid][1], str);
	SetTimerEx("OnPlateSet", 4000, false, "i", playerid); 
	return 1;
}

stock ReturnBodypartName(bodypart)
{
	new bodyname[20];
	
	switch(bodypart)
	{
		case BODY_PART_CHEST:bodyname = "CHEST";
		case BODY_PART_GROIN:bodyname = "GROIN";
		case BODY_PART_LEFT_ARM:bodyname = "LEFT ARM";
		case BODY_PART_RIGHT_ARM:bodyname = "RIGHT ARM";
		case BODY_PART_LEFT_LEG:bodyname = "LEFT LEG";
		case BODY_PART_RIGHT_LEG:bodyname = "RIGHT LEG";
		case BODY_PART_HEAD:bodyname = "HEAD";
	}
	
	return bodyname;
}

stock CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount)
{
	new
		id,
		Float:armor
	;
	
	TotalPlayerDamages[playerid] ++; 
	
	for(new i = 0; i < 100; i++)
	{
		if(!DamageInfo[playerid][i][eDamageTaken])
		{
			id = i;
			break;
		}
	}
	
	GetPlayerArmour(playerid, armor);
	
	if(armor > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;
		
	else DamageInfo[playerid][id][eDamageArmor] = 0;
	
	DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round); 
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;
	
	DamageInfo[playerid][id][eDamageBodypart] = bodypart; 
	DamageInfo[playerid][id][eDamageTime] = gettime();
	
	DamageInfo[playerid][id][eDamageBy] = PlayerInfo[issuerid][pDBID]; 
	return 1; 
}

stock ShowPlayerDamages(damageid, playerid, adminView)
{
	new
		caption[33],
		str[355], 
		longstr[1200]
	; 
	
	format(caption, sizeof(caption), "%s", ReturnName(damageid));
	
	if (TotalPlayerDamages[damageid] < 1)
		return ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, "There aren't any damages to show.", "<<", ""); 

	switch(adminView)
	{
		case 0:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				format(str, sizeof(str), "%d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
		case 1:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				format(str, sizeof(str), "{FF6346}(%s){FFFFFF} %d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", ReturnDBIDName(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
	}
	return 1;
}

stock ClearDamages(playerid)
{
	for(new i = 0; i < 100; i++)
	{
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0; 
		
		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;
		
		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0; 
	}
	
	return 1;
}

stock ShowBuylist(playerid)
{ 
	new
		id = IsPlayerInBusiness(playerid),
		str[90]
	;

	format(str, sizeof(str), "%s", BusinessInfo[id][eBusinessName]);
		
	ShowPlayerDialog(playerid, DIALOG_BUY_LIST, DIALOG_STYLE_TABLIST_HEADERS, str, 
	"Product\tPrice\n\
		2 Slot Radio\t$1,000\n\
		Gas Can\t$500\n\
		Mask\t$2000\n\
		",
			"Select", "Cancel");
	
	return 1;
}

stock ReturnHour()
{
	new time[36]; 
	
	gettime(time[0], time[1], time[2]);
	
	format(time, sizeof(time), "%02d:%02d", time[0], time[1]);
	return time;
}

stock ReturnLicenses(playerid, playerb)
{
	new
		driver_str[60],
		wep_str[60]
	;
	
	if(!PlayerInfo[playerid][pDriversLicense])
		driver_str = "{FF6346}Driving License : No";
		
	else driver_str = "{E2FFFF}Driving License : Yes";
	
	if(!PlayerInfo[playerid][pWeaponsLicense])
		wep_str = "{FF6346}Weapons License : No";
	
	else wep_str = "{E2FFFF}Weapons License : Yes";
	
	SendClientMessage(playerb, COLOR_DARKGREEN, "______Identification_______");
	SendClientMessageEx(playerb, COLOR_GRAD2, "Name : %s", ReturnName(playerid)); 
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", driver_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", wep_str); 
	SendClientMessage(playerb, COLOR_DARKGREEN, "___________________________"); 
	return 1;
}

stock IsPlayerInDMVVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof dmv_vehicles; i++)
	{
		if(vehicleid == dmv_vehicles[i])
			return 1;
	}
		
	return 0;
}

stock StopDriverstest(playerid)
{
	SetVehicleToRespawn(PlayersLicenseVehicle[playerid]);
	ToggleVehicleEngine(PlayersLicenseVehicle[playerid], false); 
	VehicleInfo[PlayersLicenseVehicle[playerid]][eVehicleEngineStatus] = false;
	
	PlayersLicenseVehicle[playerid] = INVALID_VEHICLE_ID; 
	
	PlayerLicensePoint[playerid] = 0;
	PlayerTakingLicense[playerid] = false;
	
	DisablePlayerCheckpoint(playerid);
	return 1;
}

stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i != sizeof(gSAZones); i++ )
	{
        if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
        {
            return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
        }
	}
	return 0;
}

stock ReturnLocation(playerid)
{
	new 
		playerLocation[MAX_ZONE_NAME]
	;
	
	GetPlayer2DZone(playerid, playerLocation, MAX_ZONE_NAME);
	return playerLocation;
}

stock Send911Message(playerid, type)
{
	switch(type)
	{
		case 911:
		{
			foreach(new i : Player) if(PlayerInfo[i][pPoliceDuty])
			{
				SendClientMessage(i, COLOR_CYAN, "|____________Emergency Call____________|");
				SendClientMessageEx(i, COLOR_CYAN, "Caller: %s, Phone: %d, Trace: %s", ReturnName(playerid, 0), PlayerInfo[playerid][pPhone], ReturnLocation(playerid));
				SendClientMessageEx(i, COLOR_CYAN, "Service required: %s", Player911Text[playerid][0]);
				SendClientMessageEx(i, COLOR_CYAN, "Situation: %s", Player911Text[playerid][1]);
				SendClientMessageEx(i, COLOR_CYAN, "Location: %s", Player911Text[playerid][2]); 
			}
		}
		case 800:
		{
			foreach(new i : Player) if(PlayerInfo[i][pMedicDuty])
			{
				SendClientMessage(i, COLOR_PINK, "|____________Emergency Call____________|");
				SendClientMessageEx(i, COLOR_PINK, "Caller: %s, Phone: %d, Trace: %s", ReturnName(playerid, 0), PlayerInfo[playerid][pPhone], ReturnLocation(playerid));
				SendClientMessageEx(i, COLOR_PINK, "Service required: %s", Player911Text[playerid][0]);
				SendClientMessageEx(i, COLOR_PINK, "Situation: %s", Player911Text[playerid][1]);
				SendClientMessageEx(i, COLOR_PINK, "Location: %s", Player911Text[playerid][2]); 
			}
		}
	}
	

	Player911Type[playerid] = 0;	
	cmd_hangup(playerid, ""); 
	return 1;
}

stock ShowPlayerMDC(playerid)
{
	new
		list_str[128]
	;

	strcat(list_str, "Name Search\n");
	strcat(list_str, "Plate Search\n"); 
		
	ShowPlayerDialog(playerid, DIALOG_MDC, DIALOG_STYLE_LIST, "Mobile Database Computer", list_str, "Select", "Exit");
	return 1;
}

stock HasNoEngine(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}
