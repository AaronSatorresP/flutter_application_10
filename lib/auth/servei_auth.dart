import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth{

 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 // Fer login
  Future<UserCredential> loginAmbEmailPassword(String Email, Password) async{

    try{
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
      email: Email, 
      password: Password,
      );

      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set(
        {
          "uid": credencialUsuari.user!.uid,
          "email" : Email,
        }
      );
      return credencialUsuari;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
    
  }


 // Fer Registre
  Future<UserCredential> registreambemailpassword(String email, password) async{
    
    try{
      UserCredential credencialUsuari = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
      );

      
      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set(
        {
          "uid": credencialUsuari.user!.uid,
          "email" : email,
        }
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


  User? getUsuariActual(){
    return _auth.currentUser;
  }
}