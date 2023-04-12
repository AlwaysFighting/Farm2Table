import 'package:flutter/material.dart';

class MarketHomePage extends StatelessWidget {
  const MarketHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text("MarketHomePage")),
      ),
    );
  }
}

