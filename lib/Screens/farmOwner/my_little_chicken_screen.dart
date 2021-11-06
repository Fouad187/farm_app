import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Widgets/my_chickens_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class MyLittleChickenScreen extends StatelessWidget {
  static String id='MyLittleChickenScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: const Text('Eggs'),
      ),
      body:  ListView.builder(
        itemBuilder: (context, index) {
          return MyChickensWidget(chicken : Provider.of<UserData>(context).myLittleChickens[index] , index: index,isChicken: false,);
        },
        itemCount: Provider.of<UserData>(context).myLittleChickens.length,
      ),
    );

  }
}
