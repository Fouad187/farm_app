import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Screens/User/farm_description.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class FarmCard extends StatelessWidget {
  Farm farm;
  FarmCard({required this.farm});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => FarmDescription(farm: farm,),));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom:10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Hero(
                tag: farm.id,
                child: Container(
                  height: 200,
                  //width: MediaQuery.of(context).size.width-40,
                  child: Image.asset('assets/images/farm.jpg',fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                left: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 100,
                  //width: MediaQuery.of(context).size.width-40,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.black12,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                      )
                  ),
                ),
              ),
              Positioned(
                left: 10.0,
                bottom: 10.0,
                right: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(farm.farmName , style: const TextStyle(color: Colors.white , fontSize: 18 ,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Text(farm.address , style: const TextStyle(color: Colors.white , fontSize: 15),),
                        Row(
                          children: [
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            const SizedBox(width: 10,),
                            Text('(${farm.rating} Reviews)' , style: const TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
