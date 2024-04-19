import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fer login
  Future<UserCredential> loginAmbEmailIPassword(String email, password) async {

    try {
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
        "uid": credencialUsuari.user!.uid,
        "email": email,
      });

      return credencialUsuari;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    
  }

  //Modificar datos
  Future<UserCredential> modificarDatos(String Nombre, Correo) async {
    try {
      UserCredential credentialUser = await _auth.signInWithEmailAndPassword(
          email: Correo, password: '123456');
      _firestore.collection("Usuaris").doc(credentialUser.user!.uid).set({
        "uid": credentialUser.user!.uid,
        "email": Correo,
        "nombreUsuario": Nombre,
      });
      return credentialUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Fer registre
  Future<UserCredential> registreAmbEmailIPassword(String email, password) async {
    try {
      UserCredential credencialUsuari = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      
      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
        "uid": credencialUsuari.user!.uid,
        "email": email,
      });

      return credencialUsuari;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    
  }

  // Fer logout
  Future<void> tancarSessio() async {
    return await _auth.signOut();
  }

  User? getUsuariActual() {
    return _auth.currentUser;
  }
}