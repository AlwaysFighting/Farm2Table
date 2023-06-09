import 'package:farm2table/Market/Views/market_home.dart';
import 'package:flutter/material.dart';

import '../Cart/Views/cart.dart';
import '../Experience/Controllers/experience_home.dart';
import '../Home/Views/home.dart';
import '../MyPage/Views/mypage_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm2table/Login/login.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;

  // 현재 페이지를 나타낼 index
  int currentIndex = 0;

// 이동할 페이지 Widget
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const MarketHomePage(),
    ExperienceHome(),
    const Cart(),
    const MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
          if(!snapshot.hasData){
            return Login();
          }else{
            return Scaffold(
              body: SafeArea(
                child: _widgetOptions.elementAt(currentIndex),
              ),
              bottomNavigationBar: _bottomNavigation(),
            );
          }
        },
      ),
    );
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.black),
      selectedItemColor: Colors.black,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      items:const [
        BottomNavigationBarItem(
          label: "홈",
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: "마켓",
          icon: Icon(Icons.add_business_outlined),
        ),
        BottomNavigationBarItem(
          label: "체험",
          icon: Icon(Icons.airplane_ticket_outlined),
        ),
        BottomNavigationBarItem(
          label: "장바구니",
          icon: Icon(Icons.shopping_cart_outlined),
        ),
        BottomNavigationBarItem(
          label: "마이페이지",
          icon: Icon(Icons.person_outline),
        ),
      ],
    );
  }
}
