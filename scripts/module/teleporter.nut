teleporters <- {}
teleporters["bank"] <- Vector( -873.3062, -340.7981, 11.1026 );
teleporters["hotring"] <- Vector( -1409.717, 1144.97, 267.3857 );
teleporters["dirtring"] <- Vector( -1331.994, 1454.152, 299.15 );
teleporters["bloodring"] <- Vector(  -1280.96, 994.86, 262.8 );
teleporters["hz"] <- Vector( -376.7852, -521.1617, 12.7663 );
teleporters["jd"] <- Vector( 232.2453, -1279.0906, 12.0712 );
teleporters["cc"] <- Vector( -657.2713, -1478.9364, 13.8016 );
teleporters["gd"] <- Vector( 335.7215,-233.5262,31.1983 );
teleporters["jcj"] <- Vector( -658.3732,761.5365,11.5527 );
teleporters["jy"] <- Vector( -1718.5946, -280.8699, 14.8683 );
teleporters["dyy"] <- Vector( 7.0703, 964.4935, 10.4632 );
teleporters["y"] <- Vector( 557.677, -886.057, 432.612 );

function lookup_location(location) {
  local result = false;
  local location = location.tolower();

  if (location in teleporters) {
    return teleporters[location];
  }

  return result;
}

function teleport(player, location) {
  local pos = lookup_location(location);
  if (pos == false) {
    return false;
  }
  TeleportPlayer(player, pos, 0);
  return true;
}


function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "t") {
    if (!teleport(player, text)) {
      local message = "";
      foreach(location, position in teleporters) {
        message += " " + location;
      }
      MessagePlayer("[#ff0000][Error] - Bad location. Try" + message, player);
    }
  }
  return 1;
}
