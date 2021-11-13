import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Providers/cart.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Screens/Auth/login_screen.dart';
import 'package:farmer_app/Screens/User/orders_screen.dart';
import 'package:farmer_app/Screens/User/user_all_farm.dart';
import 'package:farmer_app/Screens/User/user_chickens.dart';
import 'package:farmer_app/Screens/User/user_eggs.dart';
import 'package:farmer_app/Screens/User/user_little_chicken.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:farmer_app/Services/user_services.dart';
import 'package:farmer_app/Widgets/product_card.dart';
import 'package:farmer_app/Widgets/farm_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'cart_screen.dart';

class UserHomeScreen extends StatefulWidget {
  static String id='UserHomeScreen';

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserServices userServices=UserServices();

  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserData>(context).user;
    return Scaffold(
        key: _scaffoldKey,
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
                      Center(child: Text(user!.name, style:const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                      Center(child: Text(user.email,style: const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('My Orders', style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.reorder, color: Kcolor),
                  onTap: () async {
                    await Provider.of<UserData>(context,listen: false).getOrders().then((value) {
                      Navigator.pushNamed(context, UserOrderScreen.id);
                    });
                  },
                ),
                ListTile(
                  title: const Text('Farms', style:  TextStyle(color: Colors.black),),
                  leading: Icon(Icons.home_filled, color: Kcolor),
                  onTap: (){
                    Navigator.pushNamed(context, UserAllFarmsScreen.id);
                  },
                ),
                ListTile(
                  title: const Text('Eggs', style: TextStyle(color: Colors.black),),
                  leading: Icon(FontAwesomeIcons.egg, color: Kcolor),
                  onTap: (){
                    Navigator.pushNamed(context, UserAllEggsScreen.id);
                  },
                ),
                ListTile(
                  title: const Text('Chickens' , style: TextStyle(color: Colors.black),),
                  leading: Icon(FontAwesomeIcons.egg, color: Kcolor),
                  onTap: (){
                    Navigator.pushNamed(context, UserAllChickensScreen.id);
                  },
                ),
                ListTile(
                  title: const Text('Little Chickens' , style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.child_care, color: Kcolor),
                  onTap: (){
                    Navigator.pushNamed(context, UserAllLittleChickensScreen.id);
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
        body: ListView(
          padding: const EdgeInsets.only(top: 40 , left: 20 ,right: 20),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: const Icon(Icons.list, size: 40,)),
                    const Text('Let\'s Start' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    const Text('your trip?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ],
                ),
                Stack(
                    children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                      child: const Icon(Icons.shopping_cart ,size: 30,)),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.5),
                            color: Kcolor,
                          ),
                          child: Center(child: Text('${Provider.of<Cart>(context).products.length}' , style: const TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(15),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search , color: Colors.black,),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('New Chickens' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,UserAllChickensScreen.id);
                    },
                    child: const Text('View All', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
                height: 200,
                child: FutureBuilder<List<FarmProduct>>(
                  future: userServices.getNewChickens(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: snapshot.data![index],);
                        },
                      );
                    }
                    else{
                      return Container(
                          height: 100,
                          width: 100,
                          child: const Center(child: CircularProgressIndicator()));
                    }
                  },
                )
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('New Eggs' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,UserAllEggsScreen.id);
                    },
                    child: const Text('View All', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
                height: 200,
                child: FutureBuilder<List<FarmProduct>>(
                  future: userServices.getNewEggs(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: snapshot.data![index],);
                        },
                      );
                    }
                    else{
                      return Container(
                          height: 100,
                          width: 100,
                          child: const Center(child: CircularProgressIndicator()));
                    }
                  },
                )
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Most Popular Farms', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold ),),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, UserAllFarmsScreen.id);
                    },
                    child: const Text('View All', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
                height: 200,
                child: FutureBuilder<List<Farm>>(
                  future: userServices.getPopularFarms(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return FarmCard(farm: snapshot.data![index],);
                        },
                      );
                    }
                    else{
                      return Container(
                          height: 100,
                          width: 100,
                          child: const Center(child: CircularProgressIndicator()));
                    }
                  },
                )
            ),
            const SizedBox(height: 20,),
          ],
        )
    );
  }
}
