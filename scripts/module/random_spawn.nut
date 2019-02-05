spawns <- [Vector(459.92, 1005.26, 19.1811),
           Vector(456.142, 1090.34, 18.6455),
           Vector(453.955, 1102.85, 19.2268),
           Vector(362.586, 1060.88, 19.1874),
           Vector(464.045, 1202.4, 19.0113),
           Vector(428.258, 1224.51, 25.3848),
           Vector(373.796, 1244.51, 25.6426),
           Vector(356.106, 1111.4, 25.3876),
           Vector(414.485, 1138.62, 22.7296),
           Vector(431.755, 1078.82, 19.0915)];

function onPlayerSpawn( player ) {
  local pos = spawns[rand() % spawns.len()];
  TeleportPlayer(player, pos, 0);
}
