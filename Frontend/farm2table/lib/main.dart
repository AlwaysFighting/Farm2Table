import 'package:flutter/material.dart';
import 'Const/bottom_nav.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BottomNavigation(),
      ),
    ),
  );
}