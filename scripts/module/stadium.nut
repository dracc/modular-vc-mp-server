// Stadium billboards

billboard <- null;

function SetStadiumBillboard(index) {
  if ( billboard ) {
    billboard.Delete();
  }
  if (index >= 0 && index <= 2) {
    billboard <- CreateObject(2042 + index, 1, -1037.08, 1340.258, 36.552, 255);
  }
}

function onScriptLoad() {
  SetStadiumBillboard(0);
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (! player.Admin ) {
    return;
  }
  if (cmd == "setstadiumbillboard") {
    if ( text ) {
      local arg = null;
      if (IsNum(text)){
        arg = text.tointeger();
      }
      if (arg >= 0 && arg <= 2) {
        SetStadiumBillboard(arg);
        MessagePlayer("Changed to stadium billboard offset " + arg, player);
      } else if (arg == -1) {
        SetStadiumBillboard(arg);
        MessagePlayer("The stadium billboards have been removed", player);
      } else {
        MessagePlayer("[#FF0000]Error: Billboard index out of range ([-1,2])", player);
      }
    }
  } else if (cmd == "help") {
    MessagePlayer("[#80A0A0]/ssb /setstadiumbillboard", player);
  }
}
