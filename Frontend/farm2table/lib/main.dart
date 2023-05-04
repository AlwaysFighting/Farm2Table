import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Const/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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