//


function NumTok(string, separator) {
    local tokenized = split(string, separator);
    return tokenized.len();
}

function GetTok(string, separator, n, ...) {
    local m = vargv.len() > 0 ? vargv[0] : n,
          tokenized = split(string, separator),
          text = "";
    
    if (n > tokenized.len() || n < 1) return null;
    for (; n <= m; n++)
    {
        text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
    }
    return text;
}


function onPlayerCommand( player, cmd, text ) {

  local lcmd = cmd.tolower()

  switch ( lcmd )
  {
    //FIXME: Top security brah
    case "secret": {
      player.Admin = 1;
      PrivMessage( player, "/delplayerveh /delallveh /settime /setf3 /setweather /explode /ann /get /goto /kick" );
      break;
    }
    default: {
      break;
    }
  }

  /*
    case "delete_all":
    {
        {
            for( local i=0; i < 500; i++ )
            {
                local v = FindVehicle( i );
                if ( v ) 
                {
                    v.Delete();
                    owner[ i ] = null;
                }
            }
            Message( "[#ff0000]Admin " + player.Name + " deleted all vehicles!");
        }
        break;
    }
  */

  if (!player.Admin) {
    return;
  }

  switch ( lcmd ) {

    case "time": {
      if ( text && IsNum( text ) ) {
        local w = GetWeather();
        SetTime( text.tointeger(), 0 );
        SetWeather(w);
      }
    }
    case "weather": {
      if ( text && IsNum( text ) ) {
          SetWeather( text.tointeger() );
          AdminMessage( player.Name + " set weather id to " + text.tointeger() );
      }
      break;
    }

    case "kick": {
      if ( text  ) {
        local id = GetTok( text, " ", 1 )
        if (IsNum( id )) {
          id = id.tointeger()
        }
        local plr = FindPlayer( id );
        if ( plr ) {
          local reason = GetTok( text, " ", 2 NumTok( text, " " ) );
          MessagePlayer( "wth...." + reason, player );
          if ( reason ) {
            Message( "[#FF0000]Admin " + player.Name + " kicked " + plr.Name + " for reason: " + reason );
            KickPlayer( plr );
          }
        }
      } else {
        MessagePlayer( "Usage: /kick <player> <reason>", player );
      }
      break;
    }        

    default: {
      break;
    }
  }
}


function AdminMessage( text ) {
    local plr;
    for( local i=0; i<100; i ++ )
    {
        plr = FindPlayer( i );
        if ( plr && plr.Admin ) MessagePlayer( "[#FF0000][Admin] [#8888ff]" + text, plr ), PlaySoundForWorld( plr.UniqueWorld, 50002 );;
    }
}




