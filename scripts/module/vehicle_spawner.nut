function deletePlayerVehicles( player ) {
  for( local i=0; i < owner.len(); i++ ) {
    if ( owner[ i ] == player.Name ) {
      local v = FindVehicle( i );
      if ( v ) v.Delete();
      owner[ i ] = null;
    }
  }
  owner[ player.ID ] = null;

  CVehTime[ player.ID ] = 0;
}

function spawnVehicle(player, model) {
  local text = model;

  if (!player.IsSpawned) {
    MessagePlayer( "[#ff0000]Failed, need to spawn first." ,player );
    return;
  }

  if ( !text) {
    MessagePlayer( "[#ff0000]Failed, need ID or name." ,player );
    return;
  }

  if ( CVehTime[ player.ID ] > 9 ) {
    MessagePlayer( "[#ff0000]Failed, you have created too many vehicles, use" +
		   " /delete to delete them.", player );
    return 0; 
  }

  // Get model number
  local model;
  if (IsNum( text )) {
    model = text.tointeger();
  } else {
    model = GetVehicleModelFromName(text);
  }

  // Validate model number
  if (model == false) {
    MessagePlayer( "[#ff0000]Failed, invalid ID." ,player );
    return;
  }

  // FIXME: Use proper position
  local pos;
  local angle;
  local v = player.Vehicle;
  if (v) {
    angle = v.GetRadiansAngle();
    pos =  GetForwardPoint(v.Pos, angle, 6.0);
    pos.z += 1.0;
  } else {
    angle = player.Angle;
    pos = GetForwardPoint(player.Pos, angle, 4.0);
    pos.z += 1.0;
  }

  // Spawn
  local col1 = random( 1,92 );
  local col2 = random( 1,92 );
  local v = CreateVehicle( model, pos, angle, col1, col2);

  if (!player.Vehicle) {
    player.Vehicle = v;
  }

  // Add to player inventory
  if ( v ) {
    owner[ v.ID ] = player.Name;
    CVehTime[ player.ID ]++;
    MessagePlayer( "[#00ff00]Vehicle Created Successfully!" ,player );
  }

  return v;
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "v" || cmd == "vehicle") {
    spawnVehicle(player, text);
  } else if (cmd == "delete") {
    deletePlayerVehicles(player);
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/v[ehicle] /delete", player);
  }
  return 1;
}

function onScriptLoad() {
  //FIXME: Grow these manually..
  owner <- array( 500, null );
  CVehTime <- array( GetMaxPlayers(), 0 );
}

function onPlayerPart( player, reason ) {
  deletePlayerVehicles( player );
}

function onPlayerEnteringVehicle( player, vehicle, door ) {
  vehicle.Immunity = 0xFF;
  local own = owner[ vehicle.ID ];
  if ( own ) {
    MessagePlayer( "[#FF00FF]You've entered " + own + "'s vehicle. (ID" +
		   vehicle.ID + ")", player );
  }
  return 1;
}

function onPlayerExitVehicle( player, vehicle ) {
}

