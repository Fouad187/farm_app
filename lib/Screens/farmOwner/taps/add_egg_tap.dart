import 'dart:io';

import 'package:farmer_app/Providers/model_hud.dart';
import 'package:farmer_app/Services/owner_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../owner_home.dart';

class AddEgg extends StatefulWidget {
  @override
  State<AddEgg> createState() => _AddEggState();
}

class _AddEggState extends State<AddEgg> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? name ,description,color,price;
  OwnerServices owner=OwnerServices();
  File? _pickedimage;
  final ImagePicker _picker=ImagePicker();
  void _pickimage(ImageSource src) async
  {
    final pickedimagefile= await _picker.getImage(source: src);
    if(pickedimagefile != null)
    {
      setState(() {
        _pickedimage=File(pickedimagefile.path);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            const Center(child: Text('Add Egg' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                _pickimage(ImageSource.gallery);
              },
              child: Center(
                  child: Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey,
                    child: _pickedimage==null ? const Icon(Icons.add_a_photo) : Image.file(_pickedimage! , fit: BoxFit.fill,),
                  )),
            ),
            const SizedBox(height: 10,),
            const Center(child: Text('Egg Image')),
            const SizedBox(height: 10,),
            Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20 , bottom: 5),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Egg Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return  'Please Enter Egg name';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          name=value;
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Egg Description',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return  'Please Enter Egg Description';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          description=value;
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Egg Color',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return  'Please Enter Egg Color';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          color=value;
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Egg Price',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return  'Please Enter Egg Price';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          price=value;
                        });
                      },
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: FlatButton(onPressed: () async {
                        final instance =
                        Provider.of<Modelhud>(context, listen: false);
                        instance.changeisLoading(true);
                        if(_globalKey.currentState!.validate())
                        {
                          _globalKey.currentState!.save();
                          try{
                            if(_pickedimage == null )
                            {
                              instance.changeisLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select Image')));

                            }
                            else {
                               owner.addNewEgg(
                                  image: _pickedimage!,
                                  description: description!,
                                  name: name!,
                                  color: color!,
                                  price: price!,
                                  context: context,
                              );
                              Navigator.pushReplacementNamed(context, OwnerHomeScreen.id);
                              instance.changeisLoading(false);
                            }
                          } catch (e){
                            instance.changeisLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                          }
                        }
                        instance.changeisLoading(false);
                      },
                        color: Kcolor,
                        child: const Text('Add Egg' , style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}
