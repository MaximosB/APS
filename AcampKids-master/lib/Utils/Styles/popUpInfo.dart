import 'package:flutter/material.dart';

var informacoes = {
  "Dormir":
      "Dormir bem ajuda o corpo a se recuperar e ficar mais disposto para você fazer muita coisa legal durante o dia!",
  "Frutas e Vegetais":
      "Algumas vitaminas importantes para você ficar forte e protegidos das doenças só existem nas frutas, verduras e legumes!",
  "Água":
      "Para nosso corpo funcionar bem é necessessário mantê-lo bem hidratado sempre. Beba bastante água!",
  "Esportes":
      "Mover-se melhora a saúde dos ossos, dos músculos, do coração, além de ajudar a melhorar as notas na escola e formar novos amigos!",
  "Tempo de Tela":
      "Mais de 2h em frente às telas de televisão, computador e celular deixa você doente e te estimula a comer alimentos nem sempre bons para a saúde!",
  "Frituras e doces":
      "Os alimentos cheios de açúcar e gordura enganam seu cérebro fazendo você achar que precisa comê-los cada vez mais. Mas eles fazem muito mal pra saúde.",
};

Widget popUpInfo(BuildContext context, String imageName, String titulo,
    bool eSaudavel, String tempoIdeal) {
  showDialog(
      context: context,
      builder: (BuildContext builder) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: _principalInformacao(context, titulo, imageName, eSaudavel, tempoIdeal),
        );
      });
}

Widget _titulo(String titulo) {
  return Align(
    alignment: Alignment(Alignment.topCenter.x, (Alignment.topCenter.y * 0.85)),
    child: Text(
      titulo,
      style: TextStyle(
        color: Color(0xFF95A4CA),
        fontFamily: 'Riffic',
        fontSize: 22,
      ),
    ),
  );
}

Widget _imagem(String imageName) {
  return Align(
    alignment: Alignment(Alignment.center.x, (Alignment.topCenter.y * 0.50)),
    child: Image.asset(
      imageName,
      width: 125,
      height: 100,
    ),
  );
}

Widget _alerta(bool naoESaudavel) {
  return Center(
    child: Visibility(
      visible: naoESaudavel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/popUp/Alert.png"),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
          Text(
            'Alerta!',
            style: TextStyle(
              color: Color(0xFF95A4CA),
              fontFamily: 'Bahnschrift',
              fontSize: 22,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget botaoDeFechar(BuildContext context) {
  return Align(
    alignment: Alignment(
        (Alignment.topRight.x * 0.945), (Alignment.topRight.y * 0.955)),
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

Widget _contexto(String titulo, BuildContext context) {
  return Align(
    alignment:
        Alignment(Alignment.topCenter.x, (Alignment.topCenter.y * -0.45)),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.550,
      height: MediaQuery.of(context).size.width * 0.20,
      child: Text(
        informacoes[titulo],
        maxLines: 6,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF95A4CA),
          fontFamily: 'Bahnschrift',
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget _idealContexto(String tempoIdeal) {
  return Align(
    alignment:
        Alignment(Alignment.bottomCenter.x, (Alignment.bottomCenter.y * 0.70)),
    child: Text(
      tempoIdeal,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF95A4CA),
        fontFamily: 'Bahnschrift',
        fontSize: 15,
      ),
    ),
  );
}

Widget _principalInformacao(BuildContext context,
    String titulo, String imageName, bool eSaudavel, String tempoIdeal) {
  return Align(
    alignment: Alignment(0.0, 0.0),
    child: Container(
      height: 407,
      width: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/popUp/Fundo4.png'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          botaoDeFechar(context),
          _titulo(titulo),
          _imagem(imageName),
          _alerta(!eSaudavel),
          _contexto(titulo, context),
          _idealContexto(tempoIdeal),
        ],
      ),
    ),
  );
}
