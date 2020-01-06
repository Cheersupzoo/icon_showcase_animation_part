import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconModel {
  final String title;
  final IconData icon;

  IconModel({this.title, this.icon});
}

final List<IconModel> iconList = [
  IconModel(title: 'Motorcycle', icon: Icons.motorcycle),
  IconModel(title: 'Car', icon: Icons.directions_car),
  IconModel(title: 'Train', icon: Icons.directions_railway),
  IconModel(title: 'Laptop',icon: Icons.laptop_windows),
  IconModel(title: 'Home',icon: Icons.home),
];
