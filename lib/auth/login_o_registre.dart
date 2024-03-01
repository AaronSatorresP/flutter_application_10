import 'package:flutter/material.dart';
import 'package:flutter_application_10/paginas/pagina_login.dart';
import 'package:flutter_application_10/paginas/paina_registre.dart';

class LoginORegistre extends StatefulWidget {
  const LoginORegistre({super.key});

  @override
  State<LoginORegistre> createState() => _LoginORegistreState();
}

class _LoginORegistreState extends State<LoginORegistre> {

  bool mostraPaginaLogin = true;


  void intercanviaPaginesLoginRegistre(){
    setState(() {
      mostraPaginaLogin = !mostraPaginaLogin;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(mostraPaginaLogin){
      return  PaginaLogin(alFerClic: intercanviaPaginesLoginRegistre,);
    }else{
    return  PAginaRegistre(alFerClic: intercanviaPaginesLoginRegistre,);
    }

    
  }
}