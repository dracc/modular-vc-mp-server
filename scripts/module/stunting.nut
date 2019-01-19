//

function onScriptLoad() {

  BIND_LOAD_POS <- BindKey(true,0x08,0,0); // backspace
  BIND_SAVE_POS <- BindKey(true,0x2E,0,0); // delete
  BIND_FLIP <- BindKey(true,0x23,0,0); // end

  //FIXME: This should be a class, and probably a table;
  //       possibly extend the player class
  savedv <- array( 100, null );
  savedvs <- array( 100, null );
  savedslot <- array( 100, null );
  savedloc <- array( 100, null );
  savedang <- array( 100, null );

  SetDrivebyEnabled( false );
  SetTaxiBoostJump( true );
  SetJumpSwitch( false );
  SetStuntBike( false );

  SetFrameLimiter(true);
}

function loadPosition(player) {
  local i = player.ID;

  local angle

  if (savedloc[i] ) {

    // Attempt to increase stability
    for(local x = 0; x < 5; x++) {

      // Animation should help with cancelling out of fall-animation which
      // prevents entering vehicles
      if (!player.Vehicle) {
	      player.SetAnim(0, 3);
      }

      local v = savedv[i];
      local vs = savedvs[i];
      if (v) {
        if (v.Wrecked) {
          v.Fix() //FIXME: Also restore health?
        }
        if (vs == 0) {
          v.Pos = savedloc[i];
          v.Angle = savedang[i];
          v.Speed = Vector(0, 0, 0);
          v.TurnSpeed = Vector(0, 0, 0);
        }
        //print("Putting " + player + " in " + v + " slot " + vs)

        // Only move player if necessary (messes with animation system):
        // - There's nobody where the player should be
        // - There's another player where the player should be
        local occupant = v.GetOccupant(vs)
        if ((!occupant) || (occupant.ID != player.ID)) {
          //print("Was " + player + " in " + player.Vehicle + " slot " + player.VehicleSlot)
          if (vs == 0) {
            player.Vehicle = v;
          } else {
            player.Pos = v.Pos;
            player.PutInVehicleSlot(v, vs);
          }
        }

        angle = v.GetRadiansAngle()
      } else {
        player.Pos = savedloc[ i ];
        angle = player.Angle
      }

    }

  } else {
    angle = 0.0
  }

  return angle
}


function onKeyDown( player, key ) {

  if(!player.Spawned) {
    return;
  }

  local i = player.ID;

  //FIXME: Fix these for passengers

  if ( key == BIND_SAVE_POS ) {
    savedloc[ i ] = player.Pos;
    local v = player.Vehicle;
    local vs = player.VehicleSlot;
    if (v) {
      savedang[i] = v.Angle;
      savedv[i] = v;
      savedvs[i] = vs;
    } else {
      savedang[i] = null; //FIXME: store an angle
      savedv[i] = null;
      savedvs[i] = null;
    }
    MessagePlayer( "[#ff0000] Position saved." ,player );
    PlaySoundForPlayer(player, 375);
  }

  if ( key == BIND_LOAD_POS ) {
    local angle = loadPosition(player)

    // Attempt to warp camera
    //local pos = Vector(savedloc[i].x, savedloc[i].y, savedloc[i].z + 1.0)
    //player.SetCameraPos(GetForwardPoint(pos, angle, -8.0), GetForwardPoint(pos, angle, 1.0) );
  }

  if ( key == BIND_FLIP ) {
    if ( player.VehicleSlot == 0 ) {
        local rot = player.Vehicle.Rotation;
        rot.x = rot.y = 0;
    } else {
      MessagePlayer( "[#ff0000][Error] - You are not in any vehicle." ,player );
    }
  }

}

function onKeyUp( player, key ) {

  if(!player.Spawned) {
    return;
  }

  if ( key == BIND_LOAD_POS ) {
    loadPosition(player)

    // Finish camera warp
    // player.RestoreCamera()
  }
}


function onPlayerPart( player, reason ) {
  local id = player.ID;
  savedloc[ id ] = null;
}


// Make player harder to kill

function onPlayerSpawn( player ) {
  player.Immunity = 255;
  player.World = 1;
  player.CanAttack = false;
}

function onPlayerHealthChange( player, lastHP, newHP ) {
  player.Health = 100.0
}

function onVehicleHealthChange( vehicle, oldHP, newHP ) {
  
  // Recover from serious burning
  if (newHP <= 500.0) {
    vehicle.Fix();
  }

  //FIXME: Why? What is this?
  local id = vehicle.Model;
  //if ( id == 190 || id == 136 || id == 160 || id == 176 || id == 183 || id == 184 || id == 202 || id == 203 || id == 214 ) {
  //}
}
