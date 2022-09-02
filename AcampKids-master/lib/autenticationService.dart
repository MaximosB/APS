// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Utils/Database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Model/Person.dart';

class AuthService extends GetxController {
  // Recupera a instancia da autenticação do firebase
  FirebaseAuth _auth = FirebaseAuth.instance;
  // Propriedade reativa para  usuario
  Rxn<User> _firebaseUser = Rxn<User>();
  // Verifica em todas as paginas se o usuario esta autenticado
  var userIsAuthenticated = false.obs; // Propriedade observavel
  // Linka as mudanças de autenticação que vão ocorrer no servidor
  // com a variavel _firebaseUser
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (_auth.currentUser != null) {
      print('TA LOGADO');
    }
    _firebaseUser.bindStream(_auth.authStateChanges());
    // Fazer o logout
    _auth.signOut();

    ever(_firebaseUser, (User user) {
      print("EVEN");
      if (user != null) {
        userIsAuthenticated.value = true;
        print('Autenticated:true');
      } else {
        userIsAuthenticated.value = false;
        print('Autenticated:false');
      }
    });
  }

  // Acessar os dados de usuario
  User get user => _firebaseUser.value;
  // Recupera a instancia do serviço de forma estatica
  static AuthService get to => Get.find<AuthService>();

  //METODOS

  // Mostra os erros

  // Registra usuario
  createUser(String email, String password, String nome) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      DatabaseFirestore().criateUser(email, AuthService.to.user.uid, nome);
    } catch (e) {}
  }

  criarUsuario(Person pessoa, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: pessoa.email, password: password);

      DatabaseFirestore().criarUsuario(pessoa, AuthService.to.user.uid);
    } catch (e) {}
  }

  // Loga
  login(String email, String password, BuildContext context) async {
    try {
      print('LOGIN');
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      // error.value = e.message;
      showDialog(
          context: context,
          builder: (c) {
            return _alertError("Login", e.message, context);
          });
    }
  }

  forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // showSnack('Erro ao logar', e.message);
    }
  }

  // Deslogar
  logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // showSnack("Erro logout", e.message);
    }
  }

  criarAtividade(
      Atividade atividade, String idUsuario, int idDia, int idSemana, int mes, int ano) async {
    try {
      print("batata $atividade");
      DatabaseFirestore().criarAtividade(atividade, idUsuario, idDia, idSemana, mes, ano);
    } catch (e) {
      print('ERRO TRY');
      print(e);
    }
  }

  atualizarAtividade(
      Atividade atividadeNova, String documentId, BuildContext context) async {
    try {
      DatabaseFirestore().atualizaAtividade(atividadeNova, documentId);
    } catch (e) {
      showDialog(
          context: context,
          builder: (c) {
            return _alertError("Atualizar Atividade",
                "Ocorreu algum problema ao atualizar as atividades!", context);
          });
    }
  }
}

Widget _alertError(String titulo, String errorTexto, BuildContext context) {
  Widget okButton = ElevatedButton(
    child: Text(
      "OK",
      style: TextStyle(
        color: Color(0xFFFA782C),
        letterSpacing: 1.5,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.grey[850],
    title: Text(
      titulo,
      style: TextStyle(
        color: Colors.white,
        letterSpacing: 1.5,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
    content: Text(
      errorTexto,
      style: TextStyle(
        color: Colors.white,
        letterSpacing: 1.5,
        fontSize: 18.0,
        // fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
    actions: [
      okButton,
    ],
  );

  return alert;
}
