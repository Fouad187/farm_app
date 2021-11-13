import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Providers/farm_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class MyEggsWidget extends StatelessWidget {
  FarmProduct egg;
  int index;
  MyEggsWidget({required this.egg , required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding:  const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(egg.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(egg.name,  style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),),
                    Text(egg.color, style: const TextStyle(color: Colors.grey),),
                    const SizedBox(height: 10,),

                    Text('${egg.price} LE ', style: const TextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                  onTap: () async{
                    try {
                      await FirebaseFirestore.instance.collection(
                          'Eggs').doc(egg.docId).delete();
                      Provider.of<FarmData>(context,listen: false).removeFromEggs(index);
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
