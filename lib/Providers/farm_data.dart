
import 'package:farmer_app/Models/farm_product.dart';
import 'package:farmer_app/Models/farm_model.dart';
import 'package:farmer_app/Models/order_in_farm_model.dart';
import 'package:farmer_app/Models/user_model.dart';
import 'package:farmer_app/Services/admin_services.dart';
import 'package:farmer_app/Services/owner_services.dart';
import 'package:flutter/cupertino.dart';

class FarmData extends ChangeNotifier
{
  UserModel? user;
  Farm? farm;
  List<FarmProduct> myEggs=[];
  List<FarmProduct> myChickens=[];
  List<FarmProduct> myLittleChickens=[];
  List<Farm> requestedFarm=[];
  List<Farm> allFarms=[];
  List<OrderInFarm> orderInFarm=[];
  OwnerServices ownerServices=OwnerServices();
  setUser(UserModel mod)
  {
    this.user=mod;
  }

  setFarm(Farm far)
  {
    this.farm=far;
  }

  removeFromEggs(int index)
  {
    myEggs.removeAt(index);
    notifyListeners();
  }
  removeFromChickens(int index)
  {
    myChickens.removeAt(index);
    notifyListeners();
  }
  removeFromLittle(int index)
  {
    myLittleChickens.removeAt(index);
    notifyListeners();
  }
  removeFromRequest(int index)
  {
    requestedFarm.removeAt(index);
    notifyListeners();
  }
  removeFromAllFarm(int index)
  {
    allFarms.removeAt(index);
    notifyListeners();
  }
  removeFromOrders(int index)
  {
    orderInFarm.removeAt(index);
    notifyListeners();
  }
  Future<void> getMyEggs({required String farmId}) async
  {
    ownerServices.getMyEggs(farmId: farmId).then((value){
      myEggs=value;
      notifyListeners();
    });
  }
  Future<void> getMyChickens({required String farmId}) async
  {
    ownerServices.getMyChickens(farmId: farmId).then((value){
      myChickens=value;
      notifyListeners();
    });
  }
  Future<void> getMyLittleChickens({required String farmId}) async
  {
    ownerServices.getMyLittleChickens(farmId: farmId).then((value){
      myLittleChickens=value;
      notifyListeners();
    });
  }

  getRequestFarm()
  {
    AdminServices adminServices=AdminServices();

    adminServices.getRequestFarms().then((value) {
      requestedFarm=value;
      notifyListeners();
    });
  }
  getAllFarms()
  {
    AdminServices adminServices=AdminServices();
    adminServices.getAllFarms().then((value) {
      allFarms=value;
      notifyListeners();
    });
  }

  getOrders()
  {
    ownerServices.getMyOrders(farmId: farm!.id).then((value) {
      orderInFarm=value;
      notifyListeners();
    });
  }
}