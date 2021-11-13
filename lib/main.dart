
import 'package:farmer_app/Providers/cart.dart';
import 'package:farmer_app/Providers/user_data.dart';
import 'package:farmer_app/Screens/User/cart_screen.dart';
import 'package:farmer_app/Screens/User/orders_screen.dart';
import 'package:farmer_app/Screens/User/payment_screen.dart';
import 'package:farmer_app/Screens/User/user_all_farm.dart';
import 'package:farmer_app/Screens/User/user_chickens.dart';
import 'package:farmer_app/Screens/User/user_eggs.dart';
import 'package:farmer_app/Screens/User/user_little_chicken.dart';
import 'package:farmer_app/Screens/farmOwner/all_order_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_chickens_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_egg_screen.dart';
import 'package:farmer_app/Screens/farmOwner/my_little_chicken_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/model_hud.dart';
import 'Providers/farm_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Admin/admin_home_screen.dart';
import 'Screens/Auth/login_screen.dart';
import 'Screens/Auth/owner_register.dart';
import 'Screens/Auth/registeration_screen.dart';
import 'Screens/User/user_home_screen.dart';
import 'Screens/farmOwner/owner_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Modelhud>(create: (context) => Modelhud(),),
        ChangeNotifierProvider<FarmData>(create: (context) => FarmData(),),
        ChangeNotifierProvider<UserData>(create: (context) => UserData(),),
        ChangeNotifierProvider<Cart>(create: (context) => Cart(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id:(context)=>LoginScreen(),
          RegisterScreen.id:(context)=>RegisterScreen(),
          OwnerRegisterScreen.id:(context)=>OwnerRegisterScreen(),


          OwnerHomeScreen.id:(context)=>OwnerHomeScreen(),
          MyEggScreen.id:(context)=>MyEggScreen(),
          MyChickensScreen.id:(context)=>MyChickensScreen(),
          MyLittleChickenScreen.id:(context)=>MyLittleChickenScreen(),
          AllOrderScreen.id:(context)=>AllOrderScreen(),

          AdminHomeScreen.id:(context)=>AdminHomeScreen(),

          UserHomeScreen.id:(context)=>UserHomeScreen(),

          CartScreen.id:(context)=>CartScreen(),
          PaymentScreen.id:(context)=>PaymentScreen(),
          UserAllEggsScreen.id:(context)=>UserAllEggsScreen(),
          UserAllChickensScreen.id:(context)=>UserAllChickensScreen(),
          UserAllLittleChickensScreen.id:(context)=>UserAllLittleChickensScreen(),
          UserOrderScreen.id:(context)=>UserOrderScreen(),
          UserAllFarmsScreen.id:(context)=>UserAllFarmsScreen(),
          /*

          //User
          UserCinemaScreen.id:(context)=>UserCinemaScreen(),
          UserFilmsScreen.id:(context)=>UserFilmsScreen(),
          UserTicketScreen.id:(context)=>UserTicketScreen(),
          PaymentScreen.id:(context)=>PaymentScreen(),

 */
        },
      ),
    );
  }
}
