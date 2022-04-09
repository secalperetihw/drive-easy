import 'package:firebase_auth/firebase_auth.dart';

class Authorization {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      User? user;
      await _auth.signInAnonymously().then((value) {
        user = value.user;
        if(user != null){
          return user;
        }
        else{
          return false;
        }
      });
      
    } catch (e){
      print(e);
      return false;
    }
  }
}