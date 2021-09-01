// Name: Raspberry Pi Camera v2.1
// Description: A model to be integrated in other models
// Created: 1 Sep 2021
// Author: Krisjanis Rijnieks

include <variables.scad>

RpiCameraSensor(
  baseSize = rpiCameraSensorBaseSize, 
  baseHeight = rpiCameraSensorBaseHeight,
  ringSize = rpiCameraSensorRingSize,
  ringHeight = rpiCameraSensorRingHeight, 
  lensSize = rpiCameraSensorLensSize,
  lensHeight = rpiCameraSensorLensHeight);

RpiCameraPCB(
  width = rpiCameraPCBWidth,
  height = rpiCameraPCBHeight,
  thickness = rpiCameraPCBThickness, 
  cornerRadius = rpiCameraPCBCornerRadius,
  holeDiameter = rpiCameraHoleDiameter,
  holePadding = rpiCameraHolePadding,
  holeDistance = rpiCameraHoleDistance,
  sensorToTopEdge = rpiCameraSensorCenterToTopEdge);

rotate([90, 180, 0])
translate([0, 
  rpiCameraSensorCenterToTopEdge, 
  -rpiCameraPCBThickness])
RpiCameraConnector(
  width = rpiCameraConnectorWidth,
  height = rpiCameraConnectorHeight,
  thickness = rpiCameraConnectorThickness);

module RpiCameraConnector(
  width, thickness, height,
  pcbThickness, ){
  mirror([0, 0, 1])
  translate([-width/2, -height, 0])
  cube(size = [width, height, thickness]);
}

module RpiCameraPCB(
  width, height, thickness, cornerRadius, 
  holeDiameter, holePadding, holeDistance,
  sensorToTopEdge){
  
  // rotate so that shorter gap beten edge and sensor is at the bottom
  rotate([90, 180, 0]){
    translate([
      -width / 2, 
      -height + sensorToTopEdge, 0])
    mirror([0, 0, 1])
    difference(){
      linear_extrude(height = thickness){
        offset(r = cornerRadius, $fn = 45){
          offset(r = -cornerRadius){
            square(size = [width, height]);
          }
        }
      }
      
      translate([
        holePadding, 
        holePadding, 
        thickness / 2])
      cylinder(
        d = holeDiameter, h = thickness * 2, 
        center = true, $fn = 45);
      
      translate([
        width - holePadding, 
        holePadding, 
        thickness / 2])
      cylinder(
        d = holeDiameter, h = thickness * 2, 
        center = true, $fn = 45);
      
      translate([
        width - holePadding, 
        holePadding + holeDistance, 
        thickness / 2])
      cylinder(
        d = holeDiameter, h = thickness * 2, 
        center = true, $fn = 45);
      
      translate([
        holePadding, 
        holePadding + holeDistance, 
        thickness / 2])
      cylinder(
        d = holeDiameter, h = thickness * 2, 
        center = true, $fn = 45);    
    }
  }
}

module RpiCameraSensor(
  baseSize, baseHeight,
  ringSize, ringHeight, 
  lensSize, lensHeight){
  
  // Rotate so that the camera is facing front
  rotate([90, 0, 0]){
    translate([0, 0, baseHeight/2])
    cube(
      size = [baseSize, baseSize, baseHeight], 
      center = true);
      
    translate([0, 0, baseHeight])
    cylinder(d = ringSize, h = ringHeight, $fn = 45);
      
    translate([0, 0, baseHeight + ringHeight])
    cylinder(d = lensSize, h = lensHeight, $fn = 45);
  }
}

