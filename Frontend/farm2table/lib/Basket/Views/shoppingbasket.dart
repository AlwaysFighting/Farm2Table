import 'package:flutter/material.dart';
import 'package:farm2table/Const/colors.dart';

class ShoppingBasket extends StatefulWidget {
  const ShoppingBasket({Key? key}):super(key:key);
  @override
  State<ShoppingBasket> createState() => BasketState();
}
class BasketState extends State<ShoppingBasket> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 29,),
          Expanded(child: tabview()),
        ],
      ),
    );
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
                    text: '직거래',
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
}

