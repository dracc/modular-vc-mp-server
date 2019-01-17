// VC-MP server script
//
// (c) 2019 Jannik Vogel

srand(GetTickCount());

function GetForwardPoint(pos, rad, d) {
  local x = pos.x - d * sin(rad);
  local y = pos.y + d * cos(rad);
  local z = pos.z;
  return Vector(x, y, z);
}

function TeleportPlayer(player, pos, angle) {
  local v = player.Vehicle;
  if ( v ) {
    v.Pos = pos
    //FIXME: Handle quaternions
    angle = Vector(0,0,angle)

      v.EulerAngle = angle
    //} else {
      //v.Angle = angle
    //}
    v.Speed = Vector(0,0,0)
  } else {
    player.Pos = pos
  }
}

function random( min = 0, max = RAND_MAX ) {
    local r = rand();
    srand( GetTickCount() * r );
    return ( r % ( ( max + 1 ) - min ) ) + min;
}

dofile("./scripts/scripts.nut")

scripts_load("base/freeroam.nut")
scripts_load("module/interiors.nut")
scripts_load("module/vehicle_spawner.nut")
scripts_load("module/emote.nut")
scripts_load("module/teleporter.nut")
scripts_load("module/spectate.nut")
scripts_load("module/chat.nut")
scripts_load("module/goto.nut")
scripts_load("module/stunting.nut")
scripts_load("module/skin.nut")
scripts_load("module/ramp.nut")
scripts_load("module/taxi_stunting.nut")
scripts_load("module/auto_class.nut")
scripts_load("module/admin.nut")
scripts_load("module/debug.nut")
print("Scripts loaded")

