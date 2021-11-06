class UserModel
{
  late String id;
  late String name;
  late String email;
  late String type;
  late String city;

  UserModel({required this.id,required this.name, required this.email, required this.type, required this.city});

  UserModel.fromJson(Map<dynamic,dynamic> map){
    if(map==null)
    {
      return;
    }
    id=map['id'];
    name=map['name'];
    email=map['email'];
    type=map['type'];
    city=map['city'];
  }
  toJson()
  {
    return {
      'id' : id,
      'name' : name,
      'email' :email,
      'type' : type,
      'city':city,
    };
  }
}