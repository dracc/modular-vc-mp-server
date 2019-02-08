//

function onScriptLoad() {
  PublicRamps <- array( 100, null );
  PrivateRamps <- array( 100, null );
}

function onPlayerGameKeysChange( player, oldKey, newKey ) {

  if ( newKey & KEY_ONFOOT_FIRE && player.VehicleSlot==-1 ) {
    if ( PublicRamps[player.ID] ) {
      PublicRamps[player.ID].Delete();
    }
    if ( PrivateRamps[player.ID] ) {
      PrivateRamps[player.ID].Delete();
    }
    local v = player.Vehicle;
    local pos;
    local angle;
    local angle2;
    if (v) {
      pos = v.Pos;
      angle = v.GetRadiansAngle();
      angle2 = v.EulerAngle;
    } else {
      pos = player.Pos;
      angle = player.Angle;
      angle2 = Vector(0, 0, angle);
    }
    pos = GetForwardPoint( pos, angle, 10.0 );
    local publicRampObj = CreateObject( 562, player.World, pos, 150 );
    local privateRampObj = CreateObject( 562, player.UniqueWorld, pos, 255 );
    publicRampObj.RotateToEuler(angle2, 0);
    privateRampObj.RotateToEuler(angle2, 0);
    PublicRamps[player.ID] = publicRampObj;
    PrivateRamps[player.ID] = privateRampObj;
  }

  if ( newKey & KEY_ONFOOT_AIM && player.VehicleSlot==-1 ) {
    if ( PublicRamps[player.ID] ) {
      PublicRamps[player.ID].Delete();
    }
    if ( PrivateRamps[player.ID] ) {
      PrivateRamps[player.ID].Delete();
    }
  }
}

function onPlayerPart( player, reason ) {
  local id = player.ID;
  if (PublicRamps[id]) {
    PublicRamps[id].Delete();
  }
  if ( PrivateRamps[id] ) {
    PrivateRamps[id].Delete();
  }
}

