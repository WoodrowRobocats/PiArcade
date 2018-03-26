////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Uncomment one of the following to render indicidual widgets
//For laser cuttable parts and 3D printable parts all measurements are in mm.
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Render 3D model of enclosure
3DModel();

//Render laser cuttable structure pieces
//Once rendered, export the following as a DXF to cut all pieces on a 24" x 12" laser bed out of a 24" x 9.1" piece of material
//CutPieces();

//Render 3D printable support pieces for Raspberry Pi Zero
//PrintPiZeroMountPlate();

//Render plastic protection piece. Recommend ~1mm clear plastic to allow picture to be placed around the buttons etc...
//TopPlate($DoMountHoles = 0);

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Following variables allow various parameters to be changed, e.g. box size, material thickness etc...
//Make sure the material thick ness matches what you will be using.
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Default sizes and spacing allow entire box to be laser cut on a 24" x 12" laser bed out of a 24" x 9.1" piece of material
//This allows 5x boxes from a 48" x 48" piece of ply 1/4" wood

//Box dimensions
$Width = 230;
$Height = 170;
$Depth = 50;

//Thickness of the material being used
$MaterialThickness = 5;

//Rounding radius of the corners
$Rounding = 8;

//Gap between pieces when laser cutting
$CutGap = 3;

//Size of overlap 'edge'. Set to zero for box with no lip. Do not recommend using tslots with zero overlap
$Overlap = 4;

//Position of buttons with respect to top left
$TopBorder = 20;
$LeftBorder = 25;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The following are the modules to render 'stuff'
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//T-slot bolt parameters
//Set 'DoxxxxTSlots = 1' for bolted box, set = 0 for glued box
//Suggest top = 0, bottom = 1 for glued top, t-slotted bottom
$DoTopTSlots = 1;
$DoBottomTSlots = 1;
$MountBoltDiameter = 3;
$MountBoltSlotLength = 15;
$MountBoltLocation = 10;
//T-slot nut parameters
$TNutWidth = 5.6;
$TNutHeight = 2.1;

//Button hole parameters
$SmallButtonDiameter = 23.7;//24.3;
$LargeButtonDiameter = 30;//23.7;

//Joystick mounting hole parameters
$JoystickMountHoleDiameter = 2.5;
$JoystickHSpacing = 43;
$JoystickVSpacing = 81;

//Raspberry Pi zero mounting parameters
$PiXLocation = 80;
$PiYLocation = 80;

//3D display colors
$ColorTop = [193/255, 141/255, 7/255];
$ColorBottom = [173/255, 121/255, 0/255];
$ColorFrontBack = [204/255, 174/255, 69/255];
$ColorLeftRight = [194/255, 164/255, 59/255];

$fn = 100;

module Joystick()
{
  color([.8, .8, .9])
    cylinder(d = 6, h = 30);
  color([1, .1, .2])
    translate([0, 0, 40])
      sphere(d = 25);
  color([.1, .1, .1])
    cylinder(d = 30, h = 1);
}

module JoystickHoles()
{
  circle(d = 20);
  if ($DoMountHoles == 1)
  {
  translate([$JoystickHSpacing / 2, $JoystickVSpacing / 2])
    circle(d = $JoystickMountHoleDiameter);
  translate([-$JoystickHSpacing / 2, $JoystickVSpacing / 2])
    circle(d = $JoystickMountHoleDiameter);
  translate([$JoystickHSpacing / 2, -$JoystickVSpacing / 2])
    circle(d = $JoystickMountHoleDiameter);
  translate([-$JoystickHSpacing / 2, -$JoystickVSpacing / 2])
    circle(d = $JoystickMountHoleDiameter);
  }
}

module 3DButtonHolePair()
{
  3DButton();
  translate([0, 36, 0])
    3DButton();
}

module ButtonHolePair()
{
  circle(d = $LargeButtonDiameter);
  translate([0, 38])
    circle(d = $LargeButtonDiameter);
}

