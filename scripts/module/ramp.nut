//

function onScriptLoad() {
  RampObj <- array( 100, null );
}

function onPlayerGameKeysChange( player, oldKey, newKey ) {

  if ( newKey & KEY_ONFOOT_FIRE && player.VehicleSlot==-1 ) {
    if ( RampObj[player.ID] ) {
      RampObj[player.ID].Delete();
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
    local obj = CreateObject( 562, player.World, pos, 220 );
    obj.RotateToEuler(angle2, 0);
    RampObj[player.ID] = obj;
  }

  if ( newKey & KEY_ONFOOT_AIM && player.VehicleSlot==-1 ) {
    if ( RampObj[player.ID] ) {
      RampObj[player.ID].Delete();
    }
  }
}

function onPlayerPart( player, reason ) {
  local id = player.ID;
  if (RampObj[id]) {
    RampObj[id].Delete();
  }
}

