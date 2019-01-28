function onScriptLoad() {
  SetGameModeName(GetGameModeName() + " (Debug)");
}

function onPlayerCommand( player, cmd, text ) {
  if (cmd.tolower() == "r") {
    print("Reloading all scripts");
    Message("Reloading all scripts");

    collectgarbage();
    ReloadScripts();
  } else if (cmd.tolower() == "pos") {
    print(player.Pos);
  } else if (cmd.tolower() == "help") {
    MessagePlayer("[#333380]/r /pos", player);
  }
}

