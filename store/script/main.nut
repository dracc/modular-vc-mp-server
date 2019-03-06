binds <- {};

function Script::ScriptLoad() {
}

function Server::ServerData( stream ) {
  // Identitifier token, 418 selected because of HTTP error code
  // 418 - I'm a teapot
  // as defined in RFC2324
  local type = stream.ReadInt();

  if (type == 418) {
    local keyID = stream.ReadInt();
    local cmd = stream.ReadString();
    if (cmd == "null") {
      binds.rawdelete(KeyBind(keyID));
      return;
    }
    binds[KeyBind(keyID)] <- cmd;
  } else {
    Console.Print("Received some unknown data stream");
  }
}

function KeyBind::OnDown( keyBind ) {
  if (keyBind in binds) {
    local message = Stream();
    // 451 - Unavailable for legal reasons
    message.WriteInt(451);
    message.WriteString(binds[keyBind]);
    Server.SendData(message);
  }
}
