//

function onScriptLoad() {

  SetGameModeName("Freeroam");

  AddClass(1, RGB(100,149,237),
	   2, // model
	   Vector(-421.729, -485.533, 11.0655),0, // position and angle [somewhere on starfish island]
	   0,0, // weapon 1
	   0,0, // weapon 2
	   0,0 // weapon 3
    );

  SetVehiclesForcedRespawnHeight( 10000 );


  SetDrivebyEnabled( false );
  SetTaxiBoostJump( true );
  SetJumpSwitch( false );
  SetStuntBike( false );
  SetHeliBladeDamageDisabled( true );
  SetFrameLimiter( true );
}

function onPlayerJoin( player ) {
  MessagePlayer( "[#FF0000]Welcome to this VC-MP Freeroam Server. ", player );
  PrivMessage( player, "Have a look at /rules and /help before playing." );
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "rules") {
    Message( "No disturbing other's play. Kids only." );
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/rules /help", player);
  }
}
