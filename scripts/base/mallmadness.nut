//

function onScriptLoad() {

  SetGameModeName("Mall Madness");

  AddClass(1, RGB(100,149,237), 64, Vector(-421.729, -485.533, 11.0655), 0,
           6,1, 19,20, 23,90);
  AddClass(2, RGB(100,149,237), 65, Vector(-421.729, -485.533, 11.0655), 0,
           3,1, 19,20, 24,90);
  AddClass(3, RGB(100,149,237), 66, Vector(-421.729, -485.533, 11.0655), 0,
           8,1, 20,15, 23,90);
  AddClass(4, RGB(100,149,237), 37, Vector(-421.729, -485.533, 11.0655), 0,
           9,1, 19,20, 22,90);

  SetVehiclesForcedRespawnHeight( 10000 );

  SetFrameLimiter(true);
}

function onPlayerJoin( player ) {
  MessagePlayer( "[#FF0000]Welcome to this VC-MP Mall Madness Server. ", player );
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
