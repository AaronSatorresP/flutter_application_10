import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void logout() {
    //final serveiAuth = ServeiAuth();
    _serveiAuth.tancarSessio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pàgina inici"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditarDadesUsuari()));
              },
              icon: const Icon(Icons.person)),
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _construeixLlistaUsuaris(),
    );
  }

  Widget _construeixLlistaUsuaris() {
    return StreamBuilder(
      stream: _serveiChat.getUsuaris(),
      builder: (context, snapshot) {
        // Mirar si hi ha errror.
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Esperem que es carreguin les dades.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregant dades...");
        }

        // Es retornen les dades.
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                  (dadesUsuari) => _construeixItemUsuari(dadesUsuari, context))
              .toList(),
        );
      },
    );
  }

  Widget _construeixItemUsuari(Map<String, dynamic> dadesUsuari, BuildContext context) {
    if (dadesUsuari["email"] == _serveiAuth.getUsuariActual()!.email) {
      return Container();
    }



    if (dadesUsuari["nombreUsuario"] != "") {
      return ItemUsuari(
        emailUsuari: dadesUsuari["nombreUsuario"],
        userIUd: dadesUsuari["uid"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaChat(
                emailParlem: dadesUsuari["nombreUsuario"],
                idReceptor: dadesUsuari["uid"],
              ),
            ),
          );
        },
      );
    }

    return ItemUsuari(
      emailUsuari: dadesUsuari["email"],
      userIUd: dadesUsuari["uid"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaChat(
              emailParlem: dadesUsuari["email"],
              idReceptor: dadesUsuari["uid"],
            ),
          ),
        );
      },
    ); //Text(dadesUsuari["email"]);
  }
}