import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Model/Person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:acamp_kids/autenticationService.dart';

class AutenticationController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();
  final idade = TextEditingController();
  final sexo = TextEditingController();
  final peso = TextEditingController();
  final altura = TextEditingController();

  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  var isLogin = true.obs;
  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogin, (visible) {
      formKeyLogin.currentState.reset();
      formKeyRegister.currentState.reset();
    });
  }

  login(BuildContext context) async {
    // isLoading.value = true;
    await AuthService.to.login(email.text, senha.text, context);
    // isLoading.value = false;
  }

  registrar() async {
    // isLoading.value = true;
    Person pessoa = new Person.init(
        email.text,
        nome.text,
        int.parse(idade.text),
        sexo.text,
        int.parse(peso.text),
        int.parse(altura.text));

    // await AuthService.to.createUser(email.text, senha.text, nome.text);
    await AuthService.to.criarUsuario(pessoa, senha.text);
    // isLoading.value = false;
  }

  logout() async {
    // isLoading.value = true;
    await AuthService.to.logout();
    // isLoading.value = false;
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }

  forgotPassword() async {
    // isLoading.value = true;
    await AuthService.to.forgotPassword(email.text);
    // isLoading.value = false;
  }

  criarAtividade(
      Atividade atividade, String idUsuario, int idDia, int idSemana, int mes, int ano) async {
    await AuthService.to.criarAtividade(atividade, idUsuario, idDia, idSemana, mes, ano);
  }

  atualizarAtividade(
      Atividade atividade, String documentId, BuildContext context) async {
    await AuthService.to.atualizarAtividade(atividade, documentId, context);
  }
}
