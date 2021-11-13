import 'package:farmer_app/Models/farm_product.dart';

class OrderInFarm
{
  late String userId;
  late String productId;
  late String productName;
  late String productImage;
  late int quantity;
  late String price;
  late double totalPrice;
  late String status;
  String? docId;
  OrderInFarm({required this.userId , required this.status,required this.productId , required this.productName , required this.totalPrice , required this.quantity , required this.price , required this.productImage});

  OrderInFarm.fromJson(Map<String , dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        userId = map['userId'];
        productId= map['productId'];
        productName=map['productName'];
        productImage=map['productImage'];
        quantity=map['quantity'];
        price=map['price'];
        totalPrice=map['totalPrice'];
        status=map['status'];
      }
  }

  toJson() {
    return {
      'userId' : userId,
      'productId' : productId,
      'productName' : productName,
      'productImage' : productImage,
      'quantity' : quantity,
      'price' : price,
      'totalPrice' : totalPrice,
      'status' : status,
    };
  }
}