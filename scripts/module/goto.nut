function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "g" || cmd == "goto") {
    if(!text) {
      MessagePlayer( "Error - Incorrect syntax - /" + cmd +  "<Name/ID>' !",player );
    } else {
      local plr = FindPlayer(text);
      if(!plr) {
        MessagePlayer( "Error - Unknown player !",player);
      } else {
        local pos = GetForwardPoint(plr.Pos, plr.Angle, -10.0);
        TeleportPlayer(player, pos, plr.Angle);
	MessagePlayer( "[ /" + cmd + " ] " + player.Name + " was sent to " + plr.Name, player );
      }
    }
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/g[oto]", player);
  }
  return 1;
}
