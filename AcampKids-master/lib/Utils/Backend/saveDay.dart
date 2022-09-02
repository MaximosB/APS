import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Dias.dart';
import 'package:acamp_kids/Model/Semana.dart';

class DiasMock {
  Dia criarDia1() {
    Atividade atividade1 = new Atividade();
    Dia dia1 = new Dia();

    atividade1.hrsDeExercicios = 30;
    atividade1.hrsDormidas = 400;
    atividade1.qtdComidaSaudavel = 1;
    atividade1.qtdAguaConsumida = 8;
    atividade1.qtdEmFastFood = 1;
    atividade1.qtdEmTela = 400;

    dia1.atividade = atividade1;
    atividade1.pegarPontos(true, true);
    dia1.atividadesDoDia();
    return dia1;
  }

  Dia criarDia2() {
    Atividade atividade = new Atividade();
    Dia dia = new Dia();

    atividade.hrsDeExercicios = 30;
    atividade.hrsDormidas = 750;
    atividade.qtdComidaSaudavel = 6;
    atividade.qtdAguaConsumida = 8;
    atividade.qtdEmFastFood = 0;
    atividade.qtdEmTela = 20;

    dia.atividade = atividade;
    atividade.pegarPontos(true, true);
    dia.atividadesDoDia();
    return dia;
  }

  Dia criarDia3() {
    Atividade atividade = new Atividade();
    Dia dia = new Dia();

    atividade.hrsDeExercicios = 0;
    atividade.hrsDormidas = 80;
    atividade.qtdComidaSaudavel = 2;
    atividade.qtdAguaConsumida = 5;
    atividade.qtdEmFastFood = 3;
    atividade.qtdEmTela = 40;

    dia.atividade = atividade;
    atividade.pegarPontos(true, true);
    dia.atividadesDoDia();
    return dia;
  }

  Semana criarSemana() {
    List<Dia> diasMock = [criarDia1(), criarDia2(), criarDia3()];
    return new Semana(diasMock);
  }
}
