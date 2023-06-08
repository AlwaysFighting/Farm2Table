import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Const/colors.dart';
import 'farmer_delivery_page.dart';

class WriterFarmerInfoPage extends StatefulWidget {
  const WriterFarmerInfoPage({
    Key? key,
    required this.programNum,
    required this.writer,
  }) : super(key: key);

  final int programNum;
  final String writer;

  @override
  State<WriterFarmerInfoPage> createState() => _WriterFarmerInfoPageState();
}

class _WriterFarmerInfoPageState extends State<WriterFarmerInfoPage> {
  double rating = 4.5;

  final titleStyle = const TextStyle(
    color: alarmColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  final orangeTextStyle = const TextStyle(
    color: mainColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final subTextStyle = const TextStyle(
    color: Color(0xFF929292),
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final titleTextStyle = const TextStyle(
    color: Color(0xFF535353),
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  final textStyle = const TextStyle(
    color: Color(0xFF535353),
    fontSize: 13,
    fontWeight: FontWeight.w500,
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
    CollectionReference farmerDetail =
        FirebaseFirestore.instance.collection('market1');

    return Scaffold(
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
                  future: farmerDetail
                      .doc('Farmer')
                      .collection('${widget.programNum}')
                      .doc(widget.writer)
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
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: farmerDetail
                .doc('Farmer')
                .collection('${widget.programNum}')
                .doc(widget.writer)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  color: null,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(
                                    data['profile'],
                                    width: 87,
                                    height: 87,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: Image.asset(
                                      "assets/Images/const/star.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(data['star'], style: subTextStyle),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 18.0),
                          Text(data['title'], style: titleTextStyle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Container(
                      height: 135,
                      color: const Color(0x20EBEBEB),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 9.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 18.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('마켓 신선도', style: textStyle),
                                    const SizedBox(width: 4.0),
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                        "assets/Images/farmer/Smile.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                Text("${data['freshness']}℃",
                                    style: orangeTextStyle),
                              ],
                            ),
                            const SizedBox(height: 7.0),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(174)),
                              child: LinearProgressIndicator(
                                value: data['freshness'] / 100,
                                minHeight: 9,
                                semanticsLabel: 'Linear progress indicator',
                                backgroundColor: const Color(0xFFE5E5E5),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFFB978)),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('마켓 신선도', style: textStyle),
                                    const SizedBox(width: 4.0),
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                        "assets/Images/farmer/Smile.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                Text("${data['satisfy']}℃",
                                    style: orangeTextStyle),
                              ],
                            ),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(174)),
                              child: LinearProgressIndicator(
                                value: data['satisfy'] / 100,
                                minHeight: 9,
                                semanticsLabel: 'Linear progress indicator',
                                backgroundColor: const Color(0xFFE5E5E5),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFFB978)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 37.0),
                    const SizedBox(height: 54.0),
                    _divider(),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SizedBox(
                        height: 31,
                        width: 56,
                        child: Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: mainColor,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '전체',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11.0),
                    Container(
                      height: 1,
                      color: const Color(0x10000000),
                    ),
                    const SizedBox(height: 11.0),
                    GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        return Center(child: Text('dd'));
                      },
                    )
                  ],
                ));
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Container _divider() {
    return Container(
      height: 9,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x23E3E3E3),
            offset: Offset(0, 4),
            blurRadius: 1,
          ),
        ],
        color: Color(0xFFF3F3F3),
      ),
    );
  }
}
