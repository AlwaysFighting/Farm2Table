import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Const/colors.dart';
import 'experience_review_page.dart';

class ExperienceDetailPage extends StatefulWidget {
  final int programNum;

  const ExperienceDetailPage({Key? key, required this.programNum})
      : super(key: key);

  @override
  State<ExperienceDetailPage> createState() => _ExperienceDetailPageState();
}

class _ExperienceDetailPageState extends State<ExperienceDetailPage> {
  double rating = 4.5;

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

  late int programNumber;

  @override
  void initState() {
    super.initState();
    programNumber = widget.programNum;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference experienceDetail =
        FirebaseFirestore.instance.collection('market1');

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 221.0,
              pinned: true,
              foregroundColor: Colors.white,
              backgroundColor: subColor,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: experienceDetail
                      .doc('Experience')
                      .collection('Program')
                      .doc('$programNumber')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data?.data() as Map<String, dynamic>;
                      var imageUrl = data['banner'];
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            )
          ];
        },
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: experienceDetail
              .doc('Experience')
              .collection('Program')
              .doc('$programNumber')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
              return const Center(child: Text('ERROR'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return const Center(child: Text('데이터가 없습니다!'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data?.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, top: 12.0, bottom: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    print("농부 프로필로 이동하기");
                                  },
                                  style: TextButton.styleFrom(
                                      textStyle: titleStyle),
                                  child: Text("작성자 : ${data['writers']}"),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "[${data["title"]}]",
                                      style: titleStyle.copyWith(
                                        color: const Color(0xFF7C7C7C),
                                        fontSize: 26.0,
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    (data["current_num"].toString() == data["sum_people"].toString()) ?
                                    Text(
                                      "마감",
                                      style: titleStyle.copyWith(
                                        color: const Color(0xFFFFB978),
                                        fontSize: 14.0,
                                      ),
                                    ) :
                                    Text(
                                      "(마감 ${formatTimestampRelation(data['endDate'])})",
                                      style: titleStyle.copyWith(
                                        color: const Color(0xFFFFB978),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 11.0),
                                Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/Images/const/star.png',
                                          height: 17.0,
                                          width: 20.0,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          data["star"],
                                          style: titleStyle.copyWith(
                                            fontSize: 12.0,
                                            color: const Color(0xFF929292),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 13.0),
                                        Container(
                                          height: 17.0,
                                          width: 1.5,
                                          color: const Color(0xFF929292),
                                        ),
                                        const SizedBox(width: 13.0),
                                        Image.asset(
                                          'assets/Images/const/person.png',
                                          height: 16.0,
                                          width: 16.0,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "현재 : ${data["current_num"]} / ${data["sum_people"]} 명",
                                          style: titleStyle.copyWith(
                                            fontSize: 13.0,
                                            color: const Color(0xFF929292),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          _divider(),
                        ],
                      ),
                      const SizedBox(height: 45.0),
                      Image.asset(
                        data['body_image'],
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 45.0),
                      _divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 17.0,
                              top: 23.0,
                              right: 17.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "프로그램 후기",
                                  style: textStyle.copyWith(
                                      color: subColor, fontSize: 16.0),
                                ),
                                Text(
                                  "누적 참가자 : ${data['acc_participants']}명",
                                  style: textStyle.copyWith(
                                    color: subColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 17.0,
                              top: 23.0,
                              right: 17.0,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Image.asset(
                                    "assets/Images/const/star.png",
                                    // 이미지 꽉차게 적용하기
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  data['star'],
                                  style: textStyle.copyWith(
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  "(${data['reviews']})",
                                  style: textStyle.copyWith(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          Reviews(textStyle: textStyle, rating: rating, programInt: programNumber,),
                          const SizedBox(height: 20.0),
                          Center(
                            child: SizedBox(
                              height: 34,
                              width: 324,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ExReviewPage(
                                      programNum: programNumber,
                                    );
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ratingColor2,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0)),
                                ),
                                child: Text(
                                  "후기 ${data['reviews']}개 모두 보기",
                                  style: textStyle.copyWith(
                                    color: textColor1,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 42.0),
                      _divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 17.0, top: 10, right: 17.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "문의",
                              style: textStyle.copyWith(
                                  color: subColor, fontSize: 16.0),
                            ),
                            IconButton(
                              onPressed: () {
                                //if (controller == null) { return; }
                                //controller!.loadUrl(homeURL);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Color(0xFF949494),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 42.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatTimestamp(
                                    data['endDate'], 'yyyy년 MM월 dd일 HH:mm'),
                                style: textStyle,
                              ),
                              Text(
                                '예치금 : ${data['deposit']}원',
                                style: textStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 42,
                            width: 169,
                            child: ElevatedButton(
                              onPressed: () {
                                print("참가하기");
                              },
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: subColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                textStyle: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: const Text('참가하기'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Container _divider() {
    return Container(
      height: 7,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x23E3E3E3),
            offset: Offset(0, 4),
            blurRadius: 1,
          ),
        ],
        color: Color(0xFFE5E5E5),
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({
    Key? key,
    required this.textStyle,
    required this.rating,
    required this.programInt,
  }) : super(key: key);

  final TextStyle textStyle;
  final double rating;
  final int programInt;

  String formatTimestamp(Timestamp timestamp, String format) {
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat(format).format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference experienceDetail =
    FirebaseFirestore.instance.collection('market1');

    return Padding(
      padding: const EdgeInsets.only(
        left: 17.0,
      ),
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: experienceDetail
            .doc('Experience')
            .collection('Program')
            .doc('$programInt')
            .collection('reviews')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            return SizedBox(
              height: 134,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      height: 109,
                      width: 181,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFFD9D9D9),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['nickname'],
                              style: textStyle.copyWith(
                                fontSize: 10.0,
                                color: const Color(0xFF747373),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    i < data['stars'].floor()
                                        ? Icons.star
                                        : i - data['stars'] < 0.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                    color: ratingColor,
                                    size: 15.0,
                                  ),
                                const SizedBox(width: 4.0),
                                Text(
                                  formatTimestamp(data['dateTime'],
                                      'yyyy년 MM월 dd일'),
                                  style: textStyle.copyWith(
                                    fontSize: 8.0,
                                    color: const Color(0xFFAEAEAE),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  data['title'],
                                  style: textStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  data['subTitle'],
                                  style: textStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.0,
                                  ),
                                  overflow: TextOverflow.ellipsis, // 글자가 넘칠 경우 "..."으로 축소
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

