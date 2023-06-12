import 'package:farm2table/Const/colors.dart';
import 'package:flutter/material.dart';

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({Key? key}) : super(key: key);

  @override
  State<MarketHomePage> createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {

  final activeTabTextStyle = const TextStyle(
    color: subColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  final notActiveTabTextStyle = const TextStyle(
    color: Color(0xFFCBD9C5),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('TabBar Sample'),
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Text('과일'),
              ),
              Tab(
                icon: Text('채소'),
              ),
            ],
            indicatorColor: subColor,
            labelStyle: activeTabTextStyle,
            labelColor: subColor,
            unselectedLabelColor: const Color(0xFFCBD9C5),
            unselectedLabelStyle: notActiveTabTextStyle,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}