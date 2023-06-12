import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Const/colors.dart';
import '../../Const/custom_back.dart';

class ExperienceCategory extends StatefulWidget {
  const ExperienceCategory({Key? key, required this.index, required this.title}) : super(key: key);
  final int index;
  final String title;

  @override
  State<ExperienceCategory> createState() => _ExperienceCategoryState();
}

class _ExperienceCategoryState extends State<ExperienceCategory> {

  final activeTabTextStyle = const TextStyle(
    color: subColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  final notActiveTabTextStyle = const TextStyle(
    color: Color(0xFFCBD9C5),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  final titleTextStyle = const TextStyle(
    color: Color(0xFF535353),
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

  @override
  Widget build(BuildContext context) {

    CollectionReference categoryDetail =
    FirebaseFirestore.instance.collection('market1');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const CustomBackButton(),
        elevation: 0,
        title: Text(widget.index == 0 ? "과일" : "채소", style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Color(0xFF7C7C7C),
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 22.0, right: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: categoryDetail
                    .doc('Experience')
                    .collection(widget.title)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14.0,
                        childAspectRatio: 0.88,
                        mainAxisSpacing: 16.0,
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
                                  onTap: () {},
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
                                                data['image'],
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
                                                '[${data["title"]}]',
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
      ),
    );
  }
}
