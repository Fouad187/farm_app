import 'package:farmer_app/Providers/farm_data.dart';
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
    Provider.of<FarmData>(context,listen: false).getAllFarms();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AllFarmsCard(
          index: index,
          farm: Provider.of<FarmData>(context).allFarms[index],
        );
      },
      itemCount: Provider.of<FarmData>(context).allFarms.length,
    );
  }
}
