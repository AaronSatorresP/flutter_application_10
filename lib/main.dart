import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/login_o_registre.dart';
import 'package:flutter_application_10/auth/portal_auth.dart';
import 'package:flutter_application_10/firebase_options.dart';
import 'package:flutter_application_10/paginas/pagina_login.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalAuth(),
    );
  }
}
/*
1) Tenir el Node.js instalat.
2) npm install -g firebase-tools
3) Fer login a Firebase: firebase login
-cambiar nombre del archivo que da error

4) Fer:dart pub global activate flutterfire_cli
5) Vincular projecte local amb projecte firebase de la consola
  -flutterfire configure

6) Inclore les llibreries de Firebase que vulguem utilitzar.
  -flutter pub add firebase_auth
  -flutter pub add firebase_core
*/

/*
imagenes:
==========
 
 1) Habilitar Firebase Storage en el proyecto vinculat a Firabase.
  - Es pot posar les reglas a true el wriete i read
  2) Escarreguem dependencia de Firebase Storage al projecte
  - flutter pub add firebase_storage
  3) Descarraguem una dependencia per señeccionar imatge (un picket)
  - N'hi ha diversos.
  - imagen_picker
    - flutter pub add imagen_picker
 
 
  4) Perque funcioni en Android:
    - Anar a android > app > src > main > AndroidManifest.xml
    Escriure just abans del tag <aplication> (fora d'aplication):
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>

*/