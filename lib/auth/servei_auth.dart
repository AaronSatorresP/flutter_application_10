import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth{

 final FirebaseAuth _auth = FirebaseAuth.instance;

 // Fer login
  Future<UserCredential> loginAmbEmailPassword(String Email, Password) async{

    try{
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
      email: Email, 
      password: Password,
      );
      return credencialUsuari;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
    
  }


 // Fer Registre
  Future<UserCredential> registreambemailpassword(String email, password) async{
    print(password);
    try{
      UserCredential credencialUsuari = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
      );
      return credencialUsuari;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
 // Fer logout 

  Future<void> tancaSessio()async{
    return await _auth.signOut();
  }
}