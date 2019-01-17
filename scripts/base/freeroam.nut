function CVehicle::GetRadiansAngle() {
    local angle = ::asin( this.Rotation.z ) * -2;
    return this.Rotation.w < 0 ? 3.14159 - angle : 6.28319 - angle;
}



function onScriptLoad() {

  SetGameModeName("Freeroam")

  BIND_F2 <- BindKey(true,113,0,0);
  BIND_F3 <- BindKey(true,114,0,0);
  BIND_F4 <- BindKey(true,115,0,0);
  
  HYPER_DOWN  <- BindKey( true, 69, 0, 0 );//H
  HYPER_UP    <- BindKey( true, 81, 0, 0 );//F
  HYPER_FORWARD  <- BindKey( true, 73, 0, 0 );//|
  HYPER_BACK <- BindKey( true, 75, 0, 0 );//|
  HYPER_LEFT  <- BindKey( true, 74, 0, 0 );//<
  HYPER_RIGHT <- BindKey( true, 76, 0, 0 );//>
  
  AddClass(1, RGB(100,149,237),
    2, // model
    Vector(-421.729, -485.533, 11.0655),0, // position and angle [somewhere on starfish island]
    0,0, // weapon 1
    0,0, // weapon 2
    0,0 // weapon 3
  );
  
  hyper <- array( 100, false );

  SetVehiclesForcedRespawnHeight( 10000 );


  SetDrivebyEnabled( false );
  SetTaxiBoostJump( true );
  SetJumpSwitch( false );
  SetStuntBike( false );

  SetFrameLimiter(true);
}

function onPlayerJoin( player ) {
  MessagePlayer( "[#FF0000]Welcome to VC:MP Stunting Server. ", player );
  PrivMessage( player, "Have a look at /rules and /help before playing." );
}
 
function onKeyDown(player, id) {
  
    
    if ( hyper[ player.ID ] )
    {
        if (id == HYPER_UP) player.Pos.z += 15;
        else if (id == HYPER_DOWN) player.Pos.z -= 15;
        else 
        {
            local rad = player.Angle, pos = player.Pos;
            if (id == HYPER_FORWARD);
            else if (id == HYPER_BACK) rad -= 3.14;
            else if (id == HYPER_LEFT) rad += 1.570795;
            else if (id == HYPER_RIGHT) rad -= 1.570795; 
            else return 0;
            local x = pos.x, y = pos.y;
            local x2 = x + 1.0 * cos(rad) - 15.0 * sin(rad);
            local y2 = y + 1.0 * sin(rad) + 15.0 * cos(rad);
            player.Pos = Vector( x2, y2, pos.z );
        }
    }
}

function onPlayerCommand( player, cmd, text ) {
    cmd = cmd.tolower();
    switch ( cmd ) {
        case "help": case "cmds":
        {
            PrivMessage( player, "/help /hyper /skin /v[ehicle] /rules /delete /goto /col" );
            break;
        }

        case "rules":
        {
            Message( "No disturbing other's play. Kids only." );
            break;
        }

        case "hyper":
        {
            if ( hyper[player.ID] )
            {
                MessagePlayer( "[#00ff00]Hyper key removed." ,player );
                hyper[player.ID] = false;
            }
            else 
            {
                hyper[player.ID] = true;
                MessagePlayer( "[#00ff00]Hyper key added, you can now use i, k, j, l, q, e to move around. \nI - Fly ahead, K - Fly back\nQ - Fly over, E - Fly down\nJ - Fly to your left, L - Fly to your right" ,player );
            }
            break;
        }
        
        //FIXME: Group these 2
        case "color":
        {
            local v = player.Vehicle;
            if ( !v ) MessagePlayer( "[#ff0000]You're not in any vehicle." ,player );
            else if ( !text && !IsNum( text ) ) MessagePlayer( "[#ff0000]Usage: /color <Colour1ID>" ,player );
            else v.Colour1 = text.tointeger();
            //FIXME: Support colour 2
            break;
        }




        default: {
          break;
        }            
    }
}

