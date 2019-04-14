function onScriptLoad() {
  GHOSTKEY <- BindKey( true, 0x47, 0, 0 ); // G
  ghost <- array( 100, false );
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "ghost") {
    ghost[player.ID] = !ghost[player.ID];
    local message = "Your vehicle is a ghost: ";
    if (ghost[player.ID]) {
      if (player.VehicleSlot == 0) { // Player is driver
        player.Vehicle.IsGhost = true;
      }
      message += "ON";
    } else {
      if (player.VehicleSlot == 0) {
        player.Vehicle.IsGhost = false;
      }
      message += "OFF";
    }
    MessagePlayer(message, player);
  } else  if (cmd == "help") {
    MessagePlayer("[#8080A0]/ghost", player);
  }
}

function onPlayerEnterVehicle( player, vehicle, door ) {
  if (ghost[player.ID] && player.VehicleSlot == 0) {
    vehicle.IsGhost = true;
  }
}

function onPlayerExitVehicle( player, vehicle ) {
  if (player.VehicleSlot == 0) {
    vehicle.IsGhost = false;
  }
}

function onPlayerPart( player, reason ) {
  if (player.VehicleSlot == 0) {
    player.Vehicle.IsGhost = false;
  }
}
