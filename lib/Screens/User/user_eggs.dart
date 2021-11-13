import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Services/user_services.dart';
import 'package:farmer_app/Widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class UserAllEggsScreen extends StatelessWidget {
  static String id='UserAllEggsScreenId';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Eggs'),
        centerTitle: true,
        backgroundColor: Kcolor,
      ),
      body: FutureBuilder<List<FarmProduct>>(
        future: UserServices.getAllProductsByName(name: 'Eggs'),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5 ,
                  childAspectRatio:0.7,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: snapshot.data![index],);
                },
              ),
            );
          }
          else
          {
            return Center(child: Text('Loading.....'));
          }
        },
      ),
    );

  }
}
