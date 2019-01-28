emotes <- {
  "stop" : [0, 29],
  "whatcha" : [0, 7],
  "lean" : [0, 9],
  "talk" : [0, 11],
  "wave" : [0, 12],
  "die" : [0, 17],
  "die 2" : [0, 13],
  "fall" : [0, 25],
  "fall 2" : [0,37],
  "fallback" : [0, 27],
  "fallback 2" : [0, 43],
  "oo" : [0, 44],
  "apply" : [0, 62],
  "bu!" : [0, 67],
  "arg" : [0, 112],
  "arg 2" : [0, 113],
  "carwback" : [0, 114],
  "wback" : [0, 118],
  "elbow" : [0, 123],
  "elbow 2" : [0, 124],
  "rollback" : [0, 126],
  "boss" : [0, 130],
  "crawling" : [0, 133],
  "rollinfront" : [0, 135],
  "falling" : [0, 144],
  "roll" : [0, 147],
  "beware" : [0,151],
  "idk" : [0, 152],
  "look" : [0, 153],
  "dumb" : [0, 154],
  "aim" : [0, 155],
  "aim 2" : [0, 157],
  "aim 3" : [0, 160],
  "drown" : [0, 156],
  "handsup" : [0, 161],
  "wut" : [0, 162],
  "fu" : [0, 163],
  "phone" : [0, 166],
  "sit" : [0, 169],
  "stand" : [0, 168],
  "sell" : [0, 171],
  "hm?" : [0, 172],
  "onfoot" : [3, 192],
  "db" : [3, 201],
  "db 2" : [3, 202],
  "db 3" : [3, 203],
  "heal" : [24, 214],
  "lay" : [25, 210],
  "bored" : [26, 215],
  "bored 2" : [26, 216],
  "bored 3" : [26, 217],
  "bored 4" : [26, 218],
  "riot" : [27, 219],
  "riot 2" : [27, 220],
  "riot 3" : [27, 221],
  "riot 4" : [27, 222],
  "riot 5" : [27, 223],
  "riot 6" : [27, 224],
  "riot 7" : [27, 225],
  "dance" : [28, 226],
  "dance 2" : [28, 227],
  "dance 3" : [28, 228],
  "dance 4" : [28, 229],
  "dance 5" : [28, 230],
  "dance 6" : [28, 231],
  "dance 7" : [28, 232],
  "drunk" : [29, 210]
};
    
function onPlayerCommand(player, cmd, text) {
  if ( player.Vehicle ) {
    return;
  }
  cmd = cmd.tolower();
  if (cmd == "e") {
    if(text in emotes) {
      local emote = emotes[text];
      player.SetAnim(emote[0], emote[1]);
      return;
    }
    
    local message = "[#6666FF]Anims' list: [#FFFF81](/e) ";
    foreach(anim, index in emotes) {
      message += anim + ", ";
    }
    MessagePlayer(message, player);
    return;
  } else if (cmd == "help") {
    MessagePlayer("[#333380]/e", player);
  }
}
