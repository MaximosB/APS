import 'package:acamp_kids/Utils/Backend/Singleton.dart';

class Atividade {
  int hrsDormidas = -1;
  int qtdComidaSaudavel = -1;
  int qtdAguaConsumida = -1;
  int hrsDeExercicios = -1;
  int qtdEmTela = -1;
  int qtdEmFastFood = -1;
  int dia_semana = 0;
  int semana_ano = 0;

  int _pontosHrsDormidas;
  int _pontosQtdComidaSaudavel;
  int _pontosQtdAguaConsumida;
  int _pontosHrsDeExercicios;
  int _pontosQtdEmTela;
  int _pontosQtdEmFastFood;
  //ids atividade

  int getPontosHrsDormidas() {
    return _pontosHrsDormidas;
  }

  int getPontosAguaConsumida() {
    return _pontosQtdAguaConsumida;
  }

  int getPontosComidaSaudavel() {
    return _pontosQtdComidaSaudavel;
  }

  int getPontosHrsDeExercicios() {
    return _pontosHrsDeExercicios;
  }

  int getPontosQtdEmTela() {
    return _pontosQtdEmTela;
  }

  int getPontosEmFastFood() {
    return _pontosQtdEmFastFood;
  }

  int _pegaValorInt(int valorMin, int valorRecebido, int valorMax) {
    if (valorRecebido == -1) {
      return 0;
    } else if (valorRecebido <= valorMin) {
      return 1;
    } else if (valorRecebido > valorMin && valorRecebido < valorMax) {
      return 2;
    } else {
      return 3;
    }
  }

  int _pegaValorDouble(int valorMin, int valorRecebido, int valorMax) {
    if (valorRecebido == -1) {
      return 0;
    } else if (valorRecebido <= valorMin) {
      return 1;
    } else if (valorRecebido > valorMin && valorRecebido < valorMax) {
      return 2;
    } else {
      return 3;
    }
  }

  int _pegarValorInvertidoInt(
      int valorMin, int valorRecebido, int valorMax, bool foiClicado) {
    if (foiClicado) {
      if (valorRecebido == 0) {
        return 3;
      } else if (valorRecebido <= valorMin && valorRecebido != -1) {
        return 2;
      } else if (valorRecebido > valorMin && valorRecebido <= valorMax) {
        return 1;
      }
    }
    // else {
    return 0;
    // }
  }

  int _pegaValorInvertidoDouble(
    int valorMin,
    int valorRecebido,
    int valorMax,
    bool foiClicado,
  ) {
    if (foiClicado) {
      if (valorRecebido == 0) {
        return 3;
      } else if (valorRecebido <= valorMin && valorRecebido != -1) {
        return 2;
      } else if (valorRecebido > valorMin && valorRecebido <= valorMax) {
        return 1;
      }
    }
    // else {
    return 0;
    // }
  }

  void pegarPontos(bool foiClicadoInt, bool foiClicadoDouble) {
    //Pegar horas dormidas

    _pontosHrsDormidas = _pegaValorDouble(Singleton.valorMinHrsDormidas,
        hrsDormidas, Singleton.valorMaxHrsDormidas);
    _pontosHrsDeExercicios = _pegaValorDouble(Singleton.valorMinHrsExerc,
        hrsDeExercicios, Singleton.valorMaxHrsExerc);
    //invertido
    _pontosQtdEmTela = _pegaValorInvertidoDouble(Singleton.valorMinQtdEmTela,
        qtdEmTela, Singleton.valorMaxQtdEmTela, foiClicadoDouble);

    _pontosQtdComidaSaudavel = _pegaValorInt(
        Singleton.valorMinqtdComidaSaudavel,
        qtdComidaSaudavel,
        Singleton.valorMaxqtdComidaSaudavel);

    _pontosQtdAguaConsumida = _pegaValorInt(Singleton.valorMinqtdAguaConsumida,
        qtdAguaConsumida, Singleton.valorMaxqtdAguaConsumida);

    //invertido
    _pontosQtdEmFastFood = _pegarValorInvertidoInt(
      Singleton.valorMinqtdEmFastFood,
      qtdEmFastFood,
      Singleton.valorMaxqtdEmFastFood,
      foiClicadoInt,
    );
  }

  int somarPontosTotal(bool foiClicadoInt, bool foiClicadoDouble) {
    pegarPontos(foiClicadoInt, foiClicadoDouble);
    int valorTotal = 0;
    //Pegar horas dormidas
    valorTotal += _pontosHrsDormidas;
    valorTotal += _pontosHrsDeExercicios;
    //invertido
    valorTotal += _pontosQtdEmTela;

    valorTotal += _pontosQtdComidaSaudavel;

    valorTotal += _pontosQtdAguaConsumida;

    //invertido
    valorTotal += _pontosQtdEmFastFood;

    return valorTotal;
  }
}
