function onKeyDown( player, key ) {

//  if(player.Spawned) {
//    return;
//  }

  if ( key == BIND_SPEC_NEXT ) {
    if( player.SpectateTarget != null) {
      local pTargetID = player.SpectateTarget.ID;
      local pTargetFind = pTargetID + 1;
      local pNewTarget = null;

      while(pNewTarget == null && pTargetFind != pTargetID) {
        if(pTargetFind > GetMaxPlayers() - 1) {
          pTargetFind = 0;
        }

        pNewTarget = FindPlayer(pTargetFind++);
        if(pNewTarget != null && !pNewTarget.Spawned) {
          pNewTarget = null;
        }
      }

      if(pNewTarget == null || pNewTarget.ID == pTargetID) {
        ClientMessage( "[#ed4242]Error: [#e9e9e9]No one else can be spectated.",
		       player, 0, 0, 0 );
      } else {
        player.SpectateTarget = pNewTarget;
        local szMsg = "Spectating " + pNewTarget.Name + " (" + pNewTarget.ID + ")";
        MessagePlayer( szMsg, player );
      }
    }
    return;
  }

  if ( key == BIND_SPEC_PREV ) {
    if( player.SpectateTarget != null) {
      local pTargetID = player.SpectateTarget.ID;
      local pTargetFind = pTargetID - 1;
      local pNewTarget = null;

      while(pNewTarget == null && pTargetFind != pTargetID) {
        if(pTargetFind < 0) {
          pTargetFind = GetMaxPlayers() - 1;
        }

        pNewTarget = FindPlayer(pTargetFind--);
        if(pNewTarget != null && !pNewTarget.Spawned) {
          pNewTarget = null;
        }
      }

      if(pNewTarget == null || pNewTarget.ID == pTargetID) {
        ClientMessage( "[#ed4242]Error: [#e9e9e9]No one else can be spectated.",
		       player, 0, 0, 0 );
      } else {
        player.SpectateTarget = pNewTarget;
        local szMsg = "spectating " + pNewTarget.Name + " (" + pNewTarget.ID + ")";
        MessagePlayer( szMsg, player );
      }
    }
    return;
  }


  if ( key == BIND_SPEC_TOGGLE ) {

    if(player.SpectateTarget != null) {
      player.SpectateTarget = null;
    } else {
      local pTargetID = 0;
      local pNewTarget = null;

      while(pNewTarget == null && pTargetID < GetMaxPlayers()) {
        pNewTarget = FindPlayer(pTargetID++);

        if(pNewTarget != null && !pNewTarget.Spawned) {
          pNewTarget = null;
        }
      }

      if(pNewTarget == null) {
        ClientMessage( "[#ed4242]Error: [#e9e9e9]No one can be spectated at this time.",
		       player, 0, 0, 0 );
      } else {
        player.SpectateTarget = pNewTarget;
        local szMsg = "Spectating " + pNewTarget.Name + " (" + pNewTarget.ID + ")";
        MessagePlayer( szMsg, player );
      }
    }
    return;
  }

}


function onScriptLoad() {
  BIND_SPEC_TOGGLE      <- BindKey( true, 0x70, 0, 0 ); // F1
  BIND_SPEC_NEXT        <- BindKey( true, 0x27, 0, 0 ); // Right
  BIND_SPEC_PREV        <- BindKey( true, 0x25, 0, 0 ); // Left
}
