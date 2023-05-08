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

  var programRatings = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const _AppBar(),
          ];
        },
        body: _body(titleStyle: titleStyle, programRatings: programRatings),
      ),
      bottomNavigationBar: _bottom(titleStyle: titleStyle),
    );
  }
}

class _body extends StatelessWidget {
  const _body({
    super.key,
    required this.titleStyle,
    required this.programRatings,
  });

  final TextStyle titleStyle;
  final double programRatings;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                const _divider(),
              ],
            ),
            const SizedBox(height: 45.0),
            Image.asset(
              'assets/Images/market/orangeBody.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 80.0),
            const _divider(),
            const SizedBox(height: 23.0),
            program_reviews(titleStyle: titleStyle, programRatings: programRatings),
            const SizedBox(height: 40.0),
            const _divider(),
            _inquiry(titleStyle: titleStyle),
          ],
        ),
      ),
    );
  }
}

class _inquiry extends StatelessWidget {
  const _inquiry({
    super.key,
    required this.titleStyle,
  });

  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "문의",
            style: titleStyle.copyWith(
              color: subColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {
              print(">");
            },
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20.0,
              color: Color(0xFF949494),
            ),
          )
        ],
      ),
    );
  }
}

class program_reviews extends StatelessWidget {
  const program_reviews({
    super.key,
    required this.titleStyle,
    required this.programRatings,
  });

  final TextStyle titleStyle;
  final double programRatings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "프로그램 후기",
                style: titleStyle.copyWith(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: subColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  "누적 참가자 : 2000명 ",
                  style: titleStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: subColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Images/const/star.png',
                height: 23.0,
                width: 23.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10.0),
              Text(
                "4.3",
                style: titleStyle.copyWith(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF747373),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                "(1,500)",
                style: titleStyle.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF747373),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                programChat(
                    titleStyle: titleStyle,
                    programRatings: programRatings),
                programChat(
                    titleStyle: titleStyle,
                    programRatings: programRatings),
                programChat(
                    titleStyle: titleStyle,
                    programRatings: programRatings),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: SizedBox(
                width: 324,
                child: ElevatedButton(
                  onPressed: () {
                    print("후기 바로가기");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  child: Text(
                    "후기 1,500개 모두 보기",
                    style: titleStyle.copyWith(
                      color: textColor1,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _bottom extends StatelessWidget {
  const _bottom({
    super.key,
    required this.titleStyle,
  });

  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 4.0,
            offset: Offset(0, 1),
            color: Color(0x25535353),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2023년 6월 1일 13:00",
                  style: titleStyle.copyWith(
                    color: textColor1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "예치금 : 2000원",
                  style: titleStyle.copyWith(
                    color: textColor1,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(width: 55),
            Center(
              child: SizedBox(
                width: 169,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: subColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  onPressed: () {
                    print("참가하기");
                  },
                  child: Text(
                    "참가하기",
                    style: titleStyle.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _divider extends StatelessWidget {
  const _divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        color: Color(0xFFE5E5E5),
      ),
    );
  }
}

class programChat extends StatelessWidget {
  const programChat({
    super.key,
    required this.titleStyle,
    required this.programRatings,
  });

  final TextStyle titleStyle;
  final double programRatings;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 176,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: null,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " SWU",
              style: titleStyle.copyWith(
                color: const Color(0xFF747373),
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 3.0),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        i < programRatings.floor()
                            ? Icons.star
                            : i - programRatings < 0.5
                                ? Icons.star_half
                                : Icons.star_border,
                        color: ratingColor,
                        size: 17,
                      ),
                    const SizedBox(width: 4.0),
                    Text(
                      "2022.06.07",
                      style: titleStyle.copyWith(
                        color: const Color(0xFFAEAEAE),
                        fontSize: 8.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
                Text(
                  "신선하고 색다른 경험",
                  style: titleStyle.copyWith(
                    color: textColor1,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "제주 감귤 따기 체험을 하러 갔는데, 생각보다 너무 재미있었습니다...",
                  style: titleStyle.copyWith(
                    color: textColor1,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
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
