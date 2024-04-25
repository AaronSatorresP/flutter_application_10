import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/servei_auth.dart';
import 'package:image_picker/image_picker.dart';

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari({super.key});

  @override
  State<EditarDadesUsuari> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditarDadesUsuari> {
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      String uid = user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Usuaris').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        setState(() {
          _nomController.text = userData['nombreUsuario'] ?? '';
          _gmailController.text = userData['email'] ?? '';
        });
      }
    } catch (error) {
      print('Error al cargar los datos del usuario: $error');
    }
  }

  void modificar(BuildContext context) async {
    final serveiAuth = ServeiAuth();

    try {
      await serveiAuth.modificarDatos(
        _nomController.text,
        _gmailController.text
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
    }
  }

  File? _imatgeSeleccionadaApp;
  Uint8List? _imatgeSeleccionadaWeb;
  bool _imatgeApuntPerPujar = false;

  Future<void> _triaImatge() async {
    final ImagePicker picker = ImagePicker();
    XFile? imatge = await picker.pickImage(source: ImageSource.gallery);

    // Si trien i trobem la imatge.
    if (imatge != null) {
      // Si l'App s'executa en un dispositiu mòbil.
      if (!kIsWeb) {
        File arxiuSeleccionat = File(imatge.path);

        setState(() {
          _imatgeSeleccionadaApp = arxiuSeleccionat;
          _imatgeApuntPerPujar = true;
        });
      }

      // Si l'App s'executa en un navegador web
      if (kIsWeb) {
        Uint8List arxiuEnBytes = await imatge.readAsBytes();

        setState(() {
          _imatgeSeleccionadaWeb = arxiuEnBytes;
          _imatgeApuntPerPujar = true;
        });
      }
    }
  }

  Future<bool> pujarImatgePerUsuari() async {
    
    String idUsuari = ServeiAuth().getUsuariActual()!.uid;

    Reference ref =
        FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    // agafem la imatge de la variable que la tinguii (la de web o la de app).
    if (_imatgeSeleccionadaApp != null) {
      try {
        await ref.putFile(_imatgeSeleccionadaApp!);
        return true;
      } catch (e) {
        return false;
      }
    }

    if (_imatgeSeleccionadaWeb != null) {
      try {
        await ref.putData(_imatgeSeleccionadaWeb!);
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  Future<String> getImatgePerfil() async {
    final String idUsuari = ServeiAuth().getUsuariActual()!.uid;
    final Reference ref =
        FirebaseStorage.instance.ref().child("$idUsuari/avatar/$idUsuari");

    final String urlImatge = await ref.getDownloadURL();

    return urlImatge;
  }

  Widget mostrarImatge() {
    return FutureBuilder(
      future: getImatgePerfil(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const Icon(Icons.person);
        }

        return Image.network(snapshot.data!,
            errorBuilder: (context, error, stackTrace) {
          return Text("Error al carregar la imatge: $error");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar dades"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botó per obrir el FilePicker.
              //===============================
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
              // ======================================================
              GestureDetector(
                onTap: () async {
                  if (_imatgeApuntPerPujar) {
                    bool imatgePujadaCorrectament =
                        await pujarImatgePerUsuari();
                    if (imatgePujadaCorrectament) {
                      mostrarImatge();
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                  ),
                  child: const Text("Puja imatge"),
                ),
              ),

              // Visor del resultar del FilePicker.
              // =================================
              Container(
                child: _imatgeSeleccionadaWeb == null &&
                        _imatgeSeleccionadaApp == null
                    ? Container()
                    : kIsWeb
                        ? Image.memory(
                            _imatgeSeleccionadaWeb!,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            _imatgeSeleccionadaApp!,
                            fit: BoxFit.fill,
                          ),
              ),

              // Visor del resultar de carregar la imatge de Firebase Storage.
              // =============================================================
              Container(
                child: mostrarImatge(),
              ),
              Text(_gmailController.text),
              SizedBox(
                width: 600,
                child: TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'nombre',
                    hintText: _nomController.text,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey[800]!),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              Row(
                children: [
                  
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        modificar(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditarDadesUsuari()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[200]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.blue[800]!),
                          ),
                        ),
                      ),
                      child: const Text('Modificar Cuenta'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}