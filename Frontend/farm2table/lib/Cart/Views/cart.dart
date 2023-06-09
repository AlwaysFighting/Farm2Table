import 'package:flutter/material.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Cart extends StatefulWidget {
  const Cart({Key? key}):super(key:key);
  @override
  State<Cart> createState() => CartState();
}
class CartState extends State<Cart> {
  late SharedPreferences prefs;
  Map<String, String> itemMap={};

  @override
  void initState(){
    initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          //SizedBox(height: 29,),
          Expanded(child: tabview()),
        ],
      ),
    );
  }

  //sharedpreferences 초기화
  Future<void> initializeSharedPreferences() async{
    prefs = await SharedPreferences.getInstance();
  }

  Widget tabview()
  {
    return DefaultTabController(length: 3,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                indicatorColor: subColor,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: subColor
                ),
                labelColor: subColor,
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    text: '${itemMap['market']}',
                  ),
                  Tab(
                    text: '택배',
                  ),
                  Tab(
                    text: '체험프로그램',
                  )
                ],
              ),
              Expanded(child: TabBarView(
                children: [
                  Center(
                    child: Text('아직 장바구니에 상품이 없어요!',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }

  Future<void> getMapFromSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? mapString = prefs.getString('itemMap');
    if(mapString != null)
      {
        setState(() {
          itemMap = jsonDecode(mapString) as Map<String,String>;
        });
      }
  }

}

