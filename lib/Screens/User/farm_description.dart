import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Services/owner_services.dart';
import 'package:farmer_app/Widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
class FarmDescription extends StatefulWidget {
  Farm farm;
  FarmDescription({required this.farm});

  @override
  State<FarmDescription> createState() => _FarmDescriptionState();
}

class _FarmDescriptionState extends State<FarmDescription> {
  List<FarmProduct> eggs=[];
  List<FarmProduct> chickens=[];
  List<FarmProduct> littleChickens=[];
  OwnerServices ownerServices=OwnerServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async
  {
    eggs=await ownerServices.getMyEggs(farmId:  widget.farm.id);
    chickens=await ownerServices.getMyChickens(farmId:  widget.farm.id);
    littleChickens=await ownerServices.getMyLittleChickens(farmId:  widget.farm.id);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(widget.farm.farmName),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.farm.id,
            child: Container(
              height: 200,
              child: const Image(image: AssetImage('assets/images/farm.jpg') , fit: BoxFit.fill,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.farm.farmName , style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.location_on , color: Kcolor,),
                    const SizedBox(width: 10,),
                    Text(widget.farm.address , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.rate_review , color: Kcolor,),
                    const SizedBox(width: 10,),
                    Text(widget.farm.rating , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                    const SizedBox(width: 5,),
                    const Text('Rating', style:  TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.favorite , color: Kcolor,),
                    const SizedBox(width: 10,),
                    const Text('Accepted by Admin', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 20,),
                const Text('Farm Chickens', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                chickens !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chickens.length,
                    itemBuilder: (context, index) {
                      if(chickens.length==0)
                      {
                        return const Center(child: Text('The Farm didnt have any chickens yet'),);
                      }
                      else
                      {
                        return ProductCard( product : chickens[index],);
                      }
                    },),
                ) : Container(),
                const SizedBox(height: 20,),
                const Text('Farm Eggs', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                eggs !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eggs.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: eggs[index],);
                    },),
                ) : Container(),
                const SizedBox(height: 20,),
                const Text('Farm Little Chickens', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                littleChickens !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: littleChickens.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: littleChickens[index],);
                    },),
                ) : Container(),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
