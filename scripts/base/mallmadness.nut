//

skinIDs <- [  9, 10, 11, 15, 16,
             26, 30, 31, 32, 33,
             34, 42, 44, 45, 50,
             71, 72, 139 ];

function createClasses() {
  local team = 0;
  foreach (id in skinIDs) {
    AddClass(team++, RGB(100,149,237), id, Vector(460, 1150, 35), 0,
             (team % 6) + 3, 1, 21, 20, 23, 90);
  }
}

function onScriptLoad() {
  SetGameModeName("Mall Madness");
  createClasses();
  SetVehiclesForcedRespawnHeight( 10000 );
  SetFrameLimiter(true);

  SetSpawnPlayerPos(460, 1150, 35);
  SetSpawnCameraPos(460, 1155, 38);
  SetSpawnCameraLook(460, 1150, 35);
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
