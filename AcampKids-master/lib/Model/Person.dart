import 'package:acamp_kids/Model/baseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Person extends BaseModel {
  String _documentId;
  String name;
  String email;
  String sexo;
  int idade;
  int peso;
  int altura;

  Person();

  Person.fromMap(DocumentSnapshot document) {
    _documentId = document.id;

    this.name = document.data()["nome"];
    this.email = document.data()['email'];
    this.idade = document.data()['idade'];
    this.sexo = document.data()['sexo'];
    this.peso = document.data()['peso'];
    this.altura = document.data()['altura'];
  }

  Person.init(
      this.email, this.name, this.idade, this.sexo, this.peso, this.altura);

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = this.name;
    return map;
  }

  @override
  String documentId() => _documentId;
}
