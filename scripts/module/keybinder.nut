function sendKeyData( player, key, cmd ) {
      Stream.StartWrite();
      Stream.WriteInt(418);
      Stream.WriteInt(key);
      Stream.WriteString(cmd);
      Stream.SendStream(player);
}

keys <- {
  "backspace" : 0x08,
  "return" : 0x0D,
  "lshift" : 0xA0,
  "rshift" : 0xA1,
  "lctrl" : 0xA2,
  "rctrl" : 0xA3
};

function onScriptLoad() {
  db <- ConnectSQL("scripts/keybinds.db");
  if (!db) {
    print("ERROR: SQLite database file could not be opened");
  }
  QuerySQL(db, "CREATE TABLE IF NOT EXISTS keybinds(name TEXT, key INTEGER, " +
           "cmd TEXT, PRIMARY KEY(name,key));");
  local i;
  for(i = 0; i < 10; ++i) {
    keys[format("%i", i)] <- 0x30 + i;
    keys[format("num%i", i)] <- 0x60 + i;
  }
  for(i = 0; i < 26; ++i) {
    keys[(97 + i).tochar()] <- 0x41 + i;
  }
  for(i = 1; i < 13; ++i) {
    keys[format("f%i", i)] <- 0x6F + i;
  }
}

function partition( input, separator ) {
  local ret = array(2, null);
  local firstSpace = input.find(separator);
  if (!firstSpace) {
    firstSpace = input.len();
  } else {
    ret[1] = input.slice(firstSpace+1);
  }
  ret[0] = input.slice(0, firstSpace);
  return ret;
}

function onPlayerCommand( player, cmd, text ) {
  cmd = cmd.tolower();
  if (cmd == "bind") {
    if (!text) {
      local currbinds = "Current binds: \n";
      local q = QuerySQL(db, "SELECT key, cmd FROM keybinds WHERE name = '" +
                         player.Name + "';");
      if (q) {
        do {
          currbinds += "'" + GetSQLColumnData(q, 0) + "': '" +
            GetSQLColumnData(q, 1) + "'\n";
        } while (GetSQLNextRow(q));
      }
      FreeSQLQuery(q);
      MessagePlayer(currbinds + "Usage:\n" +
                    "Bind key: /" + cmd + " <key> <command>\n" +
                    "Unbind:   /" + cmd + " <key>\n" +
                    "Get help: /" + cmd, player);
      return;
    }
    text = text.tolower();
    local argArray = partition(text, " ");
    local key = argArray[0];
    if (key in keys) {
      key = keys[key];
    } else if (IsNum(key)) {
      key = key.tointeger();
    } else {
      MessagePlayer("Invalid key!", player);
      return;
    }
    if (argArray[1] && argArray[1] != "") {
      QuerySQL(db, "REPLACE INTO keybinds(name, key, cmd) VALUES ('" +
        player.Name + "'," + key + ",'" + argArray[1]+ "');");
      sendKeyData(player, key, argArray[1]);
    } else {
      QuerySQL(db, "DELETE FROM keybinds WHERE name = '" + player.Name +
               "' AND key = " + key + ";");
      sendKeyData(player, key, "null");
    }
  } else if (cmd == "help") {
    MessagePlayer("[#8080A0]/bind", player);
  }
}

function onPlayerJoin( player ) {
  local q = QuerySQL(db, "SELECT key, cmd FROM keybinds WHERE name = '" +
                     player.Name + "'");
  if (q) {
    do {
      sendKeyData(player, GetSQLColumnData(q, 0), GetSQLColumnData(q, 1));
    } while (GetSQLNextRow(q));
  }
  FreeSQLQuery(q);
}

function onClientScriptData( player ) {
  local type = Stream.ReadInt();
  if (type == 451) {
    local cmdstring = Stream.ReadString();
    if (cmdstring && cmdstring != "") {
      local cmdArray = partition(cmdstring, " ");
      getroottable()["onPlayerCommand"].call(this, player, cmdArray[0],
                                             cmdArray[1]);
    }
  } else {
    print("Unknown scriptdata type " + type + " received.");
  }
  return 1;
}
