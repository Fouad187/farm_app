class Chicken
{
  late String id;
  late String name;
  late String description;
  late String image;
  late String color;
  late String farmName;
  late String status;
  late String price;
  String? docId;
  Chicken({required this.farmName ,required this.price, required this.image , required this.name , required this.id , required this.status ,
  required this.description , required this.color});

  Chicken.fromJson(Map<dynamic,dynamic> map)
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
      'color':color,
      'price' : price,
    };
  }
}