import 'package:farmer_app/Providers/farm_data.dart';
import 'package:farmer_app/Widgets/owner_order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeTap extends StatefulWidget {
  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getOrders();
    });
  }
  getOrders()
  {
    Provider.of<FarmData>(context,listen: false).getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
        child: Column(
          children: [
            const Text('Orders Board' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return OwnerOrderCard(order: Provider.of<FarmData>(context,listen: true).orderInFarm[index],index: index,
                  farmId: Provider.of<FarmData>(context).farm!.id,
                  );
                },
                itemCount:  Provider.of<FarmData>(context,listen: true).orderInFarm.length,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
