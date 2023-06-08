import 'package:flutter/material.dart';

class FarmerDeliveryPage extends StatefulWidget {
  const FarmerDeliveryPage({Key? key}) : super(key: key);

  @override
  State<FarmerDeliveryPage> createState() => _FarmerDeliveryPageState();
}

class _FarmerDeliveryPageState extends State<FarmerDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
            ],
          ),
        ),
        body: const TabBarView(
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