module HoleSet()
{
  JoystickHoles($DoMountHoles = $DoMountHoles);
  //Coin button
  translate([0, 80])
    circle(d = $LargeButtonDiameter);
  //1 player button
  translate([50, 80])
    circle(d = $LargeButtonDiameter);
  //Select
  translate([100, 80])
    circle(d = $SmallButtonDiameter);
  //Change
  translate([150, 80])
    circle(d = $SmallButtonDiameter);
  //XA set
  translate([116-35, -18])
    ButtonHolePair();
  //YB set
  translate([116, 0])
    ButtonHolePair();
  //DE set
  translate([116+37, 0])
    ButtonHolePair();
}

module 3DButtonSet()
{
  //Coin button
  color([.9, .9, 1])
    translate([0, 80, $Depth])
      3DButton();
  //1 player button
  color([.3, .5, .6])
    translate([50, 80, $Depth])
      3DButton();
  //Select button
  color([.3, .2, .6])
    translate([100, 80, $Depth])
      3DButton($LargeButtonDiameter = $SmallButtonDiameter);
  //Cancel button
  color([.3, .2, .6])
    translate([150, 80, $Depth])
      3DButton($LargeButtonDiameter = $SmallButtonDiameter);
  //XA set
  color([.9, .1, .2])
    translate([116-35, -18, $Depth])
      3DButtonHolePair();
  //YB set
  color([.1, .9, .2])
    translate([116, 0, $Depth])
      3DButtonHolePair();
  //DE set
  color([.1, .1, .9])
    translate([116+37, 0, $Depth])
      3DButtonHolePair();
}

module PiMountingHoles()
{
  translate([3.5, 3.5])
    circle(d = $HoleSize);
  translate([3.5, 26.5])
    circle(d = $HoleSize);
  translate([61.5, 3.5])
    circle(d = $HoleSize);
  translate([61.5, 26.5])
    circle(d = $HoleSize);
}

module Slots()
{
  $SegmentLength = ($Length - $MaterialThickness - $MaterialThickness) / 6;
  translate([$SegmentLength + $MaterialThickness, 0])
    square([$SegmentLength, $MaterialThickness]);
  translate([($SegmentLength * 4) + $MaterialThickness, 0])
    square([$SegmentLength, $MaterialThickness]);
}

module Pegs()
{
  $SegmentLength = ($Length - $MaterialThickness - $MaterialThickness) / 6;
  square([$SegmentLength + $MaterialThickness, $MaterialThickness]);
  
  translate([($SegmentLength * 2) + $MaterialThickness,0])
    square([$SegmentLength * 2, $MaterialThickness]);
  translate([($SegmentLength * 5) + $MaterialThickness,0])
    square([$SegmentLength + $MaterialThickness, $MaterialThickness]);
}

module SlotsPegs()
{
  if ($Type == 0)
    Slots();
  else
    Pegs();
}

module MainPlate()
{
  difference()
  {
    translate([$Rounding, $Rounding])
    minkowski()
    {
      circle(r = $Rounding);
      square([$Width - $Rounding - $Rounding, $Height - $Rounding - $Rounding]);
    }
    if ($DoMountHoles == 1)
    {
    //Slots on lower edge of top plate
    translate([0, $Overlap])
      Slots($Length = $Width);
    //Slots on upper edge of top plate
    translate([0, $Height - $MaterialThickness - $Overlap])
      Slots($Length = $Width);
    //Slots on left edge of top plate
    translate([$MaterialThickness + $Overlap, 0])
      rotate(90, [0, 0, 1])
        Slots($Length = $Height);
    //Slots on right edge of top plate
    translate([$Width - $Overlap, 0])
      rotate(90, [0, 0, 1])
        Slots($Length = $Height);
    }
    //TSlot mounting holes
    if ($DoTSlots == 1)
    {
      translate([$Width / 2, $Overlap + ($MaterialThickness / 2)])
        circle(d = $MountBoltDiameter);
      translate([$Width / 2, $Height - $Overlap - ($MaterialThickness / 2)])
        circle(d = $MountBoltDiameter);
      translate([$Overlap + ($MaterialThickness / 2), $Height / 2])
        circle(d = $MountBoltDiameter);
      translate([$Width - $Overlap - ($MaterialThickness / 2), $Height / 2])
        circle(d = $MountBoltDiameter);
    }
  }
}

