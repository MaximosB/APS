import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Model/Pontuacao.dart';
import 'package:acamp_kids/Model/Trofeu.dart';

class Semana {
  List<Dia> dias = [];
  Pontuacao pontuacao;
  TipoTrofeu trofeu;

  Semana(List<Dia> dias) {
    this.dias += dias;
  }

  void addDias(Dia dia) {
    dias.add(dia);
  }

  void pegarPontos(Dia dia) {
    pontuacao.qtdPontosTotais += dia.qtdPontos;
  }

  void operacaoDia(Dia dia) {
    addDias(dia);
    pegarPontos(dia);
  }

  Semana.finalSemana(Pontuacao pontos, TipoTrofeu trofeu) {
    if (dias.isNotEmpty && dias.length == 7) {
      this.pontuacao = pontos;
      this.trofeu = trofeu;
    }
  }
}
