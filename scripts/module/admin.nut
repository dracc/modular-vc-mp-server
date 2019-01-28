//


function NumTok(string, separator) {
  local tokenized = split(string, separator);
  return tokenized.len();
}

function GetTok(string, separator, n, ...) {
  local m = vargv.len() > 0 ? vargv[0] : n,
    tokenized = split(string, separator),
    text = "";

  if (n > tokenized.len() || n < 1) {
    return null;
  }
  for (; n <= m; n++) {
    text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
  }
  return text;
}


function onPlayerCommand( player, cmd, text ) {

  cmd = cmd.tolower();
  //FIXME: Top security brah
  if (cmd == "secret") {
    player.Admin = 1;
    PrivMessage( player, "/delplayerveh /delallveh /time /setf3" +
                 " /weather /explode /ann /get /kick" );
  }

/*
  case "delete_all":
    for( local i=0; i < 500; i++ ) {
      local v = FindVehicle( i );
      if ( v ) {
        v.Delete();
        owner[ i ] = null;
      }
    }
    Message( "[#ff0000]Admin " + player.Name + " deleted all vehicles!");
  }
  break;
*/

  if (!player.Admin) {
    return;
  }

  if (cmd == "time") {
    if ( text && IsNum( text ) ) {
      local w = GetWeather();
      SetTime( text.tointeger(), 0 );
      SetWeather(w);
    } else {
      MessagePlayer( "Usage: /" + lcmd + " <int>", player );
    }
  } else if (cmd == "weather") {
    if ( text && IsNum( text ) ) {
      SetWeather( text.tointeger() );
      AdminMessage( player.Name + " set weather id to " + text.tointeger() );
    } else {
      MessagePlayer( "Usage: /" + lcmd + " <int>", player );
    }
  } else if (cmd == "kick") {
    if ( text  ) {
      local id = GetTok( text, " ", 1 );
      if (IsNum( id )) {
        id = id.tointeger();
      }
      local plr = FindPlayer( id );
      if ( plr ) {
        local reason = GetTok( text, " ", 2 NumTok( text, " " ) );
        local msg = "[#FF0000]Admin " + player.Name + " kicked " + plr.Name;
        if ( reason ) {
          msg += " for reason: " + reason;
        }
        Message( msg );  
        KickPlayer( plr );
      }
    } else {
      MessagePlayer( "Usage: /kick <player> [reason]", player );
    }
  } else if (cmd == "help") {
    MessagePlayer("[#80A0A0]/time /weather /kick", player);
  }
}


function AdminMessage( text ) {
  local plr;
  for( local i=0; i<100; i ++ ) {
    plr = FindPlayer( i );
    if ( plr && plr.Admin ) {
      MessagePlayer( "[#FF0000][Admin] [#8888ff]" + text, plr );
      PlaySoundForWorld( plr.UniqueWorld, 50002 );
    }
  }
}