module TopPlate()
{
  difference()
  {
    MainPlate($DoMountHoles = $DoMountHoles, $DoTSlots = $DoTopTSlots);
    translate([($JoystickHSpacing / 2) + $LeftBorder, ($JoystickVSpacing / 2) + $TopBorder])
      HoleSet($DoMountHoles = $DoMountHoles);
  }
}

module BottomPlate()
{
  difference()
  {
    MainPlate($DoMountHoles = 1, $DoTSlots = $DoBottomTSlots);
    translate([$PiXLocation, $Height - $PiYLocation])
      PiMountingHoles($HoleSize = 2.5);
  }
}

module TSlot()
{
  translate([- $MountBoltDiameter / 2, 0])
  {
    square([$MountBoltDiameter, $MountBoltSlotLength]);
    translate([-($TNutWidth - $MountBoltDiameter) / 2, $MountBoltLocation])
      square([$TNutWidth, $TNutHeight]);
  }
}

module Support()
{
  difference()
  {
    translate([$Overlap, 0])
      square([$Length - $Overlap - $Overlap, $Depth]);
    //Lower pegs
    //Translate a little to avoid zero width wals
    translate([0, -0.01])
      Pegs();
    //Upper pegs
    translate([0, $Depth - $MaterialThickness + 0.01])
      Pegs();
    //Left pegs
    translate([$MaterialThickness + $Overlap - 0.01, 0])
      rotate(90, [0, 0, 1])
        SlotsPegs($Length = $Depth, $Type = $Type);
    //Right slots
    translate([$Length - $Overlap + 0.01, 0])
      rotate(90, [0, 0, 1])
        SlotsPegs($Length = $Depth, $Type = $Type);
    if ($DoBottomTSlots == 1)
    {
      //T-slots
      translate([$Length / 2, 0])
        TSlot();
    }
    if ($DoTopTSlots == 1)
    {
      translate([$Length / 2, $Depth])
      rotate(180, [0, 0, 1])
        TSlot();
    }
  }
}

module BackSupport()
{
  difference()
  {
    Support();
    //Back buttons
//    translate([170, $Depth / 2])
//      circle(d = $SmallButtonDiameter);
//    translate([200, $Depth / 2])
//      circle(d = $SmallButtonDiameter);
    //HDMI cable opening
    hull()
    {
      translate([$PiXLocation + 52.6, $MaterialThickness])
        circle(d = 5);
      translate([$PiXLocation + 52.6, $MaterialThickness + 2.5])
        circle(d = 5);
    }
    //Power cable opening
    hull()
    {
      translate([$PiXLocation + 11, $MaterialThickness])
        circle(d = 5);
      translate([$PiXLocation + 11, $MaterialThickness + 2.5])
        circle(d = 5);
    }
    //USB cable opening
    hull()
    {
      translate([$PiXLocation + 23.6, $MaterialThickness])
        circle(d = 5);
      translate([$PiXLocation + 23.6, $MaterialThickness + 2.5])
        circle(d = 5);
    }
  }
}

module CutPieces()
{
  //Top plate
//  //Mirror so burn marks are on inside
//  translate([$Width, 0, 0])
//    mirror([1, 0, 0])
      TopPlate($DoMountHoles = 1);
  //Bottom plate
  translate([$Width + $CutGap, 0])
    BottomPlate();
  //Front support
  translate([0, $Height + $CutGap])
    Support($Length = $Width, $Type = 0);
  //Back support
  translate([$Width + $CutGap, $Height + $CutGap])
    BackSupport($Length = $Width, $Type = 0);
  //Left support
  translate([$Width + $Width + $CutGap + $CutGap + $Depth, 0])
    rotate(90, [0, 0, 1])
      Support($Length = $Height, $Type = 1);
  //Right support
  translate([$Width + $Width + $CutGap + $CutGap + $Depth + $CutGap + $Depth, 0])
    rotate(90, [0, 0, 1])
      Support($Length = $Height, $Type = 1);
}

