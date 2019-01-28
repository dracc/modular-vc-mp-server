function onScriptLoad() {
  SetGameModeName(GetGameModeName() + " (Debug)");
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "r" || cmd == "reload") {
    print("Reloading all scripts");
    Message("Reloading all scripts");

    collectgarbage();
    ReloadScripts();
  } else if (cmd == "pos") {
    print(player.Pos);
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/r[eload] /pos", player);
  }
}

