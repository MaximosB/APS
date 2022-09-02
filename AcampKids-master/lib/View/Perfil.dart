import 'dart:async';
import 'package:acamp_kids/Controller/autenticationController.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../LoginGoogle/Utils/auth_bloc.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  // StreamSubscription<User> loginStateSubscription;
  final controller = Get.put(AutenticationController());
  @override
  void initState() {
    // var authBloc = Provider.of<AuthBloc>(context, listen: false);
    // loginStateSubscription = authBloc.currentUser.listen((user) {
    //   if (user == null) {
    //     // Navigator.of(context).pushReplacement(
    //     //   MaterialPageRoute(
    //     //     builder: (context) => Login(),
    //     //   ),
    //     // );
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usuarios');

    return Scaffold(
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(AuthService.to.user.uid).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              Map<String, dynamic> data = snapshot.data.data();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data['email']} ${data['nome']}",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //     snapshot.data.photoURL.replaceFirst('s96', 's400'),
                  //   ),
                  //   radius: 80.0,
                  // ),
                  // SizedBox(
                  //   height: 100.0,
                  // ),
                  ElevatedButton(
                      onPressed: () => controller.logout(),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.blueAccent.shade200,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      )),
                  // SignInButton(Buttons.Google,
                  //     onPressed: () => authBloc.logout()),
                ],
              );
            }),
      ),
    );
  }
}
