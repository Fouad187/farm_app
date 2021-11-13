import 'package:farmer_app/Models/order_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class UserOrderScreen extends StatelessWidget {
  static String id='UserOrderScreenId';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        centerTitle: true,
        backgroundColor: Kcolor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return UserOrderCard(order:Provider.of<UserData>(context).orders[index]);
        },
        itemCount: Provider.of<UserData>(context).orders.length,
      ),
    );
  }
}

class UserOrderCard extends StatelessWidget {
  Order order;
  UserOrderCard({required this.order});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(order.userName , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('Total: ${order.totalPrice} LE' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(order.address , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(order.date.toString() , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }
}
