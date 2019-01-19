function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "g") {
    if(!text) {
      MessagePlayer( "Error - Correct syntax - /goto <Name/ID>' !",player );
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
  }
  return 1;
}
