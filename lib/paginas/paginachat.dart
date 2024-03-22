import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/auth/servei_auth.dart';
import 'package:flutter_application_10/chat/servei_chat.dart';
import 'package:flutter_application_10/components/bombolla_Missatges.dart';

class PaginaChat extends StatefulWidget {

  final String emailParlem;
  final String idReceptor;
  const PaginaChat({
    super.key,
    required this.emailParlem,
    required this.idReceptor,
    });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {

  final TextEditingController controllerMissatge = TextEditingController();

  final ServeiChat _serveiChat = ServeiChat();

  final ServeiAuth _serviAuth = ServeiAuth();

  void enviarMissatge(){

    if(controllerMissatge.text.isNotEmpty){

      // Enviar el missatge.
      _serveiChat.enviarMissatge(
         widget.idReceptor,
         controllerMissatge.text,
         );
      // Netejar el camp.
      controllerMissatge.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emailParlem),

      ),
      body: Column(
        children: [
          // Zona missatges.
          Expanded(
            child: _construirLlistaMissatges()
            ),

          //Zona escriure missatge
          _construirZonaInputUsuari(),

        ],
      ),
    );
  }
  Widget _construirLlistaMissatges(){

    String idUsuariActual = _serviAuth.getUsuariActual()!.uid;


    return StreamBuilder(
      stream: _serveiChat.getMissatges(idUsuariActual, widget.idReceptor), 
      builder: (context,snapshot){

        // Cas que hi hagi error.
        if(snapshot.hasError){
          return const Text("Error carregant missatges");
        }
        // Esta emcara carregant.
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Carregant....");
        }
        // Retornar dades(ListView).
        return ListView(
          children: snapshot.data!.docs.map((document) => _construirItemMissatge(document)).toList(),
        );
      }
      );
  }

  Widget _construirItemMissatge(DocumentSnapshot documentSnapshot){

    //final data = document...(altra opcio).
    Map<String,dynamic> data = documentSnapshot.data() as Map<String ,dynamic>;

    // Saber si el  mostrem a l'esquerra o a la dreta.

    // Si es usuari actual.
    bool esUsuariActual = data["idAutor"] == _serviAuth.getUsuariActual()!.uid;

    // Operador ternari
    var aliniament = esUsuariActual ? Alignment.centerRight : Alignment.centerLeft;
    var colorBombolla = esUsuariActual ? Colors.green[200] : Colors.amber[200];
    return Container(
      alignment: aliniament,
      child: BombollaMissatge(colorBombolla: colorBombolla??Colors.black,
      missatge: data["missatge"],
      ),
    );
  }

  Widget _construirZonaInputUsuari(){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField( 
              controller: controllerMissatge,
              decoration: InputDecoration(
                  fillColor: Colors.amber[200],
                  filled: true,
                  hintText: "Escriu el missatge..."
              ),
              ),
            ),
      
          IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)
            ),
             
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: enviarMissatge,
            ),
        ],
      ),
    );
  }
}