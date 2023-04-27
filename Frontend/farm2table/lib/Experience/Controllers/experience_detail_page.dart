import 'package:flutter/material.dart';

import '../../Const/colors.dart';

class ExperienceDetailPage extends StatefulWidget {
  const ExperienceDetailPage({Key? key}) : super(key: key);

  @override
  State<ExperienceDetailPage> createState() => _ExperienceDetailPageState();
}

class _ExperienceDetailPageState extends State<ExperienceDetailPage> {
  final titleStyle = const TextStyle(
    color: alarmColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const _AppBar(),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
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
                            style: TextButton.styleFrom(textStyle: titleStyle),
                            child: const Text("작성자 : 제주 감귤 농부"),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "[제주 감귤 재배하기]",
                                style: titleStyle.copyWith(
                                  color: const Color(0xFF7C7C7C),
                                  fontSize: 26.0,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                "(마감 2일 전)",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/Images/const/star.png',
                                    height: 17.0,
                                    width: 20.0,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    "4.3",
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
                                    "현재 : 24/30 명",
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
                    Container(
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
                    ),
                  ],
                ),
                const SizedBox(height: 45.0),
                Image.asset(
                  'assets/Images/market/orangeBody.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 221.0,
      pinned: true,
      foregroundColor: Colors.white,
      backgroundColor: subColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/Images/market/orangeMarketBanner1.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
