import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:farm2table/Experience/Controllers/experience_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Market/Views/market_home.dart';
import 'experience_category_page.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80',
  'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80',
  'https://images.unsplash.com/photo-1532509774891-141d37f25ae9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80',
  'https://images.unsplash.com/photo-1630273369434-cf72cf19ffa9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80',
  'https://images.unsplash.com/photo-1474440692490-2e83ae13ba29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80',
];

class ExperienceHome extends StatefulWidget {
  const ExperienceHome({Key? key}) : super(key: key);

  @override
  State<ExperienceHome> createState() => _ExperienceHomeState();
}

class _ExperienceHomeState extends State<ExperienceHome> {
  CarouselController buttonCarouselController = CarouselController();

  final titleStyle = const TextStyle(
    color: alarmColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  final textStyle = const TextStyle(
    color: textColor1,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in imgList) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
    super.initState();
  }

  String formatTimestamp(Timestamp timestamp, String format) {
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat(format).format(dateTime);
    return formattedDateTime;
  }

  String formatTimestampRelation(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime dateTime = timestamp.toDate();
    Duration difference = now.difference(dateTime).abs();

    if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}일 전';
    } else {
      return '0일 전(마감)';
    }
  }

  @override
  Widget build(BuildContext context) {

    CollectionReference experienceDetail =
    FirebaseFirestore.instance.collection('market1');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _banner(),
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "체험 프로그램 카테고리",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: subColor),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      _categoryCard(
                        title: '과일',
                        image: 'assets/Images/fruit/fruit.png', index: 0,
                      ),
                      SizedBox(width: 30),
                      _categoryCard(
                        title: '채소',
                        image: 'assets/Images/fruit/veget.png', index: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text(
                    "! 마감 입박 프로그래밍 !",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: subColor),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: experienceDetail
                  .doc('Experience')
                  .collection('Program')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      if (index < documents.length) {
                        Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Card(
                              elevation: 0,
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  if ( data['current_num'] != data["sum_people"]) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ExperienceDetailPage(
                                            programNum: index + 1,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 130,
                                          width: 155,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(21.0),
                                            child: Image.network(
                                              data['banner'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
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
                                            child: Center(
                                              child: Text(
                                                "마감 ${formatTimestampRelation(data['endDate'])}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 7,
                                          right: 12,
                                          child: Text(
                                            '${data["current_num"]}/${data["sum_people"]}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                       if ( data['current_num'] == data["sum_people"])...[
                                         Positioned(
                                           top: 0,
                                           left: 0,
                                           right: 0,
                                           height: MediaQuery.of(context).size.height * 0.5,
                                           child: Container(
                                             color: Colors.white.withAlpha(140),
                                           ),
                                         ),
                                       ]
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              data["title"],
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: (data['current_num'] != data["sum_people"]) ? textColor1 : const Color(0xFFA9A9A9)),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              formatTimestamp(
                                                data['endDate'], 'yyyy년 MM월 dd일'),
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: (data['current_num'] != data["sum_people"]) ? const Color(0xFFA8A8A8) : const Color(0xFFCDCDCD)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // 몇 개까지 그릴 것인지
                    itemCount: snapshot.data?.docs.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _banner extends StatelessWidget {
  const _banner();

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
                      '${imgList.indexOf(item) + 1}/5',
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

class _categoryCard extends StatelessWidget {
  final String title;
  final String image;
  final int index;

  final cardTextStyle = const TextStyle(
      color: mainColor, fontSize: 15, fontWeight: FontWeight.w700);

  const _categoryCard({required this.title, required this.image, required this.index});

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
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ExperienceCategory(
              index: index,
              title: index == 0 ? 'Fruit' : 'Vegetable',
            );
          }));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          clipBehavior: Clip.hardEdge,
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
