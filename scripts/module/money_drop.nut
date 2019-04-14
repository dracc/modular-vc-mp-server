alive <- array(100, null);
MoneyPickups <- {};

function onPlayerSpawn( player ) {
  alive[player.ID] = true;
  player.Cash = 500;
}

function onPlayerPart( player, reason ) {
  alive[player.ID] = null;
}

function onPlayerHealthChange( player, lastHP, newHP ) {
  if ( newHP < 1e-6 && alive[player.ID]) {
    alive[player.ID] = false;
    local pickup = CreatePickup( 337, player.World, player.Cash * 0.8, player.Position, 255, true);
    if ( pickup ) {
      MoneyPickups.rawset( pickup.ID, pickup);
    }
  }
}

function onPickupClaimPicked( player, pickup ) {
  if ( alive[player.ID] && pickup.ID in MoneyPickups ) {
    MoneyPickups.rawdelete( pickup.ID );
    pickup.Remove();
    return 1;
  }
  return 0;
}
