import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/order_in_farm_model.dart';
import 'package:farmer_app/Models/order_model.dart';
import 'package:flutter/cupertino.dart';

class UserServices
{

  Future<List<FarmProduct>> getNewEggs() async
  {
    List<FarmProduct> eggs=[];
    await FirebaseFirestore.instance.collection('Eggs').limit(8).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {

        eggs.add(FarmProduct.fromJson(value.docs[i].data()));
        eggs[i].docId=value.docs[i].id;
      }

    });


    return eggs;
  }
  Future<List<FarmProduct>> getNewChickens() async
  {
    List<FarmProduct> chickens=[];
    await FirebaseFirestore.instance.collection('Chickens').limit(5).get().then((value) async {
      for(int i = 0; i < value.docs.length; i++)
      {
        chickens.add(FarmProduct.fromJson(value.docs[i].data()));
        chickens[i].docId=value.docs[i].id;

      }
      await getNewLittleChickens().then((value) {
        chickens.addAll(value);
      });
    });


    return chickens;
  }
  Future<List<FarmProduct>> getNewLittleChickens() async
  {
    List<FarmProduct> littleChickens=[];
    await FirebaseFirestore.instance.collection('Little').limit(5).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        littleChickens.add(FarmProduct.fromJson(value.docs[i].data()));
        littleChickens[i].docId=value.docs[i].id;

      }

    });


    return littleChickens;
  }

  static Future<List<FarmProduct>> getAllProductsByName({required String name}) async
  {
    List<FarmProduct> product=[];
    await FirebaseFirestore.instance.collection(name).get().then((value) => {

      for(int i=0 ; i<value.docs.length; i++)
        {
          product.add(FarmProduct.fromJson(value.docs[i].data())),
        }

    });
    return product;
  }
  Future<List<Farm>> getPopularFarms() async
  {
    List<Farm> farms=[];
    await FirebaseFirestore.instance.collection('Farm').where('status' , isEqualTo: 'Accepted').limit(8).get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        farms.add(Farm.fromJson(value.docs[i].data()));
      }
    });
    return farms;
  }
  Future<List<Farm>> getFarmByCity(String city) async
  {
    if(city=='All')
    {
      return getAllFarms();
    }
    else {
      List<Farm> farms=[];
      await FirebaseFirestore.instance.collection('Farm').where('status' , isEqualTo: 'Accepted').where('city', isEqualTo: city).get().then((value)
      {
        for(int i=0 ; i<value.docs.length ; i++)
        {
          farms.add(Farm.fromJson(value.docs[i].data()));
        }
      });
      return farms;
    }
  }
  Future<List<Farm>> getAllFarms() async
  {
    List<Farm> farms=[];
    await FirebaseFirestore.instance.collection('Farm').where('status' , isEqualTo: 'Accepted').get().then((value)
    {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        farms.add(Farm.fromJson(value.docs[i].data()));
      }
    });

    return farms;
  }
  static Future<void> makeOrder({required Order order}) async
  {
    await FirebaseFirestore.instance.collection('Orders').doc().set(order.toJson()).then((value) async {
       for (var element in order.order) {
          OrderInFarm farmOrder=OrderInFarm(
              userId: order.userId,
              productId: element.id,
              productName: element.name,
              totalPrice: element.totalPrice!,
              quantity: element.quantity!,
              price: element.price,
              productImage: element.image,
              status: 'In Review',
          );
          await orderInFarm(orderInFarm: farmOrder, id: element.id);
       }
    });
  }
  static Future<void> orderInFarm({required OrderInFarm orderInFarm , required String id}) async
  {
    await FirebaseFirestore.instance.collection('Farm').doc(id).collection(id).doc().set(orderInFarm.toJson());
  }
  static Future<List<Order>> getMyOrders({required String userId}) async
  {
    List<Order> orders=[];
    await FirebaseFirestore.instance.collection('Orders').where('userId' , isEqualTo: userId).get().then((value){
      for(int i=0 ; i<value.docs.length ; i++)
      {
        orders.add(Order.fromJson(value.docs[i].data()));
      }
    });
    return orders;
  }
}