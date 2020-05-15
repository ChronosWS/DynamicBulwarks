#include "shared\bulwark.hpp"

// variable to prevent players rejoining during a wave
playersInWave = [];
publicVariable "playersInWave";

// Broadcast the starting killpoints for everyone
{
  // Current result is saved in variable _x
  [_x, BULWARK_PARAM_START_KILLPOINTS call shared_fnc_getCurrentParamValue] call killPoints_fnc_add;
} forEach allPlayers;

//init phase
["<t size = '.5'>Loading lists.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];
private _hostileFunctions = [ //could make more efficent init phase with loadingscreen
  "createWave",
  "waveTypes"
];
{
	[] call (compileFinal (preprocessFile format ["hostiles\%1.sqf", _x]));
} forEach _hostileFunctions;

// Do these need to be done in ExecVM?
"Setting params and lists" call shared_fnc_log;

call compile preprocessFileLineNumbers "setParams.sqf";
call compile preprocessFileLineNumbers  "locationLists.sqf";
call compile preprocessFileLineNumbers  "presets\init_preset.sqf";
call compile preprocessFileLineNumbers  "loot\lists.sqf";
call compile preprocessFileLineNumbers  "hostiles\lists.sqf";

// _hmissionParams = [] execVM "setParams.sqf";
// _hLocation = [] execVM "locationLists.sqf";
// _hpreset =   [] execVM "presets\init_preset.sqf";
// waitUntil {scriptDone _hpreset};
// _hLoot     = [] execVM "loot\lists.sqf";
// _hHostiles = [] execVM "hostiles\lists.sqf";
// waitUntil {
//     scriptDone _hLoot &&
//     scriptDone _hHostiles
// };

["<t size = '.5'>Creating Base...</t>", 0, 0, 30, 0] remoteExec ["BIS_fnc_dynamicText", 0];
_basepoint = [] execVM "bulwark\createBase.sqf";
waitUntil { scriptDone _basepoint };

["<t size = '.5'>Ready</t>", 0, 0, 0.5, 0] remoteExec ["BIS_fnc_dynamicText", 0];

publicVariable "bulwarkBox";
publicVariable "PARATROOP_CLASS";
publicVariable "BULWARK_SUPPORTITEMS";
publicVariable "BULWARK_BUILDITEMS";
publicVariable "PLAYER_STARTWEAPON";
publicVariable "PLAYER_STARTMAP";
publicVariable "PLAYER_STARTNVG";
publicVariable "PISTOL_HOSTILES";
publicVariable "DOWN_TIME";
publicVariable "RESPAWN_TICKETS";
publicVariable "RESPAWN_TIME";
publicVariable "PLAYER_OBJECT_LIST";
publicVariable "MIND_CONTROLLED_AI";
publicVariable "SCORE_RANDOMBOX";
publicVariable "magLAUNCHER";
publicVariable "magASSAULT";
publicVariable "magSMG";
publicVariable "magSNIPER";
publicVariable "magMG";
publicVariable "magHANDGUN";

//determine if Support Menu is available
_supportParam = (BULWARK_PARAM_SUPPORT_MENU call shared_fnc_getCurrentParamValue);
if (_supportParam == 1) then {
  SUPPORTMENU = false;
}else{
  SUPPORTMENU = true;
};
publicVariable 'SUPPORTMENU';

//Determine team damage Settings
_teamDamageParam = (BULWARK_PARAM_TEAM_DAMAGE call shared_fnc_getCurrentParamValue);
if (_teamDamageParam == 0) then {
  TEAM_DAMAGE = false;
}else{
  TEAM_DAMAGE = true;
};
publicVariable 'TEAM_DAMAGE';

//determine if hitmarkers appear on HUD
HITMARKERPARAM = (BULWARK_PARAM_HUD_POINT_HITMARKERS call shared_fnc_getCurrentParamValue);
publicVariable 'HITMARKERPARAM';

_dayTimeHours = DAY_TIME_TO - DAY_TIME_FROM;
_randTime = floor random _dayTimeHours;
_timeToSet = DAY_TIME_FROM + _randTime;
setDate [2018, 7, 1, _timeToSet, 0];

"Starting mission loop" call shared_fnc_log;
//[] execVM "revivePlayers.sqf";
[bulwarkRoomPos] execVM "missionLoop.sqf";

[] execVM "area\areaEnforcement.sqf";
[] execVM "hostiles\clearStuck.sqf";
//[] execVM "hostiles\solidObjects.sqf";
[] execVM "hostiles\moveHosToPlayer.sqf";

"StartGame complete" call shared_fnc_log;
