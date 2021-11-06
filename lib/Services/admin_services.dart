import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/Models/farm_model.dart';

class AdminServices
{
  
  Future<List<Farm>> getRequestFarms() async
  {
    List<Farm> farms=[];
    await FirebaseFirestore.instance.collection('Farm').where('status' , isEqualTo: 'In Review').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
        {
          farms.add(Farm.fromJson(value.docs[i].data()));
        }
    });
    return farms;
  }
  Future<List<Farm>> getAllFarms() async
  {
    List<Farm> farms=[];
    await FirebaseFirestore.instance.collection('Farm').where('status' , isEqualTo: 'Accepted').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        farms.add(Farm.fromJson(value.docs[i].data()));
      }
    });
    return farms;
  }

  deleteFarm(String farmId) async
  {
    try {
      await FirebaseFirestore.instance.collection('Farm').doc(farmId).delete().then((value) async {
         deleteEggs(farmId);
         deleteChickens(farmId);
         deleteLittleChickens(farmId);
      });
    }
    catch(e)
    {

    }
  }

  void deleteEggs(String id) async
  {
    await FirebaseFirestore.instance.collection('Eggs').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
      {
        await FirebaseFirestore.instance.collection('Eggs').doc(value.docs[i].id).delete();
      }
    });
  }

  void deleteChickens(String id) async
  {
    await FirebaseFirestore.instance.collection('Chickens').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
      {
        await FirebaseFirestore.instance.collection('Chickens').doc(value.docs[i].id).delete();
      }
    });
  }

  void deleteLittleChickens(String id) async
  {
    await FirebaseFirestore.instance.collection('Little').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
      {
        await FirebaseFirestore.instance.collection('Little').doc(value.docs[i].id).delete();
      }
    });
  }
}