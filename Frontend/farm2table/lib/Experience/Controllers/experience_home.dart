import 'package:carousel_slider/carousel_slider.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:farm2table/Experience/Controllers/experience_detail_page.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ExperienceHome extends StatefulWidget {
  ExperienceHome({Key? key}) : super(key: key);

  @override
  State<ExperienceHome> createState() => _ExperienceHomeState();
}

class _ExperienceHomeState extends State<ExperienceHome> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imgList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _banner(),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "체험 프로그램 카테고리",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: subColor),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: const [
                      _categoryCard(
                        title: '과일',
                        image: 'assets/Images/fruit/fruit.png',
                      ),
                      SizedBox(width: 30),
                      _categoryCard(
                        title: '채소',
                        image: 'assets/Images/fruit/veget.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "! 마감 입박 프로그래밍 !",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: subColor),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            renderGridViewBuilder(),
          ],
        ),
      ),
    );
  }
}

class _banner extends StatelessWidget {
  const _banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.0,
        scrollDirection: Axis.horizontal,
        aspectRatio: 1.9,
        initialPage: 1,
      ),
      items: imgList
          .map((item) => ClipRRect(
            child: Stack(
              children: <Widget>[
                Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(50, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${imgList.indexOf(item) + 1}/6',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
          .toList(),
    );
  }
}

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 155,
          height: 195,
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const ExperienceDetailPage(programNum: 1,);
                    }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 이미지
                  Stack(
                    children: [
                      Image.asset(
                        'assets/Images/vegetable/Lettuce.png',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(21.0),
                              bottomRight: Radius.circular(21.0),
                            ),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: const Center(
                            child: Text(
                              '마감 1일 전',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 7,
                        right: 12,
                        child: Text(
                          '9/10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            '[상추 재배하기]',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: textColor1),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2023년 6월 1일',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFA8A8A8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget renderGridViewBuilder() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1,
      crossAxisSpacing: 0,
      mainAxisSpacing: 5.0,
    ),
    itemBuilder: (context, index) {
      return const ProgramCard();
    },
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    // 몇 개까지 그릴 것인지
    itemCount: 5,
  );
}

class _categoryCard extends StatelessWidget {
  final String title;
  final String image;

  final cardTextStyle = const TextStyle(
      color: mainColor, fontSize: 15, fontWeight: FontWeight.w700);

  const _categoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x25A1A1A1),
            blurRadius: 4,
            offset: Offset(4, 4), // X, Y 값 조정
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 150,
            height: 91,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: cardTextStyle,
                ),
                const SizedBox(width: 5.0),
                SizedBox(
                  height: 17,
                  width: 17,
                  child: Image.asset(
                    image,
                    // 이미지 꽉차게 적용하기
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
