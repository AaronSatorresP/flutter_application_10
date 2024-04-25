import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ItemUsuari extends StatelessWidget {
  final String emailUsuari;
  final String userIUd;
  final void Function()? onTap;

  ItemUsuari({
    Key? key,
    required this.emailUsuari,
    required this.userIUd,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            FutureBuilder(
              future: FirebaseStorage.instance
                  .ref(userIUd + "/avatar/" + userIUd)
                  .getDownloadURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Icon(Icons.person);
                } else if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(snapshot.data.toString()),
                  );
                } else {
                  return const Icon(Icons.person);
                }
              },
            ),
            const SizedBox(width: 10),
            Text(emailUsuari),
          ],
        ),
      ),
    );
  }
}
