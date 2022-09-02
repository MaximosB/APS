import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Model/Person.dart';
import 'package:acamp_kids/Model/Semana.dart';
import 'package:acamp_kids/Model/Trofeu.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseFirestore {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Future<QuerySnapshot> futureBooks;
  // User firebaseUser;
  // List<String> ids = [];

//USUARIO
  void criateUser(String email, String id, String nome) {
    Map<String, dynamic> newPerson = new Map<String, dynamic>();
    newPerson['email'] = email;
    newPerson['nome'] = nome;

    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(id)
        .set(newPerson)
        // .add(newPerson)
        .whenComplete(() => print('addeu'));

    print("veio aqui");
  }

  void criarUsuario(Person pessoa, String id) {
    Map<String, dynamic> newPerson = new Map<String, dynamic>();
    newPerson['email'] = pessoa.email;
    newPerson['nome'] = pessoa.name;
    newPerson['idade'] = pessoa.idade;
    newPerson['sexo'] = pessoa.sexo;
    newPerson['peso'] = pessoa.peso;
    newPerson['altura'] = pessoa.altura;

    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(id)
        .set(newPerson)
        .whenComplete(() => null);
  }

//Atividade
  void criarAtividade(
      Atividade atividade, String idUsuario, int idDia, int idSemana,int mes, int ano) async {
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("atividadeUsuario")
        .where("userId", isEqualTo: idUsuario)
        .where("dia_semana", isEqualTo: idDia)
        .where('semana_ano', isEqualTo: idSemana)
        // .orderBy("userId")
        .limit(1)
        .get());

    bool exist = false;
    try {
      exist = result.docs.elementAt(0).exists;
    } catch (e) {
      exist = false;
    }

    result.docs.map((element) => {exist = element.exists});

    if (exist) {
      print('EXISTE');
      Map<String, dynamic> atv = result.docs.first.data();
      atividade.hrsDormidas = atv['dorme'];
      atividade.qtdAguaConsumida = atv['agua'];
      atividade.hrsDeExercicios = atv['exercicio'];
      atividade.qtdEmFastFood = atv['fastFood'];
      atividade.qtdComidaSaudavel = atv['comidaSaudavel'];
      atividade.qtdEmTela = atv['tv'];
      atividade.dia_semana = atv['dia_semana'];
      atividade.semana_ano = atv['semana_ano'];
    } else {
      Map<String, dynamic> novaAtividade = new Map<String, dynamic>();
      novaAtividade['dorme'] = atividade.hrsDormidas;
      novaAtividade['agua'] = atividade.qtdAguaConsumida;
      novaAtividade['exercicio'] = atividade.hrsDeExercicios;
      novaAtividade['fastFood'] = atividade.qtdEmFastFood;
      novaAtividade['comidaSaudavel'] = atividade.qtdComidaSaudavel;
      novaAtividade['tv'] = atividade.qtdEmTela;
      novaAtividade['dia_semana'] = atividade.dia_semana;
      novaAtividade['semana_ano'] = atividade.semana_ano;
      novaAtividade['userId'] = AuthService.to.user.uid;
      novaAtividade['mes'] = mes;
      novaAtividade['ano'] = ano;
      FirebaseFirestore.instance
          .collection('atividadeUsuario')
          .add(novaAtividade)
          .whenComplete(() => print('nova atividade criada'));
    }
  }

  void atualizaAtividade(Atividade atividade, String documentId) {
    Map<String, dynamic> novaAtividade = new Map<String, dynamic>();
    novaAtividade['dorme'] = atividade.hrsDormidas;
    novaAtividade['agua'] = atividade.qtdAguaConsumida;
    novaAtividade['exercicio'] = atividade.hrsDeExercicios;
    novaAtividade['fastFood'] = atividade.qtdEmFastFood;
    novaAtividade['comida'] = atividade.qtdComidaSaudavel;
    novaAtividade['tv'] = atividade.qtdEmTela;

    FirebaseFirestore.instance
        .collection('atividades')
        .doc(documentId)
        .update(novaAtividade)
        .whenComplete(() => print('Atualizou'));
  }

  //PONTOS
  void criarPontos(Semana semana) {
    Map<String, dynamic> pontos = new Map<String, dynamic>();
    pontos['pontos'] = semana.pontuacao;

    FirebaseFirestore.instance
        .collection('pontuacao')
        .add(pontos)
        .whenComplete(() => print('pontuacao'));
  }
}

void setAtividade(
    int idDia, int idSemana, Atividade atividade, String idUsuario) async {
  print(idDia);
  print(idSemana);
  print(idUsuario);
  final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
      .collection("atividadeUsuario")
      .where("userId", isEqualTo: idUsuario)
      .where("dia_semana", isEqualTo: idDia)
      .where('semana_ano', isEqualTo: idSemana)
      // .orderBy("userId")
      .limit(1)
      .get());
  print('SET:' + result.docs.first.exists.toString());
  result.docs.first.data();
  Map<String, dynamic> setAtividade = new Map<String, dynamic>();
  setAtividade['dorme'] = atividade.hrsDormidas;
  setAtividade['agua'] = atividade.qtdAguaConsumida;
  setAtividade['exercicio'] = atividade.hrsDeExercicios;
  setAtividade['fastFood'] = atividade.qtdEmFastFood;
  setAtividade['comidaSaudavel'] = atividade.qtdComidaSaudavel;
  setAtividade['tv'] = atividade.qtdEmTela;

  String id = result.docs.first.id;

  CollectionReference users =
      FirebaseFirestore.instance.collection('atividadeUsuario');

  users.doc(id).update(setAtividade);
  // SetOptions(merge: true),
}

Future<Map<String, dynamic>> getAtividade(
    int idDia, int idSemana, String idUsuario, String atv) async {
  QuerySnapshot result = await Future.value(FirebaseFirestore.instance
      .collection("atividadeUsuario")
      .where("userId", isEqualTo: idUsuario)
      .where("dia_semana", isEqualTo: idDia)
      .where('semana_ano', isEqualTo: idSemana)
      // .orderBy("userId")
      .limit(1)
      .get());
  Map<String, dynamic> atividade = result.docs.first.data();

  return atividade;
}
