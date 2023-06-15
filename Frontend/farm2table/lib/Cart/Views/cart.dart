import 'package:flutter/material.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}):super(key:key);
  @override
  State<Cart> createState() => CartState();
}
class CartState extends State<Cart> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          //SizedBox(height: 29,),
          Expanded(child: tabview()),
        ],
      ),
    );
  }


  Widget tabview()
  {
    return DefaultTabController(length: 3,
        child: Scaffold(
          body: Column(
            children: [
              const TabBar(
                indicatorColor: subColor,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: subColor
                ),
                labelColor: subColor,
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    text: '직거래',
                  ),
                  Tab(
                    text: '택배',
                  ),
                  Tab(
                    text: '체험프로그램',
                  )
                ],
              ),
              Expanded(child: TabBarView(
                children: [
                  //직거래 화면
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('cart').doc('직거래').get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        //데이터 로딩중 화면
                        return const Center(child:CircularProgressIndicator());
                      }
                      if(snapshot.hasError){
                        //데이터 로딩중 오류 발생하는 경우
                        return const Center(child:Text('데이터를 불러오는 중에 오류가 발생했습니다.'));
                      }
                      if(!snapshot.hasData || snapshot.data!.data()==null){
                        //데이터가 없는 경우
                        return const Center(child: Text("장바구니에 상품이 없습니다."));
                      }
                      final data = snapshot.data!.data() as Map<String, dynamic>?;
                      if(data != null)
                        {
                          final imageurl = data['imageurl'];
                          final productName = data['productName'];
                          final marketName = data['marketName'];
                          final price = data['price'];
                          final receiveMethod = data['receiveMethod'];
                          final selectCount = int.parse(data['selectCount']);
                          final total = price * selectCount;
                          //직거래 데이터를 화면에 표시한다
                          return Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.fromLTRB(16, 26, 16, 0),
                                child: Container(
                                  width: 358,
                                  height: 169,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                        color: const Color(0xffD9D9D9),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 12,),
                                      Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Text(
                                            "$marketName",
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6,),
                                      Container(
                                        width: 358,
                                        height: 1,
                                        color:const Color(0xffD9D9D9),
                                      ),
                                      const SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          const SizedBox(width: 20,),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: const Color(0xffD9D9D9),
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:BorderRadius.circular(10),
                                             child: Image.network('$imageurl',fit: BoxFit.cover,),
                                            ),
                                          ),
                                          const SizedBox(width: 19,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("$productName",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                              const SizedBox(height: 5,),
                                              Text("$marketName",style:const TextStyle(fontSize: 10),),
                                              const SizedBox(height: 5,),
                                              Text("$total",style:const TextStyle(fontSize: 13,color: textColor4),),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 16,),
                                      Container(
                                        width: 358,
                                        height: 1,
                                        color:const Color(0xffD9D9D9),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                               Spacer(),
                              Row(
                                children: [
                                  const SizedBox(width: 10,),
                                  Text("총 $total원",
                                    style: const TextStyle(
                                      fontSize:13,
                                      color: textColor4,
                                    ),
                                  ),
                                  const SizedBox(width: 9,),
                                  SizedBox(
                                    width: 279,
                                    height: 41,
                                    child: ElevatedButton(onPressed: (){},
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(subColor),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                            )
                                        ),
                                        child: Text("구매하기",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                      else {
                        //데이터가 없는 경우
                        return const Center(child: Text("장바구니에 상품이 없습니다."));
                      }
                    },
                  ),
                  //택배
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('cart').doc('택배').get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        //데이터 로딩중 화면
                        return const Center(child:CircularProgressIndicator());
                      }
                      if(snapshot.hasError){
                        //데이터 로딩중 오류 발생하는 경우
                        return const Center(child:Text('데이터를 불러오는 중에 오류가 발생했습니다.'));
                      }
                      if(!snapshot.hasData || snapshot.data!.data()==null){
                        //데이터가 없는 경우
                        return const Center(child: Text("장바구니에 상품이 없습니다."));
                      }
                      final data = snapshot.data!.data() as Map<String, dynamic>?;
                      if(data != null)
                      {
                        final imageurl = data['imageurl'];
                        final productName = data['productName'];
                        final marketName = data['marketName'];
                        final price = data['price'];
                        final receiveMethod = data['receiveMethod'];
                        final selectCount = int.parse(data['selectCount']);
                        final total = price*selectCount;
                        //택배화면에 표시한다
                        return Column(
                          children: [
                            Padding(
                              padding:  const EdgeInsets.fromLTRB(16, 26, 16, 0),
                              child: Container(
                                width: 358,
                                height: 188,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0xffD9D9D9),
                                    ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        Text(
                                          "$marketName",
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6,),
                                    Container(
                                      width: 358,
                                      height: 1,
                                      color:const Color(0xffD9D9D9),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 20,),
                                        Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                              child:Image.network('$imageurl',fit: BoxFit.cover,),
                                          )
                                        ),
                                        const SizedBox(width: 19,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("$productName",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                            const SizedBox(height: 5,),
                                            Text("$marketName",style:const TextStyle(fontSize: 10),),
                                            const SizedBox(height: 5,),
                                            Text("$total",style:const TextStyle(fontSize: 13,color: textColor4),),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 34,),
                                    Container(
                                      width: 358,
                                      height: 1,
                                      color:const Color(0xffD9D9D9),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text("상품 금액 $total + 배송비 3,000원 = 총 ${total + 3000}원",
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                Text("총 $total원",
                                  style: const TextStyle(
                                    fontSize:13,
                                    color: textColor4,
                                  ),
                                ),
                                const SizedBox(width: 9,),
                                SizedBox(
                                  width: 279,
                                  height: 41,
                                  child: ElevatedButton(onPressed: (){},
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(subColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                          )
                                      ),
                                      child: Text("구매하기",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ],
                        );
                      }
                      else {
                        //데이터가 없는 경우
                        return const Center(child: Text("장바구니에 상품이 없습니다."));
                      }
                    },
                  ),
                  const Center(
                    child: Text('아직 장바구니에 상품이 없어요!',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }


}

