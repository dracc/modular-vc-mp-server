LocsLike03 <- [
 [ Vector(-557.433,782.167,22.8768), Vector( -555.477, 788.2, 97.5104 )], // To Office Buliding Lift(UP)
 [ Vector(-551.781,787.953,97.5104), Vector( -562.089, 782.275, 22.8768 )], // To Office Buliding Lift(DOWN)
 [ Vector(142.726,-1372.82,10.432), Vector( 140.503, -1366.83, 13.1827 )], // To Lawyers Office
 [ Vector(139.562,-1369.64,13.1827), Vector( 145.115, -1373.62, 10.432 )], // From Lawyers Office
 [ Vector(531.76,-118.642,13.337), Vector( 531.82, -127.311, 31.8522 )], // To Roof access near malibu #1
 [ Vector(531.655,-131.936,32.5095), Vector( 531.851, -111.883, 10.7477 )], // From Roof access near malibu #1
 [ Vector(475.792,30.4263,12.0714), Vector( 456.443, 30.3307, 34.8713 )], // To Roof access near malibu #2
 [ Vector(462.603,30.3705,30.9712), Vector( 481.619, 30.4486, 11.0712 )], // From Roof access near malibu #2
 [ Vector(-893.381,1054.55,15.6737), Vector( -943.87, 1077.19, 11.0946 )], // To Lovefist
 [ Vector(-940.18,1077.63,11.0946), Vector( -888.268, 1054.37, 14.689 )], // From Lovefistcase
 [ Vector(-829.876,1309.94,11.5467), Vector( -820.836, 1355.72, 66.4525 )], // To Roof Access in Downtown #1
 [ Vector(-813.565,1354.24,66.4603), Vector( -828.593, 1304.96, 11.5887 )], // From Roof Access in Downtown #1
 [ Vector(-410.452,1118.05,11.0709), Vector(  -445.71, 1127.11, 56.6909 )], // To VCN Building
 [ Vector(-449.024,1128.07,56.6909), Vector( -408.424, 1114.92, 11.0709 )], // From VCN Building
 [ Vector(-448.446,1249.33,11.767), Vector( -444.803, 1253.35, 77.4241 )], // To Roof Access in Downtown #2
 [ Vector(-448.35,1249.3,77.3986), Vector( -449.452, 1252.74, 11.767 )], // From Roof Access in Downtown #2
 [ Vector(-874.715,1159.56,11.1825), Vector( -880.359, 1159.52, 17.8184 )], // To V Rock(Near Lovefist)
 [ Vector(-877.507,1160.53,17.8152), Vector( -872.045, 1161.86, 11.16 )], // From V Rock(Near Lovefist)
 [ Vector(-892.953,1048.69,15.6737), Vector( -890.945, 1066.15, 75.8666 )], // To Lovefist roof
 [ Vector(-893.477,1050.26,75.8666), Vector( -887.988, 1046.99, 14.4515 )], // From Lovefist roof
 [ Vector(-280.8, -1733.78, 8.04), Vector( -332.966, -1632.33, 8.04 )], // pick1 to house2
 [ Vector(-386.458, -1732.73, 11.6376), Vector( -296.006, -1725.26, 9.04412 )], // pick2 to house3
 [ Vector(-342.495, -1648.86, 8.04), Vector( -369.177, -1734.27, 11.6376 )], // pick3 to house1
 [ Vector(-935.85, -351.315, 17.8038), Vector( -933.277, -351.746, 7.22692 )], // To bank locker
 [ Vector(-936.923, -351.838, 7.22692), Vector( -933.531, -351.39, 17.8038 )], // From bank locker.
 [ Vector(-51.0976, 111.879, 22.0522), Vector( -38.6324, 129.855, 25.202 )], // gaoerfuwai to grfnei
 [ Vector(-51.2547, 117.894, 22.9393), Vector( -41.4106, 121.094, 23.4279 )], // gaoerfunei to grfwai
 [ Vector(-1589.29, -183.487, 14.8683), Vector( -1596.01, -176.88, 14.8683 )], // jy1 to jyou
 [ Vector(-1589.15, -180.374, 14.8683), Vector( -1593.13, -190.57, 14.8683 )], // jy2 to jyin
 [ Vector(607.806, -256.845, 13.8289), Vector( 602.852, -256.128, 14.7135 )], // beach
 [ Vector(597.007, -256.506, 13.8289), Vector( 611.646, -256.799, 13.8289 )], // beahin
];

function onCheckpointEntered( player, cp ) {
  //FIXME: Verify we own this checkpoint..
  if ( !player.Vehicle ) {
    if ( cp.ID < LocsLike03.len() && LocsLike03[ cp.ID ] ) {
      player.Pos = LocsLike03[ cp.ID ][1];
    }
  }
}

function onScriptLoad() {
  for( local l = 0; l < LocsLike03.len(); l++ ) {
    CreateCheckpoint( null, 1, true, LocsLike03[ l ][0], RGB(255, 0, 255), 1.3);
  }
}
