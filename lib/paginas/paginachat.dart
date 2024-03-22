import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/chat/servei_chat.dart';

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
    return Container();
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