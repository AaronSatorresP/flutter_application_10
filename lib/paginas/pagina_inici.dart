import 'package:flutter/material.dart';

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

  void logout(){

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