import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Const/bottom_nav.dart';
import 'package:flutter_screenutil/src/screen_util.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(myapp());
}
class myapp extends StatelessWidget{
  const myapp({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context){
    return ScreenUtilInit(
      designSize: const Size(390,844),
        builder: (context, child){
           return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: BottomNavigation(),
            ),
          );
        });
  }
}