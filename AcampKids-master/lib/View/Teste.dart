// import 'package:acamp_kids/Utils/Database/database.dart';

import 'package:acamp_kids/LoginGoogle/Utils/services.dart';
import 'package:acamp_kids/View/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'cadastrar.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  Widget _buildText(dynamic nome, dynamic email) {
    return Column(
      children: [
        CircleAvatar(
          child: ClipOval(child: Image.asset('assets/images/perfil.jpeg')),
          radius: 70.0,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          height: 30.0,
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          elevation: 2.0,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          "Nome",
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          nome,
                          style: TextStyle(
                              color: Colors.deepOrange[900],
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          email,
                          style: TextStyle(
                              color: Colors.deepOrange[900],
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  Widget _signOutbtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 150,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.black,
          elevation: 10.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Sign Out',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () => {
          // AuthService().logout(), Navigator.pop(context, true)
          },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usuarios');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepOrangeAccent,
                          Colors.deepOrange[900]
                        ],
                      )),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 30.0,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _buildText(data['nome'], data['email']),
                              _signOutbtn(context)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

          // Text("Full Name: ${data['email']} ${data['nome']}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}

// Future<void> time() async {
//   DateTime _myTime;
//   DateTime _ntpTime;

//   _myTime = await NTP.now();

//   var hourTarget = TimeOfDay(hour: 17, minute: 30);

//   final DateTime time = DateTime.now();
//   final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
//   _ntpTime = _myTime.add(Duration(milliseconds: 82800000));
//   print('offset: $offset');
//   print('My time: $_myTime');
//   print('NTP time: $_ntpTime');
//   print('Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');

//   if (time.minute == hourTarget.minute) {
//     print('são: $hourTarget');
//   }
// }

// Future newTimer() => new Future.value(DateTime.now());

// void cronFunction() {
//   var cron = new Cron();
//   cron.schedule(new Schedule.parse('*/2 * * * *'), () async {
//     print('todo 2 minutos');
//   });

//   cron.schedule(new Schedule.parse('3-5 * * * *'), () async {
//     print('entre todo 3 e 5 minutos');
//   });
// }