//

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "color") {
    local v = player.Vehicle;
    if ( !v ) {
      MessagePlayer( "[#ff0000]You're not in any vehicle." ,player );
      return 1;
    }
    if ( text ) {
      local args = split(text, " ");
      if (IsNum(args[0])) {
        local col2 = args[0].tointeger();
        v.Colour1 = col2;
        if (args.len() >= 2 && IsNum(args[1])) {
          col2 = args[1].tointeger();
        }
        v.Colour2 = col2;
        return 1;
      }
    }
    MessagePlayer( "[#ff0000]Usage: /" + cmd + " <Color-ID>, /" + cmd +
                   " <Color-ID> <Color-ID>", player );
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/color", player);
  }
}
