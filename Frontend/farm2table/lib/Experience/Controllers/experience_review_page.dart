import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Const/colors.dart';

class ExReviewPage extends StatefulWidget {
  const ExReviewPage({Key? key}) : super(key: key);

  @override
  State<ExReviewPage> createState() => _ExReviewPageState();
}

class _ExReviewPageState extends State<ExReviewPage> {
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
  Widget build(BuildContext context) {
    CollectionReference experienceDetail =
        FirebaseFirestore.instance.collection('market1');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: const Color(0xFF7C7C7C),
        backgroundColor: Colors.white,
        title: const Text(
          "프로그램 후기",
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: experienceDetail
            .doc('Experience')
            .collection('Program')
            .doc('1')
            .collection('reviews')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('ERROR'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.only(left: 17.0, right: 17.0, top: 18.0),
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 254,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD9D9D9),
                              width: 1,
                            ),
                            color: null,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, right: 12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        data['image'],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 6.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data['nickname'], style: textStyle,),
                                        Row(
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
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
