import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:flutter/material.dart';

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({Key? key}) : super(key: key);

  @override
  State<MarketHomePage> createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {

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

  @override
  Widget build(BuildContext context) {

    CollectionReference marketDetail =
    FirebaseFirestore.instance.collection('market1');

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('TabBar Sample'),
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Text('과일'),
              ),
              Tab(
                icon: Text('채소'),
              ),
            ],
            indicatorColor: subColor,
            labelStyle: activeTabTextStyle,
            labelColor: subColor,
            unselectedLabelColor: const Color(0xFFCBD9C5),
            unselectedLabelStyle: notActiveTabTextStyle,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 22.0, right: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(15.5),
                          ),
                          child: const Center(
                              child: Text(
                            "기본순",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          height: 30,
                          width: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mainColor,
                              width: 1.5,
                            ),
                            color: null,
                            borderRadius: BorderRadius.circular(15.5),
                          ),
                          child: const Center(
                              child: Text(
                            "인기순",
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22.0),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: marketDetail
                          .doc('Market')
                          .collection('Fruit')
                          .get(),
                      builder:
                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          return GridView.builder(
                            itemCount: documents.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14.0,
                              childAspectRatio: 0.9,
                              mainAxisSpacing: 16.0,
                            ),
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                              final arrays = documents.map((doc) => doc['tag'].join(' # ')).toList();
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x25494949),
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14.0),
                                        topRight: Radius.circular(14.0),
                                      ),
                                      child: Image.network(
                                        data['image'],
                                        width: double.infinity,
                                        height: 105,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 9.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(data['title'], style: titleTextStyle),
                                          const SizedBox(width: 11.0),
                                          SizedBox(
                                            height : 14.0,
                                            width: 14.0,
                                            child: Image.asset(
                                              "assets/Images/const/star.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 3.0),
                                          Text('${data['star']}', style: titleTextStyle.copyWith(fontSize: 11.0,)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '# ${arrays[index]}',
                                        style: titleTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                                        softWrap: true,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 22.0, right: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(15.5),
                          ),
                          child: const Center(
                              child: Text(
                                "기본순",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          height: 30,
                          width: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mainColor,
                              width: 1.5,
                            ),
                            color: null,
                            borderRadius: BorderRadius.circular(15.5),
                          ),
                          child: const Center(
                              child: Text(
                                "인기순",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22.0),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: marketDetail
                          .doc('Market')
                          .collection('Vegetable')
                          .get(),
                      builder:
                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          return GridView.builder(
                            itemCount: documents.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14.0,
                              childAspectRatio: 0.9,
                              mainAxisSpacing: 16.0,
                            ),
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                              final arrays = documents.map((doc) => doc['tag'].join(' # ')).toList();
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x25494949),
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14.0),
                                        topRight: Radius.circular(14.0),
                                      ),
                                      child: Image.network(
                                        data['image'],
                                        width: double.infinity,
                                        height: 105,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 9.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(data['title'], style: titleTextStyle),
                                          const SizedBox(width: 11.0),
                                          SizedBox(
                                            height : 14.0,
                                            width: 14.0,
                                            child: Image.asset(
                                              "assets/Images/const/star.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 3.0),
                                          Text('${data['star']}', style: titleTextStyle.copyWith(fontSize: 11.0,)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '# ${arrays[index]}',
                                        style: titleTextStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                                        softWrap: true,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}