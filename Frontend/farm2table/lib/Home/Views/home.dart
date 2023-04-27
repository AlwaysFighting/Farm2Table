import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/src/screen_util.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  child:Column(
                    children: [
                      buildCarousel(),
                      category(),
                      SizedBox(height:ScreenUtil().setHeight(34)),
                      box(),
                    ],
                  )
                ))
              ],
            ),
          );

  }
  final imageList=[
    Image.asset('assets/images/ad1.png', fit: BoxFit.cover),
    Image.asset('assets/images/ad2.png', fit: BoxFit.cover),
    Image.asset('assets/images/ad3.png', fit: BoxFit.cover),
  ];

  Widget buildCarousel(){
    return CarouselSlider(
      items: imageList.map((image){
        return Builder(
            builder:(BuildContext context){
              return SizedBox(
                //추가해보앗다
                height: ScreenUtil().setHeight(239),
                width: MediaQuery.of(context).size.width,
                child: image,
              );
            }
        );
      }).toList(),
      options: CarouselOptions(
          height: ScreenUtil().setHeight(239),
          autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
      ),);
  }
  final List<Map<String, dynamic>> items=[
      {"image" : "assets/images/gul.png", "name": "귤"},
      {"image" : "assets/images/strawberry.png", "name": "딸기"},
      {"image" : "assets/images/koreanmelon.png", "name": "참외"},
      {"image" : "assets/images/tomato.png", "name": "토마토"},
      {"image" : "assets/images/watermelon.png", "name": "수박"},
      {"image" : "assets/images/blueberry.png", "name": "블루베리"},
      {"image" : "assets/images/apple.png", "name": "사과"},
      {"image" : "assets/images/peer.png", "name": "배"},
      {"image" : "assets/images/grape.png", "name": "포도"},
      {"image" : "assets/images/gam.png", "name": "감"},
      {"image" : "assets/images/sweetpotato.png", "name": "고구마"},
      {"image" : "assets/images/potato.png", "name": "감자"},
      {"image" : "assets/images/sangchu.png", "name": "상추"},
      {"image" : "assets/images/corn.png", "name": "옥수수"},
      {"image" : "assets/images/gochu.png", "name": "고추"},
      {"image" : "assets/images/mushroom.png", "name": "버섯"},
      {"image" : "assets/images/moo.png", "name": "무"},
      {"image" : "assets/images/oee.png", "name": "오이"},
      {"image" : "assets/images/letuce.png", "name": "배추"},
      {"image" : "assets/images/carrot.png", "name": "당근"},
    ];

  Widget category(){
    return Container(
      //height: double.infinity,
      width: ScreenUtil().setWidth(338),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 0.7,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children:List.generate(items.length,(index){
          return GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //margin
                SizedBox(height:ScreenUtil().setHeight(37)),
                   Image.asset(
                    items[index]['image'],
                    height: ScreenUtil().setHeight(51),
                    width: ScreenUtil().setWidth(51),
                  ),

                SizedBox(height:ScreenUtil().setHeight(2)),
                Text(
                    items[index]['name'],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
              ],
            )
          );
        })
      ),
    );
  }
  Widget box(){
    return Container(
      color: HexColor('D9D9D9'),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(10),
    );
  }
}
