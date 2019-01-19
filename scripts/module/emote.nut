function onPlayerCommand(player, cmd, text) {
  cmd = cmd.tolower();
  if (cmd == "e") {
    if(!text) {
      MessagePlayer("[#6666FF]Anims' list: [#FFFF81](/a) stop, watcha, lean, " +
		    "talk, wave, die^, fall^, fallback^, :o, apply, bu!, arg^" +
		    ", carwback, wback, elbow^, rollback, boss, crawling," +
		    "rollinfront, falling, roll, beware, idk, look, dumb," +
		    "aim^, drown, handsup, wut, fu, phone, sit, stand, sell," +
		    "hm?, onfoot, db^, heal, lay, bored, riot, dance, drunk",
		    player);
      MessagePlayer("[#6666FF]READ ME -> The symbol ^ means the anim has more options." +
		    "Example: /a dance, /a dance 2, /a dance 3.",player);
      return;
    }

    if ( player.Vehicle ) {
      return;
    }

    switch(text) {
    case "stop":
      player.SetAnim(0,29);
      break;
    case "watcha":
      player.SetAnim(0,7);
      break;
    case "lean":
      player.SetAnim(0,9);
      break;
    case "talk":
      player.SetAnim(0,11);
      break;
    case "wave":
      player.SetAnim(0,12);
      break;
    case "die":
      player.SetAnim(0,17);
      break;
    case "die 2":
      player.SetAnim(0,13);
      break;
    case "fall":
      player.SetAnim(0,25);
      break;
    case "fall 2":
      player.SetAnim(0,37);
      break;
    case "fallback":
      player.SetAnim(0,27);
      break;
    case "fallback 2":
      player.SetAnim(0,43);
      break;
    case "oo":
      player.SetAnim(0,44);
      break;
    case "apply":
      player.SetAnim(0,62);
      break;
    case "bu!":
      player.SetAnim(0,67);
      break;
    case "arg":
      player.SetAnim(0,112);
      break;
    case "arg 2":
      player.SetAnim(0,113);
      break;
    case "carwback":
      player.SetAnim(0,114);
      break;
    case "wback":
      player.SetAnim(0,118);
      break;
    case "elbow":
      player.SetAnim(0,123);
      break;
    case "elbow 2":
      player.SetAnim(0,124);
      break;
    case "rollback":
      player.SetAnim(0,126);
      break;
    case "boss":
      player.SetAnim(0,130);
      break;
    case "crawling":
      player.SetAnim(0,133);
      break;
    case "rollinfront":
      player.SetAnim(0,135);
      break;
    case "falling":
      player.SetAnim(0,144);
      break;
    case "roll":
      player.SetAnim(0,147);
      break;
    case "beware":
      player.SetAnim(0,151);
      break;
    case "idk":
      player.SetAnim(0,152);
      break;
    case "look":
      player.SetAnim(0,153);
      break;
    case "dumb":				
      player.SetAnim(0,154);
      break;
    case "aim":
      player.SetAnim(0,155);
      break;
    case "aim 2":
      player.SetAnim(0,157);
      break;
    case "aim 3":
      player.SetAnim(0,160);
      break;
    case "drown":
      player.SetAnim(0,156);
      break;
    case "handsup":
      player.SetAnim(0,161);
      break;
    case "wut":
      player.SetAnim(0,162);
      break;
    case "fu":
      player.SetAnim(0,163);
      break;
    case "phone":
      player.SetAnim(0,166);
      break;
    case "sit":
      player.SetAnim(0,169);
      break;
    case "stand":
      player.SetAnim(0,168);
      break;
    case "sell":
      player.SetAnim(0,171);
      break;
    case "hm?":
      player.SetAnim(0,172);
      break;
    case "onfoot":
      player.SetAnim(3,192);
      break;
    case "db":
      player.SetAnim(3,201);
      break;
    case "db 2":
      player.SetAnim(3,202);
      break;
    case "db 3":
      player.SetAnim(3,203);
      break;
    case "heal":
      player.SetAnim(24,214);
      break;
    case "lay":
      player.SetAnim(25,210);
      break;
    case "bored":
      player.SetAnim(26,215);
      break;
    case "bored 2":
      player.SetAnim(26,216);
      break;
    case "bored 3":
      player.SetAnim(26,217);
      break;
    case "bored 4":
      player.SetAnim(26,218);
      break;
    case "riot":
      player.SetAnim(27,219);
      break;
    case "riot 2":
      player.SetAnim(27,220);
      break;
    case "riot 3":
      player.SetAnim(27,221);
      break;
    case "riot 4":
      player.SetAnim(27,222);
      break;
    case "riot 5":
      player.SetAnim(27,223);
      break;
    case "riot 6":
      player.SetAnim(27,224);
      break;
    case "riot 7":
      player.SetAnim(27,225);
      break;
    case "dance":
      player.SetAnim(28,226);
      break;
    case "dance 2":
      player.SetAnim(28,227);
      break;
    case "dance 3":
      player.SetAnim(28,228);
      break;
    case "dance 4":
      player.SetAnim(28,229);
      break;
    case "dance 5":
      player.SetAnim(28,230);
      break;
    case "dance 6":
      player.SetAnim(28,231);
      break;
    case "dance 7":
      player.SetAnim(28,232);
      break;
    case "drunk":
      player.SetAnim(29,210);
      break;
    default:
      MessagePlayer("This animation doesn't exist. Type '/a' to see the list !",player);
    }
  }
}
