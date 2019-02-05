// No, these should not be in strict numerical order.
weaponModelIDs <- [293, 259, 260, 261, 262, 263, 264, 265, 266, 267,
                   268, 269, 270, 291, 271, 272, 273, 274, 275, 277,
                   278, 279, 281, 282, 283, 284, 280, 276, 285, 286,
                   287, 288, 289, 290];

alive <- array(100, null);
droppedWeapons <- {};

function onPlayerSpawn( player ) {
  alive[player.ID] = true;
}

function onPlayerPart( player, reason ) {
  alive[player.ID] = null;
}

function onPlayerHealthChange( player, lastHP, newHP ) {
  if ( newHP < 0.1 && alive[player.ID]) {
    alive[player.ID] = false;
    local pos = player.Pos;
    local xOffset = 0;
    local zOffset = 0;
    local pickup = null;
    for (local i = 0; i <= 8; ++i) {
      if ( player.GetWeaponAtSlot(i) ) {
        pickup = CreatePickup(weaponModelIDs[ player.GetWeaponAtSlot(i) ],
                              player.World, player.GetAmmoAtSlot(i),
                              pos.x+xOffset, pos.y, pos.z+zOffset, 255, true);
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
