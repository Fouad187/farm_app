import 'package:farmer_app/Models/farm_product.dart';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {

  List<FarmProduct> products=[];

  addToCart({required FarmProduct product})
  {
    products.add(product);
    notifyListeners();
  }

  deleteFromCart({required FarmProduct product})
  {
    products.remove(product);
    notifyListeners();
  }

  double calculatePrice()
  {
    double sum=0;
    for(var product in products)
      {
        sum+=product.totalPrice!;
      }
    return sum;
  }
  void clear()
  {
    products.clear();
    notifyListeners();
  }
}