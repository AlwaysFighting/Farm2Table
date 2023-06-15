import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2table/Const/colors.dart';
import 'scrapbutton.dart';
import 'productdetail.dart';

class Category extends StatefulWidget{
  final String id;
  const Category({Key? key, required this.id}):super(key:key);

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category>{
  final List<String> _scrapProductIds=[];
  late String id;
  late CollectionReference product;
  @override
  void initState(){
    super.initState();
    id=widget.id;
    product = FirebaseFirestore.instance.collection(id);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          //이전화면에서 보여줄 이미지 정보 받아오기
          Positioned(
            top: 0,
              left: 0,
              child: Image.asset('assets/Images/home_images/$id.png',fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.28 )),
          Positioned(
            top:50,left: 5,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset('assets/Images/const/back.png', width: 22,height: 22,),
            ),
          ),
          Positioned(
            top:MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
              bottom: 0,
              child: fruitlist())
        ],
      ),
    );
}


  Widget fruitlist(){
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 30, 23, 30),
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                       ProductDetail(id: widget.id,)));
                    },
                    child: ListTile(
                      leading: ClipRRect
                        (borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/Images/home_images/${id}detail_$index.png', width: MediaQuery.of(context).size.width*0.18,height:MediaQuery.of(context).size.height*0.08)),
                      title: Text(documentSnapshot['productName'],
                      style: const TextStyle(fontSize: 15),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5,),
                          Text(documentSnapshot['productMarket'],
                            style: const TextStyle(fontSize: 10),),
                          const SizedBox(height: 5,),
                          Text('${documentSnapshot['productPrice'].toString()}원',
                            style: const TextStyle(fontSize: 13,
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
            return const Center(
              child: SizedBox(
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