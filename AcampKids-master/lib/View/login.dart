import 'dart:async';

import 'package:acamp_kids/LoginGoogle/authGoogle.dart';
import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/View/Perfil.dart';
import 'package:acamp_kids/View/Teste.dart';
import 'package:acamp_kids/Utils/Database/database.dart';
import 'package:acamp_kids/View/cadastrar.dart';
import 'package:acamp_kids/View/principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acamp_kids/Utils/style_login.dart';
import 'package:get/get.dart';
import 'package:acamp_kids/Controller/autenticationController.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:acamp_kids/View/forgotPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

//Cria o estado StatefulWidgetS
class _LoginState extends State<Login> {
  bool _rememberMe = false;
  final controller = Get.put(AutenticationController());

  var setUsers;

  Future<void> time() async {
    DateTime _myTime;
    DateTime _ntpTime;

    _myTime = await NTP.now();

    final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
    _ntpTime = _myTime.add(Duration(milliseconds: 82800000));
    print('offset: $offset');
    print('My time: $_myTime');
    print('NTP time: $_ntpTime');
    print('Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // controller.email.text = "";
    // controller.senha.text = "";
    super.dispose();
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();

  Widget _logo() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 122,
      width: 98,
      child: Image.asset('assets/login/Trofeu1.png'),
    );
  }

  Widget _formsign() {
    return Form(
      key: controller.formKeyLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 22,
              ),
            ),
          ),
          Container(
            // Email
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 50.0,
            child: TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Informe o email corretamente!';
              //   }
              //   return null;
              // },
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFFCDCDE3),
                ),
                hintText: 'Entre com seu Email',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Senha',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 22,
              ),
            ),
          ),
          Container(
            // Senha
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 50.0,
            child: TextFormField(
              controller: controller.senha,
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Informe o email corretamente!';
              //   }
              //   return null;
              // },
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  //Define o icone da label
                  Icons.lock,
                  color: Color(0xFFCDCDE3),
                ),
                hintText: 'Entre com sua Senha',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(right: 0.0),
        ),
        onPressed: () {
          Atividade atividade = new Atividade();
          //TODO: Colocar valores recebidos na tela
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Text(
          'Esqueci a senha?',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Riffic',
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Lembrar senha',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Riffic',
              fontSize: 13,
            ),
          ),
          Padding(padding: EdgeInsets.all(40)),
          _buildForgotPasswordBtn()
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return StreamBuilder(builder: (context, snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xFF289938),
            shadowColor: Color(0xFF1F7131),
            elevation: 5.0,
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            fixedSize: const Size(150, 50),
          ),
          onPressed: () {
            if (controller.formKeyLogin.currentState.validate()) {
              // controller.logout();
              controller.login(context);
            }
          },
          child: Text(
            'Vamos Nessa!',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Riffic',
              fontSize: 26,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OU -',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Riffic',
            fontSize: 11,
          ),
        ),
        // SizedBox(height: 20.0),
        // Text(
        //   'Logar com',
        //   style: kLabelStyle,
        // ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // _buildSocialBtn(
                //   // () {
                //   //   LoginFacebook().initiateFacebookLogin();
                //   // }
                //   () => LoginFacebook().initiateFacebookLogin(),
                //   AssetImage(
                //     'assets/img_login/facebook.jpg',
                //   ),
                // ),
                _buildSocialBtn(
                  () async {
                    // bool isUserInBank = false;
                    // User user =
                    //     await Authentication.signInWithGoogle(context: context);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Principal(user.uid)));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Perfil()));
                  },
                  AssetImage(
                    'assets/img_login/google.jpg',
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cadastrar()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            // TextSpan(
            //   text: 'Não possuí conta? ',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            TextSpan(
              text: 'Registrar-se',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
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
                            vertical: 30.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10)),
                              _logo(),
                              // SizedBox(height: 8.0),
                              _formsign(),
                              // _buildForgotPasswordBtn(),
                              _buildRememberMeCheckbox(),
                              _buildLoginBtn(),
                              // _buildSignInWithText(),
                              // _buildSocialBtnRow(context),
                              _buildSignupBtn(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