module 3DTop()
{
  color($ColorTop)
    linear_extrude(height = $MaterialThickness)
      TopPlate($DoMountHoles = 1);
}

module 3DBottom()
{
  color($ColorBottom)
    linear_extrude(height = $MaterialThickness)
      BottomPlate();
}

module 3DLeft()
{
  color($ColorLeftRight)
    rotate(90, [0, 0, 1])
      rotate(90, [1, 0, 0])
        linear_extrude(height = $MaterialThickness)
          Support($Length = $Height, $Type = 1);
}

module 3DRight()
{
  color($ColorLeftRight)
    rotate(90, [0, 0, 1])
      rotate(90, [1, 0, 0])
        linear_extrude(height = $MaterialThickness)
          Support($Length = $Height, $Type = 1);
}

module 3DFront()
{
  color($ColorFrontBack)
    rotate(90, [1, 0, 0])
      linear_extrude(height = $MaterialThickness)
        Support($Length = $Width, $Type = 0);
}

module 3DBack()
{
  color($ColorFrontBack)
    rotate(90, [1, 0, 0])
      linear_extrude(height = $MaterialThickness)
        BackSupport($Length = $Width, $Type = 0);
}

module 3DButton()
{
  rotate_extrude(convexity = 10, $fn = 100)
    translate([$LargeButtonDiameter / 2, 0, 0])
    circle(r = 2, $fn = 100);
  translate([0, 0, 1])
    scale([1, 1, .2])
      sphere(d = $LargeButtonDiameter);
}

module 3DModel()
{
  //Top piece
  translate([-$Overlap, 0, $Depth - $MaterialThickness])
    3DTop();
  //Bottom piece
  translate([-$Overlap, 0, 0])
    3DBottom();
  //Left side
  3DLeft();
  //Right side
  translate([$Width - $MaterialThickness - $Overlap - $Overlap, 0, 0])
    3DRight();
  //Front side
  translate([-$Overlap, $MaterialThickness + $Overlap, 0])
    3DFront();
  //Back side
  translate([-$Overlap, $Height - $Overlap , 0])
    3DBack();
  //Top buttons
  translate([($JoystickHSpacing / 2) + $LeftBorder - $Overlap, ($JoystickVSpacing / 2) + $TopBorder, 0])
    3DButtonSet();
  //Joystick
    translate([($JoystickHSpacing / 2) + $LeftBorder - $Overlap, ($JoystickVSpacing / 2) + $TopBorder, $Depth])
      Joystick();
}

module PiZeroMountPlate2D()
{
  difference()
  {
    square([65, 30]);
      PiMountingHoles($HoleSize = 3.0);
  }
}

module PiZeroMountPlate()
{
  difference()
  {
    linear_extrude(height = 2)
      PiZeroMountPlate2D();
    translate([7.5, 1.5, 0])
      cube([50, 4, 2]);
  }
}

module PiZeroMountSupport()
{
  difference()
  {
    union()
    {
      cube([30, 5, 1.5]);
      translate([3.5, 2.5, 0])
        cylinder(d = 5, h = 12);
      translate([26.5, 2.5, 0])
        cylinder(d = 5, h = 12);
    }
    translate([3.5, 2.5, 0])
      cylinder(d = 3.1, h = 12);
    translate([26.5, 2.5, 0])
      cylinder(d = 3.1, h = 12);
    translate([15, -28, 0])
      cylinder(d = 60, h = 12);
  }
  
}

module PrintPiZeroMountPlate()
{
  PiZeroMountPlate();
  translate([0, -8, 0])
    PiZeroMountSupport();
  translate([35, -8, 0])
    PiZeroMountSupport();
}

