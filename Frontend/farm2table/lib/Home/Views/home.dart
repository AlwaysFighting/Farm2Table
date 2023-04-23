import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final imageList=[
    Image.asset('assets/images/ad1.png', fit: BoxFit.cover),
    Image.asset('assets/images/ad2.png', fit: BoxFit.cover),
    Image.asset('assets/images/ad3.png', fit: BoxFit.cover),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildCarousel(),
          ],
        ),
      ),
    );
  }

  Widget buildCarousel(){
    return CarouselSlider(
      items: imageList.map((image){
        return Builder(
            builder:(BuildContext context){
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: image,
              );
            }
        );
      }).toList(),
      options: CarouselOptions(height: 239 ,autoPlay: true),);
  }
  Widget menu(){
    return GridView.count(
      crossAxisCount: 5,
      children:
      <Widget>[
        Container(
          color: Colors.red,
          width: 51,
          height: 51,
          margin: const EdgeInsets.all(8.0),
        )
      ],
    );
  }

}
