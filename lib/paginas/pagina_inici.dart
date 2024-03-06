import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/servei_auth.dart';

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

  void logout(){

    final serveiAuth = ServeiAuth();

    serveiAuth.tancaSessio(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Pagina inici"),
        actions: [
          IconButton(
            onPressed: logout, 
          icon: Icon(Icons.logout
          ),
          ),
        ],
      ),
    );
  }
}