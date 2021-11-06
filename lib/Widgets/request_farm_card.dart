import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class RequestFarmCard extends StatelessWidget {
  Farm farm;
  int index;

  RequestFarmCard({required this.farm , required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children:[
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage('assets/images/farmlogo.png'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farm.farmName, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                    const SizedBox(height: 10,),
                    Text(farm.address , style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                    const SizedBox(height: 10,),
                    Text(farm.rating, style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                  ],
                ),
              ],
            ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          'Farm').doc(farm.id).update(
                          {'status': 'Accepted'});
                      Provider.of<UserData>(context,listen:false).removeFromRequest(index);
                    },
                    child: const Text('Accept'),
                    color: Colors.green,
                  ),
                  const SizedBox(width: 15,),
                  FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          'Farm').doc(farm.id).update(
                          {'status': 'Refused'});
                      Provider.of<UserData>(context,listen:false).removeFromRequest(index);

                    },
                    child: const Text('Refused'),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
