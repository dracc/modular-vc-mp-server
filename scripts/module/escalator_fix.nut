// VC-MP attempts to keep players standing on objects.
// However, if a step of an escalator is warped for re-use, it basically takes
// the player with it, accelerating them to high speeds.
//
// This script creates step models which make it impossible for the player
// to stand on the real steps, thereby avoiding the issue.

function create_escalator_fix(world, p, a, count) {
  local m = 584;
  local l = 0.4;
  local x = -l * sin(a);
  local y =  l * cos(a);
  for(local i = 0; i < count; i++) {
    o <- CreateObject( m, world, p + Vector(x * i, y * i, 0.0), 255);
    o.RotateToEuler(Vector(0,0,a), 0);
  }
}

function create_double_escalator_fix(world, p, a, count, d) {
  create_escalator_fix(world, p, a, count);
  create_escalator_fix(world, p + Vector(d, 0.0, 0.0), a, count);
}

function create_double_stair_up_down_fix(world, p, a, d) {
  local d_level = 6.55; // up_level - down_level
  local d_forward = 11.65 + 0.75; // up_forward - down_forward

  local p1 = Vector(p.x, p.y, p.z);
  create_double_escalator_fix(world, p1, a, 2, d);

  local p2 = Vector(p.x - sin(a) * d_forward, p.y + cos(a) * d_forward, p.z + d_level);
  create_double_escalator_fix(world, p2, a + PI, 3, d);
}

function onScriptLoad() {

  local world = 0;
  local d = 1.924; // Distance between 2 escalators

  // North point mall, as seen on radar, when facing north:
  //
  // 1   2
  //   3
  //   4
  // 5   6
  //
  // Coordinates are supposed to reflect the bottom of the left side.
  //FIXME: Some hacks break this "bottom of the left side" assumption.

  local p1 = Vector(406.122 - 0.05, 1193.38, 17.9824);
  create_double_stair_up_down_fix(world, p1, 0.0, d);

  local p2 = Vector(419.754 - 0.1, 1193.32, 17.8704);
  create_double_stair_up_down_fix(world, p2, 0.0, d);

  local p3 = Vector(414.661 - 0.02, 1145.71, 17.4724 + 0.04);
  create_double_stair_up_down_fix(world, p3, PI, -d);

  local p4 = Vector(412.785 - 0.1 + 0.05 + d, 1102.65, 17.4724);
  create_double_stair_up_down_fix(world, p4, 0.0, -d);

  local p5 = Vector(408.213 - 0.1, 1058.5 - 0.02, 17.4724 + 0.71);
  create_double_stair_up_down_fix(world, p5, PI, -d);

  local p6 = Vector(421.778 - 0.05, 1058.52, 18.2419 - 0.25);
  create_double_stair_up_down_fix(world, p6, PI, -d);

  //FIXME: Airport also has escalators, but they are not broken.
  //       We can still fix them for visual consistency.

  // Washington mall also has escalators, but they are not broken.
  // They are also visually the best looking ones, as steps don't disappear.

}
