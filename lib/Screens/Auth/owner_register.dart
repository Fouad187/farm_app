import 'package:farmer_app/Providers/model_hud.dart';
import 'package:farmer_app/Screens/Auth/login_screen.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:farmer_app/Widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../../constant.dart';

class OwnerRegisterScreen extends StatefulWidget {
  static String id='OwnerRegisterScreenid';

  @override
  _OwnerRegisterScreenState createState() => _OwnerRegisterScreenState();
}

class _OwnerRegisterScreenState extends State<OwnerRegisterScreen> {
  String? name, email, password, address, rating,minticketprice;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedcity='Riyadh';
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider
            .of<Modelhud>(context)
            .ischange,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              const SizedBox(height: 10,),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/farmlogo.png'),
                      fit: BoxFit.contain,
                    )
                ),
              ),
              const Center(child: Text('Farmo',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),)),
              const SizedBox(height: 15,),
              CustomText(
                Onclick: (value) {
                  name = value;
                },
                hint: 'Farm Name',
                icon: Icons.home_outlined,
                passwordornot: false,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick: (value) {
                  email = value;
                },
                hint: 'Email',
                icon: Icons.email,
                passwordornot: false,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick: (value) {
                  password = value;
                },
                hint: 'Password',
                icon: Icons.lock,
                passwordornot: true,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick: (value) {
                  address = value;
                },
                hint: 'Address',
                icon: Icons.location_on,
                passwordornot: false,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick: (value) {
                  rating = value;
                },
                hint: 'Rating',
                icon: Icons.rate_review,
                passwordornot: false,

              ),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    const Text('City : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    DropdownButton(items: getitem(cities), value:selectedcity, onChanged: (dynamic value){
                      setState(() {
                        selectedcity=value;
                      });
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Kcolor,
                  onPressed: () async {
                    final instance =
                    Provider.of<Modelhud>(context, listen: false);
                    instance.changeisLoading(true);
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      try {
                        auth.createFarm(
                          address: address!,
                          rating: rating!,
                          password: password!,
                          email: email!,
                          type: 'Farm Owner',
                          context: context,
                          name: name!,
                          city:selectedcity,
                        ).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Your Request In Review You can Login after accepted")));
                          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                          instance.changeisLoading(false);
                        });
                      }
                      catch (e) {
                        instance.changeisLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Email Must be Uniqe")));
                      }
                    }
                    instance.changeisLoading(false);
                  },
                  child: const Text(
                    'Register', style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}