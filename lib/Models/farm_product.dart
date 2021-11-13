class FarmProduct
{
  late String id;
  late String name;
  late String description;
  late String image;
  late String farmName;
  late String status;
  late String color;
  late String price;
  String? docId;
  double? totalPrice;
  int? quantity;
  FarmProduct({required this.name,required this.price,required this.color,required this.description,required  this.image , required this.id , required this.farmName,required this.status});

  FarmProduct.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else {
      name=map['name'];
      description=map['description'];
      image=map['image'];
      id=map['id'];
      farmName=map['farmName'];
      status=map['status'];
      color=map['color'];
      price=map['price'];
    }
  }
  toJson()
  {
    return {
      'name' : name,
      'description' : description,
      'image':image,
      'id':id,
      'farmName':farmName,
      'status':status,
      'color' : color,
      'price' : price,
    };
  }
}