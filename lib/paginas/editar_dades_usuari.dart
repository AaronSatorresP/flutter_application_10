import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari({super.key});

  @override
  State<EditarDadesUsuari> createState() => _EditarDadesUsuariState();
}

class _EditarDadesUsuariState extends State<EditarDadesUsuari> {

  File? _imatgeSeleccionadaApp;
  Uint8List? _imatgeSeleccionadaWeb;
  bool _imatgeAPuntPerPujar = false;

  Future<void> _triaImatge()  async {

    final ImagePicker picker = ImagePicker();
    XFile? imatge = await picker.pickImage(source: ImageSource.gallery);

    // Si triem i trobem la imatge
    if(imatge != null){

      // Si l'App s'executa en un dispositiu mòbil.
      if(!kIsWeb){

        File arxiuSeleccionat = File(imatge.path);

        setState(() {
          _imatgeSeleccionadaApp = arxiuSeleccionat;
          _imatgeAPuntPerPujar = true;
        });

        
      }

      // Si l'App s'executa en un navegador web.
      if(kIsWeb){
        Uint8List arxiuEnBytes = await imatge.readAsBytes();

        setState(() {
           _imatgeSeleccionadaWeb = arxiuEnBytes;
           _imatgeAPuntPerPujar = true;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Editar Dades"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Botó per obrir el FilePicker.
              // ============================
              GestureDetector(
                onTap: _triaImatge,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    ),
                  child: const Text("Tria imatge"),
                ),
              ),

              // Botó per pujar la imatge seleccionada amb FilePicker.
              // ====================================================
              
                GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    ),
                  child: const Text("Pujar imatge"),
                ),
              ),

              // Visor del resultat del FilePicker.
              // ==================================

              Container(
                child: _imatgeSeleccionadaWeb == null && _imatgeSeleccionadaApp == null ? 
                Container() : 
                kIsWeb ? 
                Image.memory(_imatgeSeleccionadaWeb!, fit: BoxFit.fill,) : 
                Image.file(_imatgeSeleccionadaApp!,fit: BoxFit.fill,),
              ),

              // Visor del resultat de carreagr la imatge de Firebase Storage.
              // =============================================================
            ],
          ),
          ),
        ),
    );
  }
}