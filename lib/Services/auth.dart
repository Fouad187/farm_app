
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/model_hud.dart';
import 'package:farmer_app/Providers/farm_data.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Screens/Admin/admin_home_screen.dart';
import 'package:farmer_app/Screens/Auth/login_screen.dart';
import 'package:farmer_app/Screens/User/user_home_screen.dart';
import 'package:farmer_app/Screens/farmOwner/owner_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
class Auth
{

  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _userCollection=FirebaseFirestore.instance.collection('Users');
  final CollectionReference _farmCollection=FirebaseFirestore.instance.collection('Farm');



  void Signin({required String email , required String password , context}) async
 {
     await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
       _userCollection.doc(value.user!.uid).get().then((value2) {
         var type = (value2)['type'];
         UserModel userModel= UserModel(
           email: (value2)['email'],
           id: value.user!.uid,
           name: (value2)['name'],
           type: (value2)['type'],
           city: (value2)['city'],
         );
         final instance = Provider.of<Modelhud>(context, listen: false);

         if(type=='User')
           {
             Provider.of<UserData>(context , listen: false).setUser(userModel);
             Navigator.pushNamed(context, UserHomeScreen.id);
             instance.changeisLoading(false);
           }
         else if (type=='Farm Owner')
           {
             _farmCollection.doc(value.user!.uid).get().then((farma) {
               if((farma)['status']=='In Review')
                 {
                   _auth.signOut();
                   Fluttertoast.showToast(msg: 'Your Request In Review You can Login after accepted' , toastLength: Toast.LENGTH_LONG);
                   instance.changeisLoading(false);

                 }
               else {
                 Farm farm = Farm(
                   rating: (farma)['rating'],
                   address: (farma)['address'],
                   farmName: (farma)['farmName'],
                   image: (farma)['image'],
                   id: value.user!.uid,
                   status: (farma)['status'],
                   city: (farma)['city'],
                 );
                 Provider.of<FarmData>(context, listen: false).setFarm(
                     farm);
                 Provider.of<FarmData>(context, listen: false).setUser(userModel);
                 Navigator.pushNamed(context, OwnerHomeScreen.id);
                 instance.changeisLoading(false);
               }
             });
           }
         else
           {
             Provider.of<UserData>(context, listen: false).setUser(userModel);
             Navigator.pushNamed(context, AdminHomeScreen.id);
             instance.changeisLoading(false);
           }

       });
     });
 }
  Future<void> CreateAccount({required String name, required String email ,required String password, required String type ,required String city,context}) async {

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
        UserModel userModel=UserModel(
          id: user.user!.uid,
          name: name,
          email: email,
          type: type,
          city: city,
        );
        await Adduserdata(userModel);
        Provider.of<UserData>(context , listen: false).setUser(userModel);
      });

  }

  Future<void> Adduserdata(UserModel userModel) async {
    return await _userCollection.doc(userModel.id).set(userModel.toJson());
  }



  Future<void> createFarm({required String name,required String email ,required String password, required String type, required String address,required String rating,required String city , context}) async
  {

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
      UserModel usermodel=UserModel(
        id: user.user!.uid,
        name: name,
        email: email,
        type: type,
        city: city,
      );
      await Adduserdata(usermodel);
      Farm farm=Farm(
        id: user.user!.uid,
        rating: rating,
        image: 'mm',
        address: address,
        farmName: name,
        status: 'In Review',
        city: city,
      );
      await _farmCollection.doc(usermodel.id).set(farm.toJson());
      print(farm.farmName);
      //Provider.of<UserData>(context , listen: false).setUser(usermodel);
      Provider.of<FarmData>(context, listen: false).setFarm(farm);
    });

  }

  void signOut() async
  {
    await _auth.signOut();
  }


}