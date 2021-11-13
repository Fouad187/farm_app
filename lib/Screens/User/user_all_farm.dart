import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Services/user_services.dart';
import 'package:farmer_app/Widgets/farm_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class UserAllFarmsScreen extends StatefulWidget {
  static String id='UserAllFarmsScreenid';

  @override
  State<UserAllFarmsScreen> createState() => _UserAllFarmsScreenState();
}

class _UserAllFarmsScreenState extends State<UserAllFarmsScreen> {
  List<Farm>? farms;
  UserServices userServices=UserServices();
  String selectedcity='All';
  getcinema() async
  {
    farms=await userServices.getFarmByCity(selectedcity);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcinema();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Farms'),
          centerTitle: true,
          backgroundColor: Kcolor,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10,left: 20 ,right: 20),
          children: [
            Row(
              children: [
                const Text('Filter by city : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                DropdownButton(items: getitem(allcities), value:selectedcity, onChanged: (dynamic value){
                  setState(() {
                    selectedcity=value;
                    getcinema();
                  });
                }),
              ],
            ),
            farms != null ?
            Column(
              children: farms!.map((e) => FarmCard(farm: e,)).toList(),
            ) : Container(),
          ],
        )
    );
  }
}
