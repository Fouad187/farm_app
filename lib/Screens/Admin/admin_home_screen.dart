import 'package:farmer_app/Screens/Admin/taps/admin_home_tap.dart';
import 'package:farmer_app/Screens/Admin/taps/admin_myfarms_tap.dart';
import 'package:farmer_app/Screens/Auth/login_screen.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class AdminHomeScreen extends StatefulWidget {
  static String id='AdminHomeScreen';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex=0;

  final taps=[
    AdminHomeTap(),
    AdminMyFarmsTap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Kcolor,
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
            icon: Icon(Icons.format_align_left),
            label: 'All Farms',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
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
                  const Center(child: Text('Admin',style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                ],
              ),
            ),
            ListTile(
              title: Text('Log out', style: TextStyle(color: Colors.black),),
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
      body: taps[selectedIndex],
    );

  }
}
