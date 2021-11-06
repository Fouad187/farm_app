import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';


class AllFarmsCard extends StatelessWidget {
  Farm farm;
  int index;
  AllFarmsCard({required this.farm , required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5 , left: 12 , right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farm.farmName, style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                    const SizedBox(height: 10,),
                    Text(farm.address , style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                    const SizedBox(height: 10,),
                    Text(farm.rating, style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () async{
                    try {

                      AdminServices adminServices=AdminServices();
                      await adminServices.deleteFarm(farm.id);
                      Provider.of<UserData>(context,listen: false).removeFromAllFarm(index);
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
