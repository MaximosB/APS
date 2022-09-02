import 'package:flutter/material.dart';

Widget showTrofeus(BuildContext context, List<String> trofeus, int valorTotal) {
  var screenSize = MediaQuery.of(context).size;
  // var alignScreen = MediaQuery.of(context).viewPadding;
  // print('size of screen: ${screenSize}');
  // print('size of screen: ${alignScreen}');
  return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(05),
      child: _principalWidgetTrofeus(screenSize, context, trofeus, valorTotal));
}

String geraTrofeuPrincipal(int valorTotal) {
  int pontosMax = 456;
  int pontosMedio = 336;
  int pontosMin = 192;

  if (valorTotal < pontosMin) {
    return 'assets/principal/Trofeu4.png';
  } else if (valorTotal >= pontosMin &&
      valorTotal < pontosMedio) {
    return 'assets/principal/Trophy_Bronze.png';
  } else if (valorTotal >= pontosMedio &&
      valorTotal < pontosMax) {
    return 'assets/principal/Trophy_Silver.png';
  } else {
    return 'assets/principal/Trophy_Gold.png';
  }
}

Widget _imagemDia() {
  return Align(
    alignment:
        Alignment(Alignment.topLeft.x * 0.59, (Alignment.topCenter.y * 0.76)),
    child: Image.asset(
      "assets/login/Trofeu1.png",
      width: 50.26,
      height: 55.99,
    ),
  );
}

Widget _titulo() {
  return Align(
    alignment: Alignment(
        (Alignment.topRight.x * 0.10), (Alignment.topCenter.y * 0.76)),
    child: Text(
      'Sala de\nTroféus',
      style: TextStyle(
        color: Color(0xFF95A4CA),
        fontFamily: 'Riffic',
        fontSize: 24,
        letterSpacing: 1.5,
      ),
    ),
  );
}

Widget _subTitulo() {
  return Align(
    alignment:
        Alignment((Alignment.topRight.x * 0.10), (Alignment.topCenter.y * 0.4)),
    child: Text(
      'Confira aqui na salinha\nas conquistas do mês',
      style: TextStyle(
        color: Color(0xFF95A4CA),
        fontFamily: 'Bahnschrift',
        fontSize: 13,
      ),
    ),
  );
}

Widget botaoDeFechar(BuildContext context) {
  return Align(
    alignment: Alignment(
        (Alignment.centerRight.x * 0.96), (Alignment.topCenter.y * 0.97)),
    child: InkResponse(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Image.asset(
        "assets/semanal/Back.png",
      ),
    ),
  );
}

Widget _trofeuMenor1(String trofeu) {
  return Align(
    alignment:
        Alignment(Alignment.topLeft.x * 0.5, (Alignment.topCenter.y * 0.05)),
    child: Image.asset(
      trofeu,
      width: 56,
      height: 56,
    ),
  );
}
Widget _trofeuMenor2(String trofeu) {
  return Align(
    alignment:
        Alignment(Alignment.topRight.x * 0.5, (Alignment.topCenter.y * 0.05)),
    child: Image.asset(
      trofeu,
      width: 56,
      height: 56,
    ),
  );
}
Widget _trofeuMaior1(String trofeu) {
  return Align(
    alignment:
        Alignment((Alignment.centerLeft.x * 0.7), (Alignment.bottomCenter.y * 0.6)),
    child: Image.asset(
      trofeu,
      width: 63,
      height: 63,
    ),
  );
}
Widget _trofeuMaior2(String trofeu) {
  return Align(
    alignment:
        Alignment((Alignment.centerRight.x * 0.7), (Alignment.bottomCenter.y * 0.6)),
    child: Image.asset(
      trofeu,
      width: 63,
      height: 63,
    ),
  );
}

Widget mostraTrofeuPrincipal(int valorTotal) {
  return Align(
    alignment:
        Alignment((Alignment.bottomCenter.x), (Alignment.bottomCenter.y * 0.3)),
    child: Image.asset(
      geraTrofeuPrincipal(valorTotal),
      width: 79,
      height: 79,
    ),
  );
}

Widget _principalWidgetTrofeus(
    Size screenSize, BuildContext context, List<String> trofeus, int valorTotal) {
  return Align(
    alignment: Alignment(0.0, 0.0),
    child: Container(
        height: 413.27,
        width: 313.42,
        decoration: BoxDecoration(
          image: DecorationImage(
            // fit: BoxFit.fitHeight,
            image: AssetImage('assets/principal/Action2.png'),
          ),
        ),
        child: Stack(
          children: <Widget>[
            botaoDeFechar(context),
            _imagemDia(),
            _titulo(),
            _subTitulo(),
            _trofeuMenor1(trofeus.elementAt(0)),
            _trofeuMenor2(trofeus.elementAt(1)),
            mostraTrofeuPrincipal(valorTotal),
            _trofeuMaior1(trofeus.elementAt(2)),
            _trofeuMaior2(trofeus.elementAt(3)),
          ],
        )),
  );
}
