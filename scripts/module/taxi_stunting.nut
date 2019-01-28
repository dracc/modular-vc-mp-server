//

height_cp <- array( 100, null);
height_ma <- array( 100, null);
height_cp_timer <- array( 100, null);



function resetRecord() {
  height_record <- null;
  height_record_holder <- null;
  height_record_vehicle <- null;
  height_record_position <- null;
}

function onScriptLoad() {

  height_record_checkpoint <- null;
  resetRecord();

  SetTaxiBoostJump( true );
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ ) {
  
  // We only care once we are falling again
  if (newZ >= lastZ) {
    return;
  }

  local v = player.Vehicle;

  if (!v) {
    return;
  }

  local id = v.Model;
  if (!(id == 150 || id == 188 || id == 216)) {
    return;
  }

  // You must be this much higher
  local threshold = 0.0;

  local height = v.Pos.z;
  if (!height_record || height > (height_record + threshold)) {
    height_record = height;
    height_record_holder = player.Name;
    height_record_vehicle = id;
    height_record_position = v.Pos;

    //FIXME: Be more picky about when we print this / wait until the attempt is over
    local message = player.Name + " just broke the height record! " +
      "New record is " + height_record;
    MessagePlayer(message, player);
  }
}

function createVisual(player, duration) {
  removeVisual(player.ID);
  height_cp[player.ID] = CreateCheckpoint(player, player.UniqueWorld, false,
					  height_record_position, ARGB(255, 255, 0, 0), 4);
  height_ma[player.ID] = CreateMarker(player.UniqueWorld, height_record_position,
				      5, RGB(255, 0, 0), 0 );

  height_cp_timer[player.ID] = NewTimer("removeVisual", duration, 1, player.ID);
}

function removeVisual(ID) {
  if (height_cp_timer[ID] != null) {
    height_cp_timer[ID].Delete();
    height_cp_timer[ID] = null;
  }
  if (height_cp[ID] != null) {
    height_cp[ID].Remove();
    height_cp[ID] = null;
  }
  if (height_ma[ID] != null) {
    DestroyMarker(height_ma[ID]);
    height_ma[ID] = null;
  }
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "height") {
    local message;
    if (height_record) {
      message = "Height record was " + height_record + " by " +
	height_record_holder + " in " + GetVehicleNameFromModel(height_record_vehicle);
      createVisual(player, 10000);

    } else {
      message = "There is no height record yet";
    }
    MessagePlayer(message, player);
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/height", player);
  }

  if (player.Admin) {
    if (cmd == "reset_height") {
      resetRecord();
      Message("Height record was reset");
    } else if (cmd == "help") {
      MessagePlayer("[#80A0A0]/reset_height", player);
    }
  }
}

// Hack, because this script might not be in global context, so timers suck
local globals = getroottable();
globals["removeVisual"] <- removeVisual;
globals["height_cp"] <- height_cp;
globals["height_ma"] <- height_ma;
globals["height_cp_timer"] <- height_cp_timer;
