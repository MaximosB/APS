import 'package:acamp_kids/Model/Atividades.dart';

class Dia {
  int qtdPontos = 0;
  Atividade atividade;

  void atividadesDoDia() {
    qtdPontos = atividade.somarPontosTotal(true, true);
  }
}
