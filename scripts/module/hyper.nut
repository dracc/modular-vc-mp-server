// Untested / unused

function onScriptLoad() {

  HYPER_DOWN    <- BindKey( true, 0x45, 0, 0 ); // E
  HYPER_UP      <- BindKey( true, 0x51, 0, 0 ); // Q
  HYPER_FORWARD <- BindKey( true, 0x49, 0, 0 ); // I
  HYPER_BACK    <- BindKey( true, 0x4B, 0, 0 ); // K
  HYPER_LEFT    <- BindKey( true, 0x4A, 0, 0 ); // J
  HYPER_RIGHT   <- BindKey( true, 0x4C, 0, 0 ); // L

  hyper <- array( 100, false );
}


function onKeyDown(player, id) {
  if ( hyper[ player.ID ] ) {
    if (id == HYPER_UP) {
      player.Pos.z += 15;
    } else if (id == HYPER_DOWN) {
      player.Pos.z -= 15;
    } else {
      local rad = player.Angle, pos = player.Pos;
      if (id == HYPER_FORWARD) {
      } else if (id == HYPER_BACK) {
	rad -= 3.14;
      } else if (id == HYPER_LEFT) {
	rad += 1.570795;
      } else if (id == HYPER_RIGHT) {
	rad -= 1.570795;
      } else {
	return 0;
      }
      local x = pos.x, y = pos.y;
      local x2 = x + 1.0 * cos(rad) - 15.0 * sin(rad);
      local y2 = y + 1.0 * sin(rad) + 15.0 * cos(rad);
      player.Pos = Vector( x2, y2, pos.z );
    }
  }
}


function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if ( cmd == "hyper") {
    if ( hyper[player.ID] ) {
      MessagePlayer( "[#00ff00]Hyper key removed." ,player );
      hyper[player.ID] = false;
    } else {
      hyper[player.ID] = true;
      MessagePlayer( "[#00ff00]Hyper key added, you can now use i, k, j, l, q, e to move around." +
		     "\nI - Fly ahead, K - Fly back\nQ - Fly over, E - Fly down" +
		     "\nJ - Fly to your left, L - Fly to your right" ,player );
    }
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/hyper", player);
  }
}
