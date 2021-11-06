class Farm
{
  late String id;
  late String farmName;
  late String image;
  late String address;
  late String rating;
  late String status;
  late String city;
  Farm({required this.id, required this.farmName, required this.image, required this.address, required this.rating , required this.status ,required this.city ,});

  Farm.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        id=map['id'];
        farmName=map['farmName'];
        image=map['image'];
        address=map['address'];
        rating=map['rating'];
        status=map['status'];
        city=map['city'];
      }
  }

  toJson()
  {
    return {
      'id' : id,
      'farmName':farmName,
      'image':image,
      'address':address,
      'rating' : rating,
      'status':status,
      'city':city,
    };
  }
}