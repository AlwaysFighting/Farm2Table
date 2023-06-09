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

  final deliveryText = const TextStyle(
    color: Color(0xFF535353),
    fontSize: 14,
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
    CollectionReference farmerDetail =
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
                List<String> deliveryfee =
                    List<String>.from(snapshot.data?['DeliveryFee'] ?? []);
                List<String> deliveryMethod =
                List<String>.from(snapshot.data?['DeliveryMethod'] ?? []);
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
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 9.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 18.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(174)),
                                child: LinearProgressIndicator(
                                  value: data['freshness'] / 100,
                                  minHeight: 9,
                                  semanticsLabel: 'Linear progress indicator',
                                  backgroundColor: const Color(0xFFE5E5E5),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFFB978)),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(174)),
                                child: LinearProgressIndicator(
                                  value: data['satisfy'] / 100,
                                  minHeight: 9,
                                  semanticsLabel: 'Linear progress indicator',
                                  backgroundColor: const Color(0xFFE5E5E5),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFFB978)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 37.0),
                      SizedBox(
                        height: 263,
                        child: DefaultTabController(
                          length: 2, // 탭의 개수 설정
                          child: Column(
                            children: [
                              const TabBar(
                                indicatorColor: mainColor,
                                labelColor: mainColor,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                tabs: [
                                  Tab(text: '배달주문'),
                                  Tab(text: '직거래'),
                                ],
                              ),
                              Container(
                                height: 1,
                                color: const Color(0x10000000),
                              ),
                              const SizedBox(height: 19.0),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17.0, right: 17.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data['DeliveryDate']} 이내 발송예정',
                                                  style: deliveryText.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xFF4185ED)),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20.0),
                                                          ),
                                                          child: SizedBox(
                                                            height: 400,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 15.0, left: 33.0, right: 15.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      const Text('배송정보', style: TextStyle(
                                                                        fontSize: 20.0,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Colors.black
                                                                      ),),
                                                                      IconButton(
                                                                        icon: const Icon(Icons.close),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 5.0),
                                                                Container(
                                                                  color: const Color(0xFFEEEEEE),
                                                                  height: 1,
                                                                ),
                                                                const SizedBox(height: 23.0),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 33.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '${data['DeliveryDate']} 이내 발송예정',
                                                                        style: deliveryText.copyWith(
                                                                            fontWeight:
                                                                            FontWeight.w400,
                                                                            color: const Color(
                                                                                0xFF4185ED)),
                                                                      ),
                                                                      const SizedBox(height: 17.0),
                                                                      Text('배송비', style: textStyle.copyWith(fontWeight: FontWeight.w600),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(deliveryfee[0], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(deliveryfee[1], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(deliveryfee[2], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 20.0),
                                                                      Text('배송방법', style: textStyle.copyWith(fontWeight: FontWeight.w600),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(deliveryMethod[0], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(deliveryMethod[1], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text('- ${deliveryMethod[2]}', style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                      const SizedBox(height: 17.0),
                                                                      Text('배송 가능 지역', style: textStyle.copyWith(fontWeight: FontWeight.w600),),
                                                                      const SizedBox(height: 7.0),
                                                                      Text(data['DeliveryArea'], style: textStyle.copyWith(fontWeight: FontWeight.w400),),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    '더보기',
                                                    style: deliveryText.copyWith(
                                                      fontWeight: FontWeight.w400,
                                                      color:
                                                          const Color(0xFF9F9C9C),
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 13.0),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('택배 배송',
                                                    style: deliveryText),
                                                const SizedBox(width: 5.0),
                                                SizedBox(
                                                  height: 21,
                                                  child: Image.asset(
                                                    "assets/Images/farmer/Delivery.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 7.0),
                                            Text(deliveryfee[0],
                                                style: deliveryText.copyWith(
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 21),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.black12,
                                              ),
                                              height: 81,
                                              width: 182,
                                            ),
                                            const SizedBox(height: 10.0),
                                            TransactionRow(
                                              textStyle: textStyle,
                                              location: data['Location'],
                                              img:
                                                  "assets/Images/farmer/Location.png",
                                              title: '위치 안내',
                                            ),
                                            const SizedBox(height: 8.0),
                                            TransactionRow(
                                              textStyle: textStyle,
                                              location: data['Phone'],
                                              img:
                                                  "assets/Images/farmer/PhoneCall.png",
                                              title: '전화 번호',
                                            ),
                                            const SizedBox(height: 8.0),
                                            TransactionRow(
                                              textStyle: textStyle,
                                              location: data['Hour'],
                                              img:
                                                  "assets/Images/farmer/Time.png",
                                              title: '운영 시간',
                                            ),
                                            const SizedBox(height: 8.0),
                                            TransactionRow(
                                              textStyle: textStyle,
                                              location: data['Payment'],
                                              img:
                                                  "assets/Images/farmer/CreditCard.png",
                                              title: '결제 방법',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
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
                      const SizedBox(height: 25.0),
                      ProductInfo(
                        programNumber: '$programNumber',
                        writer: widget.writer,
                      )
                    ],
                  ),
                );
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

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.textStyle,
    required this.location,
    required this.img,
    required this.title,
  });

  final String location;
  final String img;
  final TextStyle textStyle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            img,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          '$title    $location',
          style: textStyle.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.programNumber,
    required this.writer,
  });

  final String programNumber;
  final String writer;

  @override
  Widget build(BuildContext context) {
    CollectionReference productDetail =
        FirebaseFirestore.instance.collection('market1');

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: productDetail
          .doc('Farmer')
          .collection(programNumber)
          .doc(writer)
          .collection('Product')
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Text(
                  '전체 ${documents.length}',
                  style: const TextStyle(
                      color: Color(0xFF535353),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, right: 19.0),
                child: GridView.builder(
                  itemCount: documents.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18.0,
                    // mainAxisSpacing: 100.0,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(21.0),
                              child: Image.network(
                                data['image'],
                                width: double.infinity,
                                height: 166,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 22.0),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: SizedBox(
                                                    height: 41.78,
                                                    width: 41.78,
                                                    child: Image.asset(
                                                      "assets/Images/farmer/Success.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 25.07),
                                                const Text('장바구니 추가 성공!', style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF535353),
                                                ),),
                                                const SizedBox(height: 38),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(20.0),
                                                        bottomRight: Radius.circular(20.0),
                                                      ),
                                                      color: Color(0xFF98BD87),
                                                    ),
                                                    child: const Center(
                                                      child: Text("확인", style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w700,
                                                      ),),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 41.0,
                                  width: 41.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 16.0,
                                      width: 16.0,
                                      child: Image.asset(
                                        "assets/Images/const/Plus.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 11.0),
                        Text("[${data['title']}]"),
                        const SizedBox(height: 3.0),
                        Text(
                          "${data['price']}원",
                          style: const TextStyle(
                            color: Color(0xFF535353),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 7.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 13,
                              width: 13,
                              child: Image.asset(
                                "assets/Images/const/star.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "${data['star']}",
                              style: const TextStyle(
                                color: Color(0xFF929292),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "리뷰 ${data['review']}",
                              style: const TextStyle(
                                color: Color(0xFFC4C4C4),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
