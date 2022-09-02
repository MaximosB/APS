// import 'dart:convert';
// import 'dart:io';

// import 'package:acamp_kids/Model/Atividades.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DataStorage {
//   void saveData(bool primeiroAcesso) async {
//     final prefs = await SharedPreferences.getInstance();

//     prefs.setBool('primeiroAcesso', primeiroAcesso);
//   }

//   readData() async {
//     final prefs = await SharedPreferences.getInstance();

//     bool valor = prefs.getBool('primeiroAcesso');

//     return valor;
//   }
// }

// /// No statefulWidget implementar isso
// /// const Login({Key key, this.storage}) : super(key: key);
// /// e no instanciar o storage final DataStorage storage;
// /// 
// /// Na função do State instanciar a classe que vc quer salvar
// /// ex: Atividades atividades = new Atividades();
// /// 
// /// criar uma função Future do tipo da classe e dentro verificar isso:
// /// 
// /// caso não tenha salvado nada ainda, criar um setState adicionando as informações
// /// e chamar a função do storage de escrita:widget.storage.saveData(atividades);
// /// 
// /// caso tenha salvo só chamar o : return widget.storage.readData();
// /// 
// /// feito isso, só chamar a função no onPressed;