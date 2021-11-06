import 'package:farmer_app/Providers/model_hud.dart';
import 'package:farmer_app/Services/auth.dart';
import 'package:farmer_app/Widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'registeration_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id='LoginScreenid';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? email,password;
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
              const SizedBox(height: 50,),
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
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.only(left: 60 , right: 60),
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
                          try
                          {
                            auth.Signin(email: email! , password: password! , context: context);

                          }
                          catch (e) {
                            instance.changeisLoading(false);
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Email or Password")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: const Text('Login' , style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account ? ', style: TextStyle(color: Colors.black , fontSize: 17),),
                    GestureDetector(
                      child: Text('Register Now', style: TextStyle(fontSize: 18 , color: Kcolor),),
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
