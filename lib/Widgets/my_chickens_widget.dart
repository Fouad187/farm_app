import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/chicken_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';


class MyChickensWidget extends StatelessWidget {
  Chicken chicken;
  int index;
  bool isChicken;
  MyChickensWidget({required this.chicken , required this.index , required this.isChicken});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(chicken.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chicken.name,  style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),),
                    Text(chicken.color, style: const TextStyle(color: Colors.grey),),
                    const SizedBox(height: 10,),

                    Text('${chicken.price} LE ', style: const TextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                  onTap: () async{
                    try {
                      if(isChicken)
                      {
                        await FirebaseFirestore.instance.collection(
                            'Chickens').doc(chicken.docId).delete();
                        Provider.of<UserData>(context,listen: false).removeFromChickens(index);
                      }
                      else
                      {
                        await FirebaseFirestore.instance.collection(
                            'Little').doc(chicken.docId).delete();
                        Provider.of<UserData>(context, listen: false)
                            .removeFromLittle(index);
                      }
                    }
                    catch (e)
                    {
                      print(e);
                    }
                  },
                  child: Icon(Icons.delete , color: Kcolor,)),

            ],
          ),
        ),
      ),
    );

  }
}
