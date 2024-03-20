import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaginaChat extends StatefulWidget {
  const PaginaChat({super.key});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amb qui parlem"),

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
    return Container();
  }
}