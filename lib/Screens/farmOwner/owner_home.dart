import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Screens/Auth/login_screen.dart';
import 'package:farmer_app/Screens/farmOwner/all_order_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_chickens_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_egg_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_little_chicken_screen.dart';
import 'package:farmer_app/Screens/farmOwner/taps/add_chicken_tap.dart';
import 'package:farmer_app/Screens/farmOwner/taps/add_egg_tap.dart';
import 'package:farmer_app/Screens/farmOwner/taps/add_little_tap.dart';
import 'package:farmer_app/Screens/farmOwner/taps/home_tap.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class OwnerHomeScreen extends StatefulWidget {
  static String id='OwnerHomeScreen';

  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int selectedIndex=0;

  final taps=[
    HomeTap(),
    AddEgg(),
    AddChicken(),
    AddLittle(),
  ];
  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserData>(context).user;
    Farm? farm=Provider.of<UserData>(context).farm;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(user!.name),
      ),
      drawer: Drawer(
        child: Scaffold(
          body: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Kcolor,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/farmlogo.png'),
                              fit: BoxFit.contain,
                            )
                        ),
                      ),
                    ),
                    Center(child: Text('${user.name} Farm', style:const TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                    Center(child: Text(farm!.status,style:const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                  ],
                ),
              ),
              ListTile(
                title: const Text('My Eggs', style: TextStyle(color: Colors.black),),
                leading: Icon(FontAwesomeIcons.egg, color: Kcolor),
                onTap: (){
                  Provider.of<UserData>(context,listen: false).getMyEggs(farmId: user.id).then((value) {
                    Navigator.pushNamed(context, MyEggScreen.id);
                  });
                },
              ),
              ListTile(
                title: const Text('My Chickens', style: TextStyle(color: Colors.black),),
                leading: Icon(FontAwesomeIcons.egg, color: Kcolor),
                onTap: (){
                  Provider.of<UserData>(context,listen: false).getMyChickens(farmId: user.id).then((value) {
                    Navigator.pushNamed(context, MyChickensScreen.id);
                  });
                },
              ),
              ListTile(
                title: const Text('My Little Chickens', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.child_care, color: Kcolor),
                onTap: (){
                  Provider.of<UserData>(context,listen: false).getMyLittleChickens(farmId: user.id).then((value) {
                    Navigator.pushNamed(context, MyLittleChickenScreen.id);
                  });
                },
              ),
              ListTile(
                title: const Text('All Orders', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.reorder, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context,AllOrderScreen.id);
                },
              ),
              ListTile(
                title: const Text('Log out', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.logout, color: Kcolor),
                onTap: () async {
                  Auth auth=Auth();
                   auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Kcolor,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.egg),
            label: 'Add Egg',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.egg),
            label: 'Add Chicken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care),
            label: 'Add Little ',
          ),
        ],
      ),
      body: taps[selectedIndex],
    );
  }
}
