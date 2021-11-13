import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/order_in_farm_model.dart';
import 'package:farmer_app/Providers/farm_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class OwnerOrderCard extends StatelessWidget {
  OrderInFarm order;
  String farmId;
  int index;
  OwnerOrderCard({required this.order , required this.farmId, required this.index});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: size.width*0.4,
                height: size.height*0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(order.productImage),
                      fit: BoxFit.fill,
                    )
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.productName , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text('${order.price} LE' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                Text('Q : ${order.quantity}' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                Text('Total: ${order.totalPrice} LE' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),

                Container(
                    width: size.width*0.45,
                    child: FlatButton(onPressed: () async {
                      await FirebaseFirestore.instance.collection('Farm').doc(farmId).collection(farmId).doc(order.docId).update(
                        {
                          'status' : 'Accepted'
                        }
                      ).then((value) {
                        Provider.of<FarmData>(context,listen: false).removeFromOrders(index);
                      });
                    }, child: const Text('Accept' , style:  TextStyle(color: Colors.white),) , color: Kcolor,)),
                Container(
                    width: size.width*0.45,
                    child: FlatButton(onPressed: () async {
                      await FirebaseFirestore.instance.collection('Farm').doc(farmId).collection(farmId).doc(order.docId).update(
                          {
                            'status' : 'Refused'
                          }
                      ).then((value) {
                        Provider.of<FarmData>(context,listen: false).removeFromOrders(index);
                      });
                    }, child: const Text('Refused' , style:  TextStyle(color: Colors.white),) , color: Colors.redAccent,)),

              ],
            ),
          ],
        ),
      ),
    );

  }
}
