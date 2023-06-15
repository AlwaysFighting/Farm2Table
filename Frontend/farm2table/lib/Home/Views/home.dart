import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/src/screen_util.dart';
import 'package:hexcolor/hexcolor.dart';
import 'category.dart';
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
    Image.asset('assets/Images/home_images/ad1.png', fit: BoxFit.cover),
    Image.asset('assets/Images/home_images/ad2.png', fit: BoxFit.cover),
    Image.asset('assets/Images/home_images/ad3.png', fit: BoxFit.cover),
  ];

  Widget buildCarousel(){
    return CarouselSlider(
      items: imageList.map((image){
        return Builder(
            builder:(BuildContext context){
              return SizedBox(
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
      {"image" : "assets/Images/home_images/gul.png", "name": "귤","id": "gulcategory"},
      {"image" : "assets/Images/home_images/strawberry.png", "name": "딸기","id" : "strawberrycategory"},
      {"image" : "assets/Images/home_images/koreanmelon.png", "name": "참외","id": "koreanmeloncategory"},
      {"image" : "assets/Images/home_images/tomato.png", "name": "토마토","id": "tomatocategory"},
      {"image" : "assets/Images/home_images/watermelon.png", "name": "수박","id": "watermeloncategory"},
      {"image" : "assets/Images/home_images/blueberry.png", "name": "블루베리","id": "blueberrycategory"},
      {"image" : "assets/Images/home_images/apple.png", "name": "사과","id": "applecategory"},
      {"image" : "assets/Images/home_images/peer.png", "name": "배","id": "peercategory"},
      {"image" : "assets/Images/home_images/grape.png", "name": "포도","id": "grapecategory"},
      {"image" : "assets/Images/home_images/gam.png", "name": "감","id": "gamcategory"},
      {"image" : "assets/Images/home_images/sweetpotato.png", "name": "고구마","id": "sweetpotatocategory"},
      {"image" : "assets/Images/home_images/potato.png", "name": "감자","id": "potatocategory"},
      {"image" : "assets/Images/home_images/sangchu.png", "name": "상추","id": "sangchucategory"},
      {"image" : "assets/Images/home_images/corn.png", "name": "옥수수","id": "corncategory"},
      {"image" : "assets/Images/home_images/gochu.png", "name": "고추","id": "gochucategory"},
      {"image" : "assets/Images/home_images/mushroom.png", "name": "버섯","id": "mushroomcategory"},
      {"image" : "assets/Images/home_images/moo.png", "name": "무","id": "moocategory"},
      {"image" : "assets/Images/home_images/oee.png", "name": "오이","id": "oeecategory"},
      {"image" : "assets/Images/home_images/letuce.png", "name": "배추","id": "letucecategory"},
      {"image" : "assets/Images/home_images/carrot.png", "name": "당근","id": "carrotcategory"},
    ];

  Widget category(){
    return SizedBox(
      //height: double.infinity,
      width: ScreenUtil().setWidth(338),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 0.7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children:List.generate(items.length,(index){
          return GestureDetector(
            onTap: (){
              if(items[index]['id'] != null){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Category(id:items[index]['id']!)),);
              }
            },
            child: GridTile(
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
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                ],
              )
            ),
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
