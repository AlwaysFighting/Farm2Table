import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2table/Const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'scrapbutton.dart';

class Category extends StatefulWidget{
  final String? id;
  const Category({Key? key, required this.id}):super(key:key);

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category>{
  List<String> _scrapProductIds=[];
  late String id;
  late CollectionReference product;
  @override
  void initState(){
    super.initState();
    id=widget.id!;
    product = FirebaseFirestore.instance.collection('${id}');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          //이전화면에서 보여줄 이미지 정보 받아오기
          Image.asset('assets/Images/home_images/${id}.png',fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.28 ),
          fruitlist(),
        ],
      ),
    );
}


  Widget fruitlist(){
    return Container(
      padding: EdgeInsets.fromLTRB(15, 30, 23, 30),
      height: MediaQuery.of(context).size.height*0.72,
      //데이터가 업데이트되면 실시간으로 데이터를 보여주기 위함
      child: StreamBuilder(
        stream: product.snapshots(),
        //불러온 데이터를 ui에 그려주기 위함
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  final isTapped = _scrapProductIds.contains(documentSnapshot.id);
                  return GestureDetector(
                    onTap: (){/*상품 상세페이지로 연결*/},
                    child: ListTile(
                      leading: ClipRRect
                        (borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/Images/home_images/${id}detail_${index}.png', width: MediaQuery.of(context).size.width*0.18,height:MediaQuery.of(context).size.height*0.08)),
                      title: Text(documentSnapshot['productName'],
                      style: TextStyle(fontSize: 15),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Text(documentSnapshot['productMarket'],
                            style: TextStyle(fontSize: 10),),
                          SizedBox(height: 5,),
                          Text('${documentSnapshot['productPrice'].toString()}원',
                            style: TextStyle(fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: textColor4),),
                        ],
                      ),
                      trailing: ScrapButton(
                        isTapped: isTapped,
                        onTap: (){
                          setState(() {
                            if(isTapped){
                              _scrapProductIds.remove(documentSnapshot.id);
                            }else{
                              _scrapProductIds.add(documentSnapshot.id);
                            }
                          });
                        },
                      )
                    ),
                  );
                });
          }
          else{
            return Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }
      },
      ),
    );
  }
}