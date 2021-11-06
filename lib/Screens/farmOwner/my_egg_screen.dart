import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Widgets/my_egg_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class MyEggScreen extends StatelessWidget {
  static String id='MyEggScreenId';
  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserData>(context).user;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: const Text('Eggs'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            print(Provider.of<UserData>(context).myEggs[index].docId);
            return MyEggsWidget(egg: Provider.of<UserData>(context).myEggs[index] , index: index,);
          },
          itemCount: Provider.of<UserData>(context).myEggs.length,
        ),
    );
  }
}
