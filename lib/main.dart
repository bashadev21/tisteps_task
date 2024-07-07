import 'package:flutter/material.dart';

import 'package:tisteps/src/myApp.dart';

import 'src/di.dart' as di;

void main() async {
  // Dependency injection
  di.init();
  runApp(const MyApp());
}
