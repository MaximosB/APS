import 'package:acamp_kids/Controller/autenticationController.dart';
import 'package:acamp_kids/View/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acamp_kids/Utils/style_login.dart';
import 'package:get/get.dart';

import '../autenticationService.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

//Cria o estado StatefulWidgetS
class _ForgotPasswordState extends State<ForgotPassword> {
  final controller = Get.put(AutenticationController());

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Container(
        // height: 100,
        width: 400,
        child: Text(
          "Esqueceu sua senha?",
          style: TextStyle(
            fontFamily: 'Riffic',
            fontSize: 27,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 50, 30),
          child: Text(
            'Insira seu email para recuperar sua senha.',
            style: TextStyle(
              fontFamily: 'Bahnschrift',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 51.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            controller: controller.email,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xFFCDCDE3),
              ),
              hintText: 'Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF289938),
                shadowColor: Color(0xFF1F7131),
                // primary: Colors.blue,
                elevation: 5.0,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                controller.forgotPassword();
                if (AuthService.to.userIsAuthenticated.value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                } else {
                  print('nao cadastrado');
                }
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontFamily: 'Riffic',
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Voltar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Riffic',
          ),
        ),
        backgroundColor: Color(0xFFA5B7CD),
      ),
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
                  gradient: RadialGradient(
                    center: Alignment.center,
                    colors: [Color(0xFFCDCDE3), Color(0xFFA5B7CD)],
                  ),
                  // LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFFFA782C),
                  //     Color(0xFFDC5C17),
                  //     Color(0xFFA1390F),
                  //     Color(0xFF632605),
                  //   ],
                  //   stops: [0.1, 0.4, 0.7, 0.9],
                  // ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _logo(),
                      // SizedBox(height: 10.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      //_buildPasswordTF(),
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
