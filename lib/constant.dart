import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Color Kcolor=Color(0xFF77D970);

String getRandomId()
{
  var rng = new Random();
  String randomName="";
  for (var i = 0; i < 20; i++) {
    randomName += rng.nextInt(100).toString();
  }
  return randomName;
}

List<DropdownMenuItem> getitem(List<String> list)
{
  List<DropdownMenuItem> dropdownmenuitem=[];
  for(int i=0 ; i<list.length; i++)
  {
    String type=list[i];
    var newitem=DropdownMenuItem(
      child: Text(type) ,
      value: type,
    );
    dropdownmenuitem.add(newitem);
  }
  return dropdownmenuitem;
}

Future<File> getImageFromGallery() async
{
  File _pickedimage=File('');
  final ImagePicker _picker=ImagePicker();
  final pickedimagefile= await _picker.pickImage(source: ImageSource.gallery);
  if(pickedimagefile != null) {
   _pickedimage = File(pickedimagefile.path);
  }
  return _pickedimage;
}

List<String> cities=[
  'Riyadh',
  'Jeddah',
  'Dammam',
  'Medina',
  'Cairo',
  'Alex',
  '6 October',
  'Al Khobar',
  'Najran',
  'Abha',
  'Dhahran',
  'Mansoura',
  'Giza',
  'Tabuk',
  'Al-Kharij',
  'Taif',
];
List<String> allcities=[
  'All',
  'Riyadh',
  'Jeddah',
  'Dammam',
  'Medina',
  'Cairo',
  'Alex',
  '6 October',
  'Al Khobar',
  'Najran',
  'Abha',
  'Dhahran',
  'Mansoura',
  'Giza',
  'Tabuk',
  'Al-Kharij',
  'Taif',
];

class payment
{
  late String image;
  late String name;

  payment({required this.image, required this.name});
}
List<payment> paymentsWay=[
  payment(image: 'assets/images/visa.png' , name: 'Visa'),
  payment(image: 'assets/images/mastercard.png' , name: 'MasterCard'),
  payment(image: 'assets/images/discover.png' , name: 'Discover'),
  payment(image: 'assets/images/paypal.png' , name: 'Pay Pal'),
];