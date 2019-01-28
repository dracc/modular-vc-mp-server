teleporters <- {
  "bank": Vector( -873.3062, -340.7981, 11.1026 ),
  "hotring": Vector( -1409.717, 1144.97, 267.3857 ),
  "dirtring": Vector( -1331.994, 1454.152, 299.15 ),
  "bloodring": Vector(  -1280.96, 994.86, 262.8 ),
  "hz": Vector( -376.7852, -521.1617, 12.7663 ),
  "jd": Vector( 232.2453, -1279.0906, 12.0712 ),
  "cc": Vector( -657.2713, -1478.9364, 13.8016 ),
  "gd": Vector( 335.7215,-233.5262,31.1983 ),
  "jcj": Vector( -658.3732,761.5365,11.5527 ),
  "jy": Vector( -1718.5946, -280.8699, 14.8683 ),
  "dyy": Vector( 7.0703, 964.4935, 10.4632 ),
  "y": Vector( 557.677, -886.057, 432.612 ) };

function teleport(player, location) {
  location = location.tolower();
  if (location in teleporters) {
    TeleportPlayer(player, teleporters[location], 0);
    return true;
  }
  return false;
}


function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "t" || cmd == "teleport") {
    if(text) {
      if (!teleport(player, text)) {
	local message = "";
	foreach(location, position in teleporters) {
	  message += " " + location;
	}
	MessagePlayer("[#ff0000][Error] - Bad location. Try" + message, player);
      }
    } else {
      MessagePlayer("Usage: /" + cmd + " <string>", player);
    }
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/t[eleport]", player);
  }
  return 1;
}
