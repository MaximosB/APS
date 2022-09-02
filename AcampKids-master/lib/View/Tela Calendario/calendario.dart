import 'package:acamp_kids/LoginGoogle/Utils/services.dart';
import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Model/Semana.dart';
import 'package:acamp_kids/View/Tela%20Calendario/menu.dart';
import 'package:acamp_kids/View/principal.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:acamp_kids/Controller/autenticationController.dart';

Widget showCalendario(BuildContext context, String idUsuario, int semanaAno,
    List<Atividade> atividades, int valorPontos) {
  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.all(10),
    child: Center(
      child: Container(
        height: 590,
        width: 381,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/semanal/ModF.png'),
          ),
        ),
        child: Stack(
          children: [
            Container(
              child: Align(
                alignment: Alignment((Alignment.topRight.x * 0.865),
                    (Alignment.topRight.y * 0.845)),
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    "assets/semanal/Back.png",
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(
                  (Alignment.topCenter.x), (Alignment.topCenter.y * 0.73)),
              child: Image.asset(
                "assets/semanal/Day.png",
              ),
            ),
            Align(
              alignment: Alignment(
                  (Alignment.topCenter.x), (Alignment.topCenter.y * 0.73)),
              child: Text(
                "Semana",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Riffic',
                  fontSize: 32,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Align(
              alignment: Alignment(
                  (Alignment.topCenter.x), (Alignment.topCenter.y * 0.61)),
              child: Text(
                diasDaSemana(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Bahnschrift',
                ),
              ),
            ),
            gridViewCountImagens(),
            centerOfView(idUsuario, semanaAno, atividades),
            progressPoints(valorPontos / 126)
          ],
        ),
      ),
    ),
  );
}

Widget gridViewCountImagens() {
  return Align(
    alignment:
        Alignment((Alignment.topRight.x * 0.2), (Alignment.topCenter.y * 0.43)),
    child: SizedBox(
      width: 270,
      height: 100,
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisSpacing: 6,
        crossAxisCount: 6,
        // childAspectRatio: 1.10,
        // padding: EdgeInsets.all(5.0),
        children: List.generate(6, (index) {
          return new Image(
            image: AssetImage("assets/semanal/Act$index.png"),
          );
        }),
      ),
    ),
  );
}

Widget centerOfView(
    String idUsuario, int semanaAno, List<Atividade> atividades) {
  return Align(
    alignment: Alignment(0.0, 0.30),
    child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/semanal/Mod1.png"),
          ),
        ),
        height: 318,
        width: 360,
        child: Row(
          children: [
            diasDaSemanaNomes(),
            Align(
              alignment:
                  Alignment((Alignment.topCenter.x), (Alignment.center.y)),
              child: gridViewCountGeral(idUsuario, semanaAno, atividades),
            ),
          ],
        )),
  );
}

Widget diasDaSemanaNomes() {
  var diasDaSemana = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom"];
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 10, 0, 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Text(
          diasDaSemana.elementAt(index),
          style: TextStyle(
            fontFamily: 'Bahnschrift',
            fontSize: 9,
            color: Colors.white,
          ),
        );
      }),
    ),
  );
}

Widget gridViewCountGeral(
    String idUsuario, int semanaAno, List<Atividade> atividades) {
  var num = 1;
  var tamanhoSemana = verificaDiasnaSemana(atividades);
  return SizedBox(
    width: 300,
    child: GridView.count(
      primary: false,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisCount: 6,
      childAspectRatio: 1.30,
      padding: EdgeInsets.all(10.0),
      children:
          // listaDeImagensdosEstados(semana, tamanhoSemana, num)
          List.generate(42, (index) {
        AssetImage assetImage;
        if (((index + 1) <= 6 && tamanhoSemana >= 1) &&
            atividades.elementAt(0).dia_semana == 1) {
          assetImage = assetImages(num, atividades.elementAt(0));
        } else if (((index + 1) <= 12 && tamanhoSemana >= 2) &&
            atividades.elementAt(1).dia_semana == 2) {
          assetImage = assetImages(num, atividades.elementAt(1));
        } else if (((index + 1) <= 18 && tamanhoSemana >= 3) &&
            atividades.elementAt(2).dia_semana == 3) {
          assetImage = assetImages(num, atividades.elementAt(2));
        } else if (((index + 1) <= 24 && tamanhoSemana >= 4) &&
            atividades.elementAt(3).dia_semana == 4) {
          assetImage = assetImages(num, atividades.elementAt(3));
        } else if (((index + 1) <= 30 && tamanhoSemana >= 5) &&
            atividades.elementAt(4).dia_semana == 5) {
          assetImage = assetImages(num, atividades.elementAt(4));
        } else if (((index + 1) <= 36 && tamanhoSemana >= 6) &&
            atividades.elementAt(5).dia_semana == 6) {
          assetImage = assetImages(num, atividades.elementAt(5));
        } else if (((index + 1) <= 42 && tamanhoSemana == 7) &&
            atividades.elementAt(6).dia_semana == 7) {
          assetImage = assetImages(num, atividades.elementAt(6));
        } else {
          assetImage = AssetImage("assets/semanal/Boot.png");
        }
        if (num == 6) {
          num = 1;
        } else {
          num += 1;
        }
        return new Image(image: assetImage);
      }),
    ),
  );
}

int verificaDiasnaSemana(List<Atividade> atividades) {
  return atividades.length;
}

AssetImage assetImages(int valor, Atividade dia) {
  switch (valor) {
    case 1:
      return AssetImage(mudaImagemConforme(dia.getPontosHrsDormidas()));
      break;
    case 2:
      return AssetImage(mudaImagemConforme(dia.getPontosComidaSaudavel()));
      break;
    case 3:
      return AssetImage(mudaImagemConforme(dia.getPontosAguaConsumida()));
      break;
    case 4:
      return AssetImage(mudaImagemConforme(dia.getPontosHrsDeExercicios()));
      break;
    case 5:
      return AssetImage(mudaImagemConforme(dia.getPontosQtdEmTela()));
      break;
    case 6:
      return AssetImage(mudaImagemConforme(dia.getPontosEmFastFood()));
      break;
  }
}

Widget progressPoints(double valor) {
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment(
            Alignment.bottomCenter.x, Alignment.bottomCenter.y * 0.85),
        child: Image.asset(
          "assets/semanal/BarTrofeu1.png",
          width: 300,
        ),
      ),
      Align(
        alignment: Alignment(
            Alignment.bottomCenter.x * 0.98, Alignment.bottomCenter.y * 0.8),
        child: Container(
            width: 275,
            height: 5,
            child: LinearProgressIndicator(
              value: valor,
              backgroundColor: Colors.transparent,
              color: Colors.green.withAlpha(200),
              minHeight: 6,
            )),
      )
    ],
  );
}

String diasDaSemana() {
  var sunday = 7;
  var monday = 1;
  DateTime date = DateTime.now();
  var lastSunday = date.subtract(Duration(days: date.weekday - sunday)).day;
  var lastMonday = date.subtract(Duration(days: date.weekday - monday)).day;
  return "$lastMonday - $lastSunday";
}
