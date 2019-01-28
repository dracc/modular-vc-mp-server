//

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "color") {
    local v = player.Vehicle;
    if ( !v ) {
      MessagePlayer( "[#ff0000]You're not in any vehicle." ,player );
    } else if ( !text && !IsNum( text ) ) {
      MessagePlayer( "[#ff0000]Usage: /color <Colour1ID>" ,player );
    } else {
      v.Colour1 = text.tointeger();
    }
    //FIXME: Support colour 2
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/color", player);
  }
}
