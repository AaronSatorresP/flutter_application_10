import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/servei_auth.dart';
import 'package:flutter_application_10/chat/servei_chat.dart';
import 'package:flutter_application_10/components/item_usuari.dart';
import 'package:flutter_application_10/paginas/editar_dades_usuari.dart';
import 'package:flutter_application_10/paginas/paginachat.dart';

class PaginaInici extends StatelessWidget {
   PaginaInici({super.key});


  final ServeiAuth _serveiAuth = ServeiAuth();
  final ServeiChat _serveiChat = ServeiChat();
  void logout(){

    //final serveiAuth = ServeiAuth();

    _serveiAuth.tancarSessio(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( "Pagina inici"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const EditarDadesUsuari()
                ),
              );
            },
             icon: const Icon(Icons.person)
             ),
          IconButton(
            onPressed: logout, 
          icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _construeixLlistaUsuaris(),
    );
  }
  Widget _construeixLlistaUsuaris(){

    return StreamBuilder(
      stream: _serveiChat.getUsuaris(), 
      builder: (context,snapshot){
        //Mirar si hi ha error.
        if(snapshot.hasError){

          return const Text("Error");
        }
        // Esperem que es carreguin les dades.
        if(snapshot.connectionState == ConnectionState.waiting){
          
          return const Text("Carregant dades...");
        }

        // Es retornen les dades.

        return ListView(
          children: snapshot.data!.map<Widget>(
            (dadesUsuaris) => _construeixItemUsuari(dadesUsuaris,context)
            ).toList(),
        );
      }
      );
  }

  Widget _construeixItemUsuari(Map<String,dynamic> dadesUsuaris, BuildContext context){
    
    if(dadesUsuaris["email"] == _serveiAuth.getUsuariActual()!.email){

      return Container();
    }
    return ItemUsuari(
      emailUsuari: dadesUsuaris["email"],
      ontap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => PaginaChat(
            emailParlem: dadesUsuaris["email"],
            idReceptor: dadesUsuaris["uid"],
            ),
            ),
            );
      
      },
      
      );
  }
}