scripts <- [];

function scripts_load(name) {
  local path = "./scripts/" + name;
  print("Loading " + path);

  local context = {};
  dofile.call(context, path, true);

  // Add all our global symbols to context, unless it's an event handler
  local globals = getroottable();
  foreach(key, value in globals) {
    //print("  * " + key + ": " + value);
    if (key in Hooks) {
      //print("  # Skipping " + key);
      continue;
    }
    if (type(value) == "function") {
      value = value.bindenv(globals);
    }
    context[key] <- value;
  }

  scripts.append([name, context]);
}

function scripts_handle(name, ...) {
  //print("Handling " + name + " in " + scripts.len() + " script(s)")

  local final_result = 1;

  // Add a dummy for the `this` pointer
  local a = vargv;
  a.insert(0, null);

  foreach(script in scripts) {

    local script_name = script[0];
    local script_context = script[1];

    if (!(name in script_context)) {
      //print("  - " + script_name);
      continue;
    } else {
      //print("  + " + script_name);
    }

    local f = script_context[name];

    // Fixup `this` pointer
    a[0] = script_context;

    try {
      local result = f.acall(a);

      //FIXME: handle result conflicts
      final_result = result;
    }
    catch(exception) {
      print(exception);
      print(getstackinfos(1).locals);
      throw exception;
    }
  }
  return final_result;
}

class Hooks {

function onServerStart() {
  scripts_handle("onServerStart");
}

function onServerStop() {
  scripts_handle("onServerStop");
}

function onScriptLoad() {
  scripts_handle("onScriptLoad");
}

function onScriptUnload() {
  scripts_handle("onScriptUnload");
}

// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player ) {
  scripts_handle("onPlayerJoin", player);
}

function onPlayerPart( player, reason ) {
  scripts_handle("onPlayerPart", player, reason);
}

function onPlayerRequestClass( player, classID, team, skin ) {
  return scripts_handle("onPlayerRequestClass", player, classID, team, skin);
}

function onPlayerRequestSpawn( player ) {
  return scripts_handle("onPlayerRequestSpawn", player);
}

function onPlayerSpawn( player ) {
  scripts_handle("onPlayerSpawn", player);
}

function onPlayerDeath( player, reason ) {
  scripts_handle("onPlayerDeath", player, reason);
}

function onPlayerKill( player, killer, reason, bodypart ) {
  scripts_handle("onPlayerKill", player, killer, reason, bodypart);
}

function onPlayerTeamKill( player, killer, reason, bodypart ) {
  scripts_handle("onPlayerTeamKill", player, killer, reason, bodypart);
}

function onPlayerChat( player, text ) {
  return scripts_handle("onPlayerChat", player, text);
}

function onPlayerCommand( player, cmd, text ) {
  return scripts_handle("onPlayerCommand", player, cmd, text);
}

function onPlayerPM( player, playerTo, message ) {
  return scripts_handle("onPlayerPM", player, playerTo, message);
}

function onPlayerBeginTyping( player ) {
}

function onPlayerEndTyping( player ) {
}

/*
function onLoginAttempt( player ) {
  return 1;
}
*/

function onNameChangeable( player ) {
}

function onPlayerSpectate( player, target ) {
}

function onPlayerCrashDump( player, crash ) {
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ ) {
  scripts_handle("onPlayerMove", player, lastX, lastY, lastZ, newX, newY, newZ);
}

function onPlayerHealthChange( player, lastHP, newHP ) {
  scripts_handle("onPlayerHealthChange", player, lastHP, newHP);
}

function onPlayerArmourChange( player, lastArmour, newArmour ) {
}

function onPlayerWeaponChange( player, oldWep, newWep ) {
}

function onPlayerAwayChange( player, status ) {
}

function onPlayerNameChange( player, oldName, newName ) {
}

function onPlayerActionChange( player, oldAction, newAction ) {
}

function onPlayerStateChange( player, oldState, newState ) {
}

function onPlayerOnFireChange( player, IsOnFireNow ) {
}

function onPlayerCrouchChange( player, IsCrouchingNow ) {
}

function onPlayerGameKeysChange( player, oldKeys, newKeys ) {
  return scripts_handle("onPlayerGameKeysChange", player, oldKeys, newKeys);
}

// ========================================== V E H I C L E   E V E N T S =============================================

function onPlayerEnteringVehicle( player, vehicle, door ) {
  return scripts_handle("onPlayerEnteringVehicle", player, vehicle, door);
}

function onPlayerEnterVehicle( player, vehicle, door ) {
  scripts_handle("onPlayerEnterVehicle", player, vehicle, door);
}

function onPlayerExitVehicle( player, vehicle ) {
  scripts_handle("onPlayerExitVehicle", player, vehicle);
}

function onVehicleExplode( vehicle ) {
  scripts_handle("onVehicleExplode", vehicle);
}

function onVehicleRespawn( vehicle ) {
  scripts_handle("onVehicleRespawn", vehicle);
}

function onVehicleHealthChange( vehicle, oldHP, newHP ) {
  scripts_handle("onVehicleHealthChange", vehicle, oldHP, newHP);
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ ) {
}

// =========================================== P I C K U P   E V E N T S ==============================================

function onPickupClaimPicked( player, pickup ) {
  return 1;
}

function onPickupPickedUp( player, pickup ) {
}

function onPickupRespawn( pickup ) {
}

// ========================================== O B J E C T   E V E N T S ==============================================

function onObjectShot( object, player, weapon ) {
}

function onObjectBump( object, player ) {
}

// =========================================== B I N D   E V E N T S ==============================================

function onKeyDown( player, key ) {
  scripts_handle("onKeyDown", player, key);
}

function onKeyUp( player, key ) {
  scripts_handle("onKeyUp", player, key);
}

// Forgotten stuff

function onCheckpointEntered( player, checkpoint ) {
  scripts_handle("onCheckpointEntered", player, checkpoint);
}
}


// Add all hooks to global table
local globals = getroottable();
foreach(key, value in Hooks) {
  if (key in globals) {
    print(key + " already hooked");
  }
  globals[key] <- value;
}
