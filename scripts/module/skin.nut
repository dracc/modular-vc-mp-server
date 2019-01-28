//FIXME: Make skin sticky

skins <- array( 100, null);

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if(cmd == "skin") {
    if (!text) {
      return;
    }
    
    local id;
    if (IsNum(text)) {
      id = text.tointeger();
    } else {
      //FIXME: Search skin id by name
      return;
    }
    player.Skin = id;
    skins[player.ID] = id;
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/skin", player);
  }
}

function onPlayerSpawn( player ) {
  if (skins[player.ID] != null) {
    player.Skin = skins[player.ID];
  }
}

function onPlayerPart( player, reason ) {
  skins[player.ID] = null;
}
