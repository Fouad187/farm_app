import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Widgets/request_farm_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeTap extends StatefulWidget {
  @override
  State<AdminHomeTap> createState() => _AdminHomeTapState();
}

class _AdminHomeTapState extends State<AdminHomeTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getFarms();
    });
  }
  getFarms()
  {
    Provider.of<UserData>(context,listen: false).getRequestFarm();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
        child: Column(
          children: [
            const Text('Requests' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return RequestFarmCard(farm:Provider.of<UserData>(context,listen: true).requestedFarm[index],index: index,);
                },
                itemCount: Provider.of<UserData>(context,listen: true).requestedFarm.length,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
