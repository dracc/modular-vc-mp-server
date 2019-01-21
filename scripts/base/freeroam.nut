//

function onScriptLoad() {

  SetGameModeName("Freeroam");

  SetSpawnPlayerPos(-1348.37, -747.879, 24.896);
  SetSpawnCameraPos(-1325.37, -747.879, 24.896);
  SetSpawnCameraLook(-1348.37, -747.879, 24.896);

  AddClass(1, RGB(100,149,237),
	   66, // model
	   Vector(-421.729, -485.533, 11.0655),0, // position and angle [somewhere on starfish island]
	   0,0, // weapon 1
	   0,0, // weapon 2
	   0,0 // weapon 3
    );
  AddClass(1, RGB(237,100,149), 65, Vector(-420, -485.533, 11.0655),0, 0,0, 0,0, 0,0);
  
  SetVehiclesForcedRespawnHeight( 10000 );


  SetDrivebyEnabled( false );
  SetTaxiBoostJump( true );
  SetJumpSwitch( false );
  SetStuntBike( false );

  SetFrameLimiter(true);
}

function onPlayerJoin( player ) {
  MessagePlayer( "[#FF0000]Welcome to this VC-MP Freeroam Server. ", player );
  PrivMessage( player, "Have a look at /rules and /help before playing." );
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  switch ( cmd ) {
    case "rules": {
      Message( "No disturbing other's play. Kids only." );
      break;
    }
    default: {
      break;
    }
  }
}
