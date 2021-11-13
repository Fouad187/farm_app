import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Models/order_in_farm_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/farm_data.dart';
import 'package:farmer_app/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class OwnerServices
{

  void addNewEgg({required String name, required String description ,required String price, required File image ,required String color, context}) async
  {
    UserModel? user=Provider.of<FarmData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Egg_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    FarmProduct egg=FarmProduct(
      id: user!.id,
      farmName: user.name,
      name: name,
      description: description,
      image: url,
      color: color,
      price: price,
      status: 'Accepted',
    );


    await FirebaseFirestore.instance.collection('Eggs').doc().set(egg.toJson());

  }
  void addNewChicken({required String name, required String price,required String description ,required String color, required File image , context}) async
  {
    UserModel? user=Provider.of<FarmData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Chicken_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    FarmProduct chicken=FarmProduct(
      id: user!.id,
      farmName: user.name,
      name: name,
      description: description,
      image: url,
      color: color,
      price: price,
      status: 'Accepted',
    );


    await FirebaseFirestore.instance.collection('Chickens').doc().set(chicken.toJson());

  }
  void addNewLittle({required String name, required String price,required String description ,required String color,required File image , context}) async
  {
    UserModel? user=Provider.of<FarmData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Little_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    FarmProduct chicken=FarmProduct(
      id: user!.id,
      farmName: user.name,
      name: name,
      description: description,
      image: url,
      color: color,
      price: price,
      status: 'Accepted',
    );


    await FirebaseFirestore.instance.collection('Little').doc().set(chicken.toJson());

  }

  Future<List<FarmProduct>> getMyEggs({required String farmId}) async
  {
    List<FarmProduct> eggs=[];
    await FirebaseFirestore.instance.collection('Eggs').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {

        eggs.add(FarmProduct.fromJson(value.docs[i].data()));
        eggs[i].docId=value.docs[i].id;
      }

    });


    return eggs;
  }
  Future<List<FarmProduct>> getMyChickens({required String farmId}) async
  {
    List<FarmProduct> chickens=[];
    await FirebaseFirestore.instance.collection('Chickens').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        chickens.add(FarmProduct.fromJson(value.docs[i].data()));
        chickens[i].docId=value.docs[i].id;

      }

    });


    return chickens;
  }
  Future<List<FarmProduct>> getMyLittleChickens({required String farmId}) async
  {
    List<FarmProduct> littleChickens=[];
    await FirebaseFirestore.instance.collection('Little').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        littleChickens.add(FarmProduct.fromJson(value.docs[i].data()));
        littleChickens[i].docId=value.docs[i].id;

      }

    });


    return littleChickens;
  }

  Future<List<OrderInFarm>> getMyOrders({required String farmId}) async {
    List<OrderInFarm> orders=[];
    await FirebaseFirestore.instance.collection('Farm').doc(farmId).collection(farmId).where('status' , isEqualTo: 'In Review').get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        orders.add(OrderInFarm.fromJson(value.docs[i].data()));
        orders[i].docId=value.docs[i].id;
      }
    });

    return orders;
  }
}