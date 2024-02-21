import 'package:flutter/material.dart';
import 'package:flutter_application_10/components/textfieid_auth.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 183, 159),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            //Logo.
            const Icon(
              Icons.fireplace,
              size: 120,
              color: Color.fromARGB(255, 255, 240, 218),
            ),
            // Frase
            const Text(
              "Benvingut/da de nou",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 240, 218),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Text divisori.
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 255, 240, 218),
                   ),
                ),

                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 4,),
                   child: Text(
                    "Fes login",
                    style: TextStyle(color: Color.fromARGB(255, 255, 240, 218),),
                   ),
                 ),
                 
                 Expanded(
                   child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 255, 240, 218),
                   ),
                 ),
              ],
            ),


            // TextField Email.

            TextFieldAuth(
              controller: controllerEmail, 
              hintText: "Email", 
              obscureText: false,
              ),

            // TextField Password.
            TextFieldAuth(
              controller: controllerPassword, 
              hintText: "Password", 
              obscureText: true,
              ),
            // No estas registrat/da?
        
            // Botó login
        
          ],
        ),
      ),
    );
  }
}