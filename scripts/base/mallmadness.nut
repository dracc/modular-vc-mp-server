//

weaponModelIDs <- [293, 259, 260, 261, 262, 263, 264, 265, 266, 267,
                   268, 269, 270, 291, 271, 272, 273, 274, 275, 277,
                   278, 279, 281, 282, 283, 284, 280, 276, 285, 286,
                   287, 288, 289, 290];

weaponPickupAmmo <- [ 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
                      1,  1,  3,  3,  3,  3,  2, 10,  8,  8,
                     12, 12, 30, 30, 30, 30, 30, 30, 14, 12,
                      4, 50, 60, 60];

spawns <- [Vector(459.92, 1005.26, 19.1811),
           Vector(456.142, 1090.34, 18.6455),
           Vector(453.955, 1102.85, 19.2268),
           Vector(362.586, 1060.88, 19.1874),
           Vector(464.045, 1202.4, 19.0113),
           Vector(428.258, 1224.51, 25.3848),
           Vector(373.796, 1244.51, 25.6426),
           Vector(356.106, 1111.4, 25.3876),
           Vector(414.485, 1138.62, 22.7296),
           Vector(431.755, 1078.82, 19.0915)];

alive <- array(100, null);
droppedWeapons <- {};

function onScriptLoad() {

  SetGameModeName("Mall Madness");

  AddClass(1, RGB(100,149,237), 64, Vector(-421.729, -485.533, 11.0655), 0,
           6,1, 19,20, 23,90);
  AddClass(2, RGB(100,149,237), 65, Vector(-421.729, -485.533, 11.0655), 0,
           3,1, 19,20, 24,90);
  AddClass(3, RGB(100,149,237), 66, Vector(-421.729, -485.533, 11.0655), 0,
           8,1, 20,15, 23,90);
  AddClass(4, RGB(100,149,237), 37, Vector(-421.729, -485.533, 11.0655), 0,
           9,1, 19,20, 22,90);

  SetVehiclesForcedRespawnHeight( 10000 );

  SetFrameLimiter(true);
}

function onPlayerJoin( player ) {
  MessagePlayer( "[#FF0000]Welcome to this VC-MP Mall Madness Server. ", player );
  PrivMessage( player, "Have a look at /rules and /help before playing." );
}

function onPlayerPart( player, reason ) {
  alive[player.ID] = null;
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "rules") {
    Message( "No disturbing other's play. Kids only." );
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/rules /help", player);
  }
}

function onPlayerSpawn( player ) {
  local pos = spawns[rand() % spawns.len()];
  TeleportPlayer(player, pos, 0);
  alive[player.ID] = true;
}

function onPlayerHealthChange( player, lastHP, newHP ) {
  if ( newHP < 1 && alive[player.ID]) {
    alive[player.ID] = false;
    local pos = player.Pos;
    local xOffset = 0;
    local zOffset = 0;
    local pickup = null;
    for (local i = 0; i <= 8; ++i) {
      if ( player.GetWeaponAtSlot(i) ) {
        pickup = CreatePickup(weaponModelIDs[ player.GetWeaponAtSlot(i) ],
                              player.World, weaponPickupAmmo[ player.GetWeaponAtSlot(i) ],
                              pos.x+xOffset, pos.y, pos.z+zOffset, 253, true);
        ++zOffset;
        if (!(zOffset %= 2)) {
          ++xOffset;
        }
        if ( pickup ) {
          droppedWeapons.rawset( pickup.ID, pickup);
        }
      }
    }
  }
}

function onPickupClaimPicked( player, pickup ) {
  if ( alive[player.ID] ) {
    droppedWeapons.rawdelete( pickup.ID );
    pickup.Remove();
    return 1;
  }
  return 0;
}
