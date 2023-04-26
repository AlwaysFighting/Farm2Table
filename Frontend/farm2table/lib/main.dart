import 'package:flutter/material.dart';
import 'Const/bottom_nav.dart';
import 'package:flutter_screenutil/src/screen_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BottomNavigation(),
      ),
    ),
  );
}