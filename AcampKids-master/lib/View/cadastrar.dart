// import 'dart:html';

// import 'package:acamp_kids/LoginFacebook/loginFacebook.dart';

import 'package:acamp_kids/Utils/Styles/Containerextension.dart';
import 'package:acamp_kids/autenticationService.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acamp_kids/Utils/style_login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'cadastrar.dart';
import 'package:get/get.dart';
import 'package:acamp_kids/Controller/autenticationController.dart';

class Cadastrar extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

//Cria o estado StatefulWidgetS
class _RegisterState extends State<Cadastrar> {
  final controller = Get.put(AutenticationController());
  int _groupValue = -1;

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        width: 300,
        alignment: Alignment.center,
        child: Text(
          "Crie sua conta",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Riffic",
            fontSize: 35.0,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _formRegister() {
    return Form(
      key: controller.formKeyRegister,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Nome',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          Container(
            // Nome
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 51.0,
            child: TextFormField(
              controller: controller.nome,
              keyboardType: TextInputType.emailAddress,
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
                hintText: 'Digite seu Nome',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          Container(
            // Email
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 51.0,
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
                hintText: 'Digite seu e-mail',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Senha',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          Container(
            // Senha
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 51.0,
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
                hintText: 'Digite sua senha',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Idade',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          containerTextField(controller.idade, TextInputType.number,
              "Digite sua Idade", Icons.format_list_numbered),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Peso',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          containerTextField(controller.peso, TextInputType.number,
              "Digite sue Peso", Icons.format_list_numbered),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Altura',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          containerTextField(controller.altura, TextInputType.number,
              "Digite sua Altura", Icons.format_list_numbered),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Text(
              'Sexo',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 23,
              ),
            ),
          ),
          _myRadioButton(
            title: "Masculino",
            value: 0,
          ),
          _myRadioButton(
            title: "Feminino",
            value: 1,
          ),
          _myRadioButton(
            title: "Outros",
            value: 2,
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value}) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.white,
          hoverColor: Colors.white,
          // tileColor: Colors.white,
          value: value,
          groupValue: _groupValue,
          onChanged: (newValue) => setState(
              () => {_groupValue = newValue, _onRememberMeChanged(newValue)}),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Riffic',
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  void _onRememberMeChanged(int newValue) {
    switch (newValue) {
      case 0:
        controller.sexo.text = "Masculino";
        break;
      case 1:
        controller.sexo.text = "Feminino";
        break;
      case 2:
        controller.sexo.text = "Outros";
        break;
    }
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF289938),
          shadowColor: Color(0xFF1F7131),
          elevation: 5.0,
          padding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          if (controller.email.text == "" ||
              controller.senha.text == "" ||
              controller.nome.text == "" ||
              controller.idade.text == "" ||
              controller.altura.text == "" ||
              controller.peso.text == "" ||
              controller.sexo.text.isEmpty) {
            showDialog(
                context: context,
                builder: (c) {
                  return _alertError(
                      "Error",
                      "Algum dos campos está vazio! Digite novamente os dados corretamente!",
                      context);
                });
          } else if (controller.senha.text.length < 8) {
            showDialog(
                context: context,
                builder: (c) {
                  return _alertError(
                      "Error",
                      "Senha digitada inválida! Digite uma senha que contanha 8 digitos ou mais!",
                      context);
                });
          } else {
            if (controller.formKeyRegister.currentState.validate()) {
              if (controller.isLogin.value) {
                await controller.registrar();
                print(AuthService.to.userIsAuthenticated.value);
                if (AuthService.to.userIsAuthenticated.value) {
                  print('Registrado');
                  Navigator.pop(context);
                }
              } else {
                print('nao cadastrado');
              }
            }
          }
        },
        child: Text(
          'Vamos Nessa!',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Riffic',
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _alertError(String titulo, String errorTexto, BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(errorTexto),
      actions: [
        okButton,
      ],
    );

    return alert;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "Voltar",
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
                              SizedBox(height: 10.0),
                              _formRegister(),
                              _buildRegisterBtn(),
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
