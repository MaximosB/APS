class Singleton {
  static final Singleton _singleton = Singleton._internal();
  static int valorMinHrsDormidas = 360;
  static int valorMaxHrsDormidas = 480;
  static int valorMinHrsExerc = 60;
  static int valorMaxHrsExerc = 150;
  static int valorMinQtdEmTela = 90;
  static int valorMaxQtdEmTela = 240;
  static int valorMinqtdEmFastFood = 1;
  static int valorMaxqtdEmFastFood = 3;
  static int valorMinqtdAguaConsumida = 6;
  static int valorMaxqtdAguaConsumida = 8;
  static int valorMinqtdComidaSaudavel = 3;
  static int valorMaxqtdComidaSaudavel = 6;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
