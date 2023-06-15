import 'package:farm2table/Market/Views/market_home.dart';
import 'package:flutter/material.dart';

import '../Cart/Views/cart.dart';
import '../Experience/Controllers/experience_home.dart';
import '../Home/Views/home.dart';
import '../MyPage/Views/mypage_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm2table/Login/login.dart';

import 'colors.dart';

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
    const ExperienceHome(),
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
            return const Login();
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
      backgroundColor: subColor,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10.0),
      unselectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10.0),
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/House_Grey.png',
              width: 20,
              height: 20,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/House_Color.png',
              width: 20,
              height: 20,
            ),
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Market_Grey.png',
              width: 20,
              height: 20,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Market_Color.png',
              width: 20,
              height: 20,
            ),
          ),
          label: '마켓',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Ex_Grey.png',
              width: 20,
              height: 20,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Ex_Color.png',
              width: 20,
              height: 20,
            ),
          ),
          label: '체험',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Cart_Grey.png',
              width: 20,
              height: 20,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/Cart_Color.png',
              width: 20,
              height: 20,
            ),
          ),
          label: '장바구니',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/User_Grey.png',
              width: 20,
              height: 20,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/Images/navigation/User_Color.png',
              width: 20,
              height: 20,
            ),
          ),
          label: '마이페이지',
        ),
      ],
    );
  }
}
