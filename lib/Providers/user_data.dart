import 'package:farmer_app/Models/order_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Services/user_services.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier
{
  UserModel? user;
  List<Order> orders=[];
  setUser(UserModel mod)
  {
    this.user=mod;
  }

  Future<void> getOrders() async
  {
    UserServices.getMyOrders(userId: user!.id).then((value) {
      orders=value;
      notifyListeners();
    });
  }
}