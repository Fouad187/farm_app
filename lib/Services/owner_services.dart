import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/chicken_model.dart';
import 'package:farmer_app/Models/egg_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class OwnerServices
{

  void addNewEgg({required String name, required String description ,required String price, required File image ,required String color, context}) async
  {
    UserModel? user=Provider.of<UserData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Egg_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    Egg egg=Egg(
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
    UserModel? user=Provider.of<UserData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Chicken_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    Chicken chicken=Chicken(
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
    UserModel? user=Provider.of<UserData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Little_photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    Chicken chicken=Chicken(
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

  Future<List<Egg>> getMyEggs({required String farmId}) async
  {
    List<Egg> eggs=[];
    await FirebaseFirestore.instance.collection('Eggs').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {

        eggs.add(Egg.fromJson(value.docs[i].data()));
        eggs[i].docId=value.docs[i].id;
      }

    });


    return eggs;
  }
  Future<List<Chicken>> getMyChickens({required String farmId}) async
  {
    List<Chicken> chickens=[];
    await FirebaseFirestore.instance.collection('Chickens').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        chickens.add(Chicken.fromJson(value.docs[i].data()));
        chickens[i].docId=value.docs[i].id;

      }

    });


    return chickens;
  }
  Future<List<Chicken>> getMyLittleChickens({required String farmId}) async
  {
    List<Chicken> littleChickens=[];
    await FirebaseFirestore.instance.collection('Little').where('id' , isEqualTo: farmId).get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        littleChickens.add(Chicken.fromJson(value.docs[i].data()));
        littleChickens[i].docId=value.docs[i].id;

      }

    });


    return littleChickens;
  }
}