function onPlayerChat( player, text ) {
  print(player.Name + ": " + text);
  return 1;
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "me") {
    Message("[#ffaabb]" + player.Name + " " + text);
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/me", player);
  }
}
