import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2table/Const/colors.dart';

class ProductDetail extends StatefulWidget{
  final String id;
  const ProductDetail({Key? key, required this.id}):super(key:key);
  @override
  State<ProductDetail> createState() => ProductDetailState();
}
//상품이름,가격,마켓정보
class ProductDetailState extends State<ProductDetail>{
  bool isscrap = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //수량선택 아이템
  final count_value_list = ['수량선택','1','2','3','4','5'];
  String select_count = '수량선택';
  //수령 방식 선택 아이템
  final receive_value_list=['수령 방식 선택','직거래','택배'];
  String receive_method = '수령 방식 선택';
  late String imageurl;
  late String productName;
  late String marketName;
  late int price;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: list(),
          ),
          bottomsheet(),
        ],
      )
    );
  }
  Widget list(){
    return Scaffold(
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection(widget.id).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  final data = streamSnapshot.data!.docs;
                  if(data.isNotEmpty){
                    imageurl = (data[0].data() as Map<String, dynamic>)['productImage'];
                    marketName = (data[0].data() as Map<String, dynamic>)['productMarket'];
                    productName = (data[0].data() as Map<String, dynamic>)['productName'];
                    price = (data[0].data() as Map<String, dynamic>)['productPrice'];
                    final detailImage1 = (data[0].data() as Map<String, dynamic>)['detailImage1'];
                    final detailImage2 =(data[0].data() as Map<String, dynamic>)['detailImage2'];
                    return ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width*0.6,
                              child: imageurl != null ? Image.network(imageurl,fit: BoxFit.cover,) : const SizedBox(),
                            ),
                            const SizedBox(height: 17,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                              child: GestureDetector(
                                onTap: (){
                                  //마켓화면으로
                                },
                                child: Text(
                                  marketName,
                                  style: const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                              child: Text(
                                productName,
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(height: 9,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                              child: Text(
                                '$price',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: textColor4,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(19, 0, 23, 0),
                              child: SizedBox(
                                width:MediaQuery.of(context).size.width,
                                height: 346,
                                child: detailImage1 != null ? Image.network('$detailImage1',fit: BoxFit.cover,) : const SizedBox(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(19, 32, 23, 0),
                              child: SizedBox(
                                width:MediaQuery.of(context).size.width,
                                height: 346,
                                child: detailImage2 != null ? Image.network('$detailImage2',fit: BoxFit.cover,) : const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  else{
                    return const Text('no data');
                  }
                }
                else{
                  return const CircularProgressIndicator();
                }
              }
          ),
        )
    );
  }
  Widget bottomsheet()
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.08,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Padding(//스크랩기능 수정하기
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: (){
                if(isscrap==false){
                  setState(() {
                    isscrap==true;
                  });
                }
              },
              child: isscrap == false ? Image.asset("assets/Images/scrap.png",width: 30,height: 30,) : Image.asset("assets/Images/const/star.png",width: 30,height: 30,)
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 9, 23, 5),
            child: SizedBox(
              width: 260,
              child: ElevatedButton(onPressed: (){showBottomSheet(context);},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(subColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                )
              ),
                child: const Text('구매하기',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
                ),),
            ),
          )
        ],
      ),
    );
  }

  void showBottomSheet(context){
    showModalBottomSheet(context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState)
            {
              return SizedBox(
                  height: MediaQuery.of(context).size.height*0.43,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: 348,
                        padding: const EdgeInsets.only(top: 18),
                        child: DropdownButtonFormField<String>(
                          value: select_count,
                          items: count_value_list.map(
                                  (value){
                                return DropdownMenuItem(value:value,
                                    child: Text(value,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),));
                              }
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              select_count = value!;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: subColor2,
                          ),
                          dropdownColor: subColor2,
                        ),
                      ),
                      Container(
                        width: 348,
                        padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                        child: DropdownButtonFormField<String>(
                          value: receive_method,
                          items: receive_value_list.map(
                                  (value){
                                return DropdownMenuItem(value:value,
                                    child: Text(value,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),));
                              }
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              receive_method = value!;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: subColor2,
                          ),
                          dropdownColor: subColor2,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            width: 174,
                            padding: const EdgeInsets.fromLTRB(19, 0, 4, 36),
                            child: ElevatedButton(onPressed: ()async{
                              saveDataToFirestore(imageurl, productName, marketName, price, select_count, receive_method);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('장바구니에 상품이 추가되었습니다.'))
                              );
                            },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(subColor2),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  )
                              ),
                              child: const Text('장바구니',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),),
                          ),
                          Container(
                            width: 174,
                            padding: const EdgeInsets.fromLTRB(0, 0, 19, 36),
                            child: ElevatedButton(onPressed: (){Navigator.pop(context);},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(subColor2),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  )
                              ),
                              child: const Text('구매하기',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),),
                          )
                        ],
                      )
                    ],
                  )
              );
            }
          );
        });
  }
  void saveDataToFirestore(String imageurl, String productName, String marketName, int price, String selectCount, String receiveMethod){
    CollectionReference cartCollection = firestore.collection('cart');
    DocumentReference docRef = cartCollection.doc(receiveMethod);
    Map<String,dynamic> data={
      'imageurl' : imageurl,
      'productName' : productName,
      'price' : price,
      'marketName' : marketName,
      'Price' : price,
      'selectCount' : selectCount,
      'receiveMethod' : receiveMethod,
    };
    docRef.set(data)
    .then((value)=> print('data added to firestore'))
        .catchError((error)=>print('Failed to add data:$error')
    );
  }




}