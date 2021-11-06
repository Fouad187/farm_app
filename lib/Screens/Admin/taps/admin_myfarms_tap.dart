import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Widgets/all_farms_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMyFarmsTap extends StatefulWidget {
  @override
  State<AdminMyFarmsTap> createState() => _AdminMyFarmsTapState();
}

class _AdminMyFarmsTapState extends State<AdminMyFarmsTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarms();
  }
  getFarms()
  {
    Provider.of<UserData>(context,listen: false).getAllFarms();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AllFarmsCard(
          index: index,
          farm: Provider.of<UserData>(context).allFarms[index],
        );
      },
      itemCount: Provider.of<UserData>(context).allFarms.length,
    );
  }
}
