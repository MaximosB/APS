import 'package:acamp_kids/Model/Pontuacao.dart';
import 'package:acamp_kids/Model/Trofeu.dart';

class TipoPontos {
  int pontosMax = 114;
  int pontosMedio = 84;
  int pontosMin = 48;

  TipoTrofeu totalDePontos(Pontuacao pontos) {
    if (pontos.qtdPontosTotais < pontosMin) {
      return TipoTrofeu.consolacao;
    } else if (pontos.qtdPontosTotais >= pontosMin &&
        pontos.qtdPontosTotais < pontosMedio) {
      return TipoTrofeu.bronze;
    } else if (pontos.qtdPontosTotais >= pontosMedio &&
        pontos.qtdPontosTotais < pontosMax) {
      return TipoTrofeu.prata;
    } else {
      return TipoTrofeu.ouro;
    }
  }
}
