import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Widgets/my_chickens_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class MyChickensScreen extends StatelessWidget {
  static String id='MyChickenScreenID';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: const Text('Chickens'),
      ),
      body:  ListView.builder(
        itemBuilder: (context, index) {
          return MyChickensWidget(chicken : Provider.of<UserData>(context).myChickens[index] , index: index, isChicken: true,);
        },
        itemCount: Provider.of<UserData>(context).myChickens.length,
      ),
    );

  }
}
