import 'package:firebase_auth/firebase_auth.dart';
import 'package:mashcafe/models/user.dart';
import 'package:mashcafe/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase User

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user screen
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  // sign in anonymously

 Future signInAnon() async{

   try{
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user= result.user;
     return  _userFromFirebaseUser(user);
   }

   catch(e) {
     print(e.toString());
     return null;
   }
 }




  // sign in email and password

  Future signingInWithEmailandPassword(String email, String password) async{

    try{

      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }





  // register with email and password

  Future registerWithEmailandPassword(String email, String password) async{

    try{

      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user= result.user;

      // create a new doc for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0','New Member',100);


      return _userFromFirebaseUser(user);

    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }






  // sign out
Future signingOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
}


}