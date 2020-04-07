import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mashcafe/models/mash.dart';
import 'package:mashcafe/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  
  // collection reference
  final CollectionReference mashCollection= Firestore.instance.collection('mash');

  Future updateUserData(String sugars,String name, int strength) async {

       return await mashCollection.document(uid).setData({
         'sugars': sugars,
         'name': name,
         'strength': strength
       });
  }

  // get mash stream

Stream<List<Mash>> get mash {
    return mashCollection.snapshots().map(_MashListFromSnapshot);
}


// Mash List from snapshot
List<Mash> _MashListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc) {
        return Mash(
          name:doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength: doc.data['strength'] ?? 0
        );
  }).toList();
}


// get user doc stream

Stream<UserData> get userData {
    return mashCollection.document(uid).snapshots().map(_userDataFromSnapshot);

}


// userData from snapshot

UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    return UserData(
       uid:uid,
       name:snapshot.data['name'],
       sugars:snapshot.data['sugars'],
       strength:snapshot.data['strength'],
    );

}
  
}