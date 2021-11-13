
import 'package:farmer_app/Providers/model_hud.dart';
import 'package:farmer_app/Screens/User/user_home_screen.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:farmer_app/Widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'owner_register.dart';
class RegisterScreen extends StatefulWidget {
  static String id='RegisterScreenid';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? name,email,password;

  String selectedcity='Riyadh';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Auth auth=Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              const SizedBox(height: 10,),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/farmlogo.png'),
                      fit: BoxFit.contain,
                    )
                ),
              ),
              const SizedBox(height: 20,),
              const Center(child: Text('Farmo' , style:TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,) ,)),
              const SizedBox(height: 30,),
              CustomText(
                Onclick:(value)
                {
                  name=value;
                },
                hint: 'Name',
                icon: Icons.account_box,
                passwordornot: false,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick:(value)
                {
                  email=value;
                },
                hint: 'Email',
                icon: Icons.email,
                passwordornot: false,

              ),
              const SizedBox(height: 20,),
              CustomText(
                Onclick:(value)
                {
                  password=value;
                },
                hint: 'Password',
                icon: Icons.lock,
                passwordornot: true,

              ),
              const SizedBox(height: 5,),
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
                  padding: EdgeInsets.only(left: 60 , right: 60),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Kcolor,
                    onPressed: () async {
                      final instance =
                      Provider.of<Modelhud>(context, listen: false);
                      instance.changeisLoading(true);
                      if (_globalKey.currentState!.validate())
                      {
                        _globalKey.currentState!.save();
                          try {
                             auth.CreateAccount(name: name!,
                                type: 'User',
                                email: email!,
                                password: password!,
                                city : selectedcity,
                                context: context,
                            ).then((value) {
                               Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id, (route) => false);
                               instance.changeisLoading(false);
                             });
                          }
                          catch (e) {
                            instance.changeisLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email Must be Unique")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: const Text('Register' , style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 5,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You Have a Farm ? ', style: TextStyle(color: Colors.black , fontSize: 17),),
                    GestureDetector(
                      child: Text('Register from here', style: TextStyle(fontSize: 18 , color: Kcolor),),
                      onTap: (){
                        Navigator.pushNamed(context, OwnerRegisterScreen.id);
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}