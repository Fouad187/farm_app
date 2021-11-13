import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Screens/User/product_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';


class ProductCard extends StatelessWidget {
  FarmProduct product;
  ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDescription(product: product,),));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            width: 155,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: product.image,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding:const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name , style:const TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                    /* Row(
                        children: [
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                        ],
                      ),

                     */
                      Text('${product.farmName} Farm' , style: const TextStyle(color: Colors.grey),),
                      Text(product.color, style: const TextStyle(color: Colors.grey),),
                      Text('${product.price} LE' , style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      const SizedBox(height: 5,),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
