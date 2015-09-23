/*
	Check if the unit can see the player
	Used for DMS, ask if you want it for other things.

	USED FOR TESTING ONLY

	CALLED IN AN UNSCHEDULED ENVIORMENT
	IF YOU USE THIS OUTSIDE OF AN FSM YOU MAY SUFFER MORE CPS/FPS DROPS.
*/

private ["_player","_unit","_eyeDirection","_eyeCalc","_dirTo","_eyeD","_eyePb","_eyePa"];

_player = _this select 0;
_unit 	= _this select 1;

while {true} do {
	_eyeDirection = eyeDirection _unit;
	_eyeCalc = (
		(_eyeDirection select 0)
		 atan2 (_eyeDirection select 1)
	 );

	if (_eyeCalc < 0) then {
		_eyeCalc = 360 + _eyeCalc;
	};

	_dirTo = [_unit, _unit] call BIS_fnc_dirTo;
	_eyePunit = eyePos _unit;
	_eyePplayer = eyePos _player;

		if ((abs(_dirTo - _eyeCalc) >= 90 && 
			(abs(_dirTo - _eyeCalc) <= 270)) || 
			(lineIntersects [_eyePunit, _eyePplayer]) || 
			(terrainIntersectASL [_eyePunit, _eyePplayer])
			) then {
			hint "NOT VISIBLE";
		} else {
		hint "VISIBLE";
	};
	sleep 0.5;
};