/**
*  createBase
*
*  Selects a base location and spawns required mission items
*
*  Domain: Server
**/

_bulwarkLocation = [BULWARK_LOCATIONS, BULWARK_RADIUS] call bulwark_fnc_bulwarkLocation;
bulwarkRoomPos = _bulwarkLocation select 0;
bulwarkCity = _bulwarkLocation select 1;

bulwarkBox = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];
bulwarkBox setPosASL bulwarkRoomPos;
bulwarkBox allowDamage false;
clearItemCargoGlobal bulwarkBox;
clearWeaponCargoGlobal bulwarkBox;
clearMagazineCargoGlobal bulwarkBox;
clearBackpackCargoGlobal bulwarkBox;
//bulwarkBox addWeaponCargoGlobal["hgun_P07_F",10];
//bulwarkBox addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];
[bulwarkBox, ["Pickup", "bulwark\moveBox.sqf"]] remoteExec ["addAction", 0, true];
[bulwarkBox, ["Shop", "[] spawn bulwark_fnc_purchaseGui; ShopCaller = _this select 1"]] remoteExec ["addAction", 0, true];


/* Place a table in the room for the lulz */
_relPos = [bulwarkRoomPos, 10, 0] call BIS_fnc_relPos;
_hits = lineIntersectsSurfaces [bulwarkRoomPos vectorAdd [0,0,0.2], _relPos, bulwarkBox, objNull, true, 1, "GEOM", "NONE"];
_boxPos = getPos bulwarkBox;

if(count _hits > 0) then {
	_hit = _hits select 0;
	_obj = _hit select 2;
	_objDir = getDir _obj;

	_furthestDist = 0;
	_furthestAngle = 0;
	_furthestPos = [0,0,0];
	_furthestDir = 0;
	for ("_i") from 0 to 360 step 22.5 do {
		_checkAngle = _objDir + _i;
		_relPos = [bulwarkRoomPos, 10, _checkAngle] call BIS_fnc_relPos;
		_hits = lineIntersectsSurfaces [bulwarkRoomPos vectorAdd [0,0,0.2], _relPos, bulwarkBox, objNull, true, 1, "GEOM", "NONE"];
		if(count _hits > 0) then {
			_hit = _hits select 0;
			_hitPos = _hit select 0;
			_distance = _boxPos distance _hitPos;
			_normalDir = [[0,0,0],(_hit select 1)] call BIS_fnc_dirTo;

			if(_distance > _furthestDist) then {
				_furthestDist = _distance;
				_furthestAngle = _checkAngle;
				_furthestPos = _hitPos;
				_furthestDir = _normalDir;
			};
		};
	};

	_tablePos = [_furthestPos, -0.5, _furthestAngle] call BIS_fnc_relPos;
	table = createVehicle ["Land_TableSmall_01_f", [0,0,0], [], 0, "CAN_COLLIDE"];
	table setPos [_tablePos select 0, _tablePos select 1, _boxPos select 2];
	table setDir _furthestDir-90;
	bulwarkBox setDir _objDir;
};

_marker1 = createMarker ["Mission Area", bulwarkCity];
"Mission Area" setMarkerShape "ELLIPSE";
"Mission Area" setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
"Mission Area" setMarkerColor "ColorWhite";

lootHouses = bulwarkCity nearObjects ["House", BULWARK_RADIUS];

/* Spinner Box */
/*
_lootBoxRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
publicVariable "lootBox";
sleep 2;
lootBoxPos    = getPos lootBox; publicVariable "lootBoxPos";
lootBoxPosATL = getPosATL lootBox; publicVariable "lootBoxPosATL";
[lootBox, [
	    "<t color='#FF0000'>Spin the box!</t>", {
		//TODO: should use the return from spend call
		if(player getVariable "killPoints" >= SCORE_RANDOMBOX) then {
			[player, SCORE_RANDOMBOX] call killPoints_fnc_spend;
			// Call lootspin script on ALL clients
			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", player];
		} else {
			[format ["<t size='0.6' color='#ff3300'>%1 points required to spin the box</t>", SCORE_RANDOMBOX], -0.6, -0.35] call BIS_fnc_dynamicText;
		};
    }
]] remoteExec ["addAction", 0, true];
lootBox enableSimulationGlobal false;
*/