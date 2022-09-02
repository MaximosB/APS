import 'package:acamp_kids/Controller/autenticationController.dart';
import 'package:acamp_kids/Model/Atividades.dart';
import 'package:acamp_kids/Model/Pontuacao.dart';
import 'package:acamp_kids/Model/Trofeu.dart';
import 'package:acamp_kids/Utils/Backend/saveDay.dart';
import 'package:acamp_kids/Utils/Backend/telaPrincipal.dart';
import 'package:acamp_kids/Utils/Styles/popUpInfo.dart';
import 'package:acamp_kids/View/Tela%20Calendario/calendario.dart';
import 'package:acamp_kids/View/Tela%20Calendario/menu.dart';
import 'package:acamp_kids/View/trofeu.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:acamp_kids/Utils/Database/database.dart';
import 'package:acamp_kids/Utils/Backend/Utils.dart';

enum TipoDeValor { int, double }
enum TipoAtividade { sono, come, brinca, bebe, assiste, fastfood }

class Principal extends StatefulWidget {
  // final String documentId;

  // Principal(this.documentId);
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // StreamSubscription<User> loginStateSubscription;
  final controller = Get.put(AutenticationController());
  // final String documentId;
  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');
  // _PrincipalState(this.documentId);
  Atividade atividadeDoDia = new Atividade();
  DiasMock diasMock = new DiasMock();

  var valorDouble = 0.0;
  var valorInt = 0;
  var valores = {};

  bool foiClicadoInt = false;
  bool foiClicadoDouble = false;
  bool existeData = false;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    controller.criarAtividade(atividadeDoDia, AuthService.to.user.uid,
        dateTime.weekday, weekNumber(dateTime), dateTime.month, dateTime.year);

    valores['sono'] = atividadeDoDia.hrsDormidas;
    valores['come'] = atividadeDoDia.qtdComidaSaudavel;
    valores['brinca'] = atividadeDoDia.hrsDeExercicios;
    valores['bebe'] = atividadeDoDia.qtdAguaConsumida;
    valores['assiste'] = atividadeDoDia.qtdEmTela;
    valores['fastfood'] = atividadeDoDia.qtdEmFastFood;

    // atividadeDoDia.hrsDormidas = valores['sono'];
    // atividadeDoDia.hrsDeExercicios = valores['brinca'];
    // atividadeDoDia.qtdEmTela = valores['assiste'];

    atividadeDoDia.dia_semana = dateTime.weekday;
    atividadeDoDia.semana_ano = weekNumber(dateTime);
    super.initState();
    addValoresRecuperadosDoBanco();
    valores['assiste'] = 0;
    valores['fastfood'] = 0;
    valores['sono'] = 0;
    valores['come'] = 0;
    valores['brinca'] = 0;
    valores['bebe'] = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addValoresRecuperadosDoBanco() {
    CollectionReference atividade =
        FirebaseFirestore.instance.collection('atividadeUsuario');
    atividade
        .where("dia_semana", isEqualTo: atividadeDoDia.dia_semana)
        .where('semana_ano', isEqualTo: atividadeDoDia.semana_ano)
        .where('userId', isEqualTo: AuthService.to.user.uid)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                atividadeDoDia.dia_semana = element['dia_semana'];
                atividadeDoDia.semana_ano = element['semana_ano'];
                atividadeDoDia.hrsDormidas = valores['sono'] = element['dorme'];
                atividadeDoDia.qtdAguaConsumida =
                    valores['bebe'] = element['agua'];
                atividadeDoDia.qtdComidaSaudavel =
                    valores['come'] = element['comidaSaudavel'];
                atividadeDoDia.hrsDeExercicios =
                    valores['brinca'] = element['exercicio'];
                atividadeDoDia.qtdEmTela = valores['assiste'] = element['tv'];
                atividadeDoDia.qtdEmFastFood =
                    valores['fastfood'] = element['fastFood'];

                foiClicadoDouble = true;
                foiClicadoInt = true;

                if (valores['assiste'] == -1) {
                  valores['assiste'] = 0;
                  foiClicadoInt = false;
                }
                if (valores['fastfood'] == -1) {
                  valores['fastfood'] = 0;
                  foiClicadoDouble = false;
                }
                if (valores['sono'] == -1) {
                  valores['sono'] = 0;
                }
                if (valores['bebe'] == -1) {
                  valores['bebe'] = 0;
                }
                if (valores['brinca'] == -1) {
                  valores['brinca'] = 0;
                }
                if (valores['come'] == -1) {
                  valores['come'] = 0;
                }
                atividadeDoDia.pegarPontos(foiClicadoInt, foiClicadoDouble);
              })
            });
  }

  Widget _botaoDeFechar(BuildContext context) {
    return Align(
      alignment: Alignment(
          (Alignment.topRight.x * 0.96), (Alignment.topRight.y * 0.96)),
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

  Widget _imagemPopUp(String imageName) {
    return Align(
      alignment: Alignment(Alignment.center.x, (Alignment.topCenter.y * 0.75)),
      child: Image.asset(
        imageName,
        // width: 99,
        // height: 99,
      ),
    );
  }

  Widget showAlertDialog1(BuildContext context, String imageName,
      TipoDeValor tipo, String atividade, TipoAtividade tipoAtividade, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent.withAlpha(0),
            child: Center(
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/principal/Fundo1.png"),
                  ),
                ),
                child: Container(
                  height: 325.54,
                  width: 316.08,
                  child: Stack(
                    children: [
                      _botaoDeFechar(context),
                      _imagemPopUp(imageName),
                      Align(
                        alignment: Alignment(Alignment.center.x,
                            (Alignment.bottomCenter.y * 0.20)),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: _buildBtn(
                                  () {
                                    setState(() {
                                      switch (tipo) {
                                        case TipoDeValor.int:
                                          switch (tipoAtividade) {
                                            case TipoAtividade.come:
                                              if (valores[atividade] != 0) {
                                                valores[atividade] -= 1;
                                              }
                                              atividadeDoDia.qtdComidaSaudavel =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.bebe:
                                              if (valores[atividade] != 0) {
                                                valores[atividade] -= 1;
                                              }
                                              atividadeDoDia.qtdAguaConsumida =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.fastfood:
                                              foiClicadoInt = true;
                                              if (valores[atividade] != 0) {
                                                valores[atividade] -= 1;
                                              }
                                              atividadeDoDia.qtdEmFastFood =
                                                  valores[atividade];
                                              break;
                                            default:
                                          }
                                          break;
                                        case TipoDeValor.double:
                                          switch (tipoAtividade) {
                                            case TipoAtividade.sono:
                                              valores[atividade] =
                                                  decrescimoHoras(
                                                      valores[atividade], 0);

                                              atividadeDoDia.hrsDormidas =
                                                  valores[atividade];

                                              break;
                                            case TipoAtividade.brinca:
                                              valores[atividade] =
                                                  decrescimoHoras(
                                                      valores[atividade], 0);
                                              atividadeDoDia.hrsDeExercicios =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.assiste:
                                              foiClicadoDouble = true;
                                              valores[atividade] =
                                                  decrescimoHoras(
                                                      valores[atividade], 0);
                                              atividadeDoDia.qtdEmTela =
                                                  valores[atividade];
                                              break;
                                            default:
                                          }
                                          break;
                                      }
                                    });
                                  },
                                  AssetImage('assets/principal/BotaoMenos.png'),
                                  41,
                                  41,
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 53,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/principal/Fundo3.png"),
                                  ),
                                ),
                                child: new Center(
                                  child: new Text(
                                    mostrar_valores(
                                        atividade, valores[atividade]),
                                    // valores[atividade].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Riffic',
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: _buildBtn(
                                  () {
                                    setState(() {
                                      switch (tipo) {
                                        case TipoDeValor.int:
                                          switch (tipoAtividade) {
                                            case TipoAtividade.come:
                                              valores[atividade] += 1;
                                              atividadeDoDia.qtdComidaSaudavel =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.bebe:
                                              valores[atividade] += 1;
                                              atividadeDoDia.qtdAguaConsumida =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.fastfood:
                                              foiClicadoInt = true;
                                              if (valores[atividade] < 3) {
                                                valores[atividade] += 1;
                                              }
                                              atividadeDoDia.qtdEmFastFood =
                                                  valores[atividade];
                                              break;
                                            default:
                                          }
                                          break;
                                        case TipoDeValor.double:
                                          switch (tipoAtividade) {
                                            case TipoAtividade.sono:
                                              valores[atividade] =
                                                  acrescimoHoras(
                                                      valores[atividade], 600);
                                              atividadeDoDia.hrsDormidas =
                                                  valores[atividade];

                                              break;
                                            case TipoAtividade.brinca:
                                              valores[atividade] =
                                                  acrescimoHoras(
                                                      valores[atividade], 300);
                                              atividadeDoDia.hrsDeExercicios =
                                                  valores[atividade];
                                              break;
                                            case TipoAtividade.assiste:
                                              foiClicadoDouble = true;
                                              valores[atividade] =
                                                  acrescimoHoras(
                                                      valores[atividade], 400);
                                              atividadeDoDia.qtdEmTela =
                                                  valores[atividade];
                                              break;
                                            default:
                                          }

                                          break;
                                      }
                                    });
                                  },
                                  AssetImage('assets/principal/BotaoMais.png'),
                                  41,
                                  41,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _botaoDeOK(context, id, atividade, tipoAtividade),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _botaoDeOK(
      BuildContext context, int id, String atividade, TipoAtividade tipo) {
    return Align(
      alignment:
          Alignment(Alignment.center.x, (Alignment.bottomCenter.y * 0.88)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            switch (tipo) {
              case TipoAtividade.sono:
                if (valores[atividade] == 0) {
                  atividadeDoDia.hrsDormidas = 0;
                }
                break;
              case TipoAtividade.bebe:
                if (valores[atividade] == 0) {
                  atividadeDoDia.qtdAguaConsumida = 0;
                }
                break;
              case TipoAtividade.brinca:
                if (valores[atividade] == 0) {
                  atividadeDoDia.hrsDeExercicios = 0;
                }
                break;
              case TipoAtividade.come:
                if (valores[atividade] == 0) {
                  atividadeDoDia.qtdComidaSaudavel = 0;
                }
                break;
              case TipoAtividade.fastfood:
                if (valores[atividade] == 0) {
                  foiClicadoInt = true;
                  atividadeDoDia.qtdEmFastFood = 0;
                }
                break;
              case TipoAtividade.assiste:
                if (valores[atividade] == 0) {
                  foiClicadoDouble = true;
                  atividadeDoDia.qtdEmTela = 0;
                }
                break;
              default:
            }
            atividadeDoDia.pegarPontos(foiClicadoInt, foiClicadoDouble);
            print('OK');
            setAtividade(dateTime.weekday, weekNumber(dateTime), atividadeDoDia,
                AuthService.to.user.uid);
          });
          Navigator.of(context).pop();
        },
        child: Container(
          height: 44,
          width: 173,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/principal/BotaoOK.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "ok!",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 37,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(
      Function onTap, AssetImage logo, double height_btn, double width_btn) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height_btn,
        width: width_btn,
        // margin: EdgeInsets.only(left: 60.0, right: 20.0),
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0, 1),
          //     blurRadius: 40.0,
          //   ),
          // ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _icon(String url) {
    return Image.asset(
      url,
      width: 65,
      height: 65,
    );
  }

  Widget _icons() {
    return Align(
      alignment: Alignment(-0.40, 0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          SizedBox(height: 20),
          _buildBtn(
            () {
              return popUpInfo(context, 'assets/principal/Act1.png', "Dormir",
                  true, "Tempo ideal por dia: 8h");
            },
            AssetImage('assets/principal/Act1.png'),
            65,
            65,
          ),
          // _icon('assets/principal/Act1.png'),
          SizedBox(height: 6),
          // _icon('assets/principal/Act2.png'),
          _buildBtn(
            () {
              return popUpInfo(
                  context,
                  'assets/principal/Act2.png',
                  "Frutas e Vegetais",
                  true,
                  "Quantidade ideal por dia: 6 porções");
            },
            AssetImage('assets/principal/Act2.png'),
            65,
            65,
          ),
          SizedBox(height: 6),
          // _icon('assets/principal/Act3.png'),
          _buildBtn(
            () {
              return popUpInfo(context, 'assets/principal/Act4.png', "Água",
                  true, "Quantidade ideal por dia: 8 a 10 copos");
            },
            AssetImage('assets/principal/Act4.png'),
            65,
            65,
          ),
          SizedBox(height: 6),
          // _icon('assets/principal/Act4.png'),
          _buildBtn(
            () {
              return popUpInfo(context, 'assets/principal/Act3.png', "Esportes",
                  true, "Tempo ideal por dia: mínimo 1h");
            },
            AssetImage('assets/principal/Act3.png'),
            65,
            65,
          ),
          SizedBox(height: 6),
          // _icon('assets/principal/Act5.png'),
          _buildBtn(
            () {
              return popUpInfo(
                  context,
                  'assets/principal/Act5.png',
                  "Tempo de Tela",
                  false,
                  "Quantidade ideal por dia: menos de 2h");
            },
            AssetImage('assets/principal/Act5.png'),
            65,
            65,
          ),
          SizedBox(height: 6),
          // _icon('assets/principal/Act6.png'),
          _buildBtn(
            () {
              return popUpInfo(
                  context,
                  'assets/principal/Act6.png',
                  "Frituras e doces",
                  false,
                  "Quantidade ideal por dia: no máximo 1");
            },
            AssetImage('assets/principal/Act6.png'),
            65,
            65,
          ),
        ],
      ),
    );
  }

  Widget _btn_acts(BuildContext context) {
    return Align(
      alignment: Alignment(0.40, 0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          SizedBox(height: 20),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act1.png',
                  TipoDeValor.double, 'sono', TipoAtividade.sono, 1);
            },
            AssetImage(
                mudaImagemConforme(atividadeDoDia.getPontosHrsDormidas())),
            65.0,
            65.0,
          ),
          SizedBox(height: 6),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act2.png',
                  TipoDeValor.int, 'come', TipoAtividade.come, 2);
            },
            AssetImage(
                mudaImagemConforme(atividadeDoDia.getPontosComidaSaudavel())),
            65.0,
            65.0,
          ),
          SizedBox(height: 6),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act4.png',
                  TipoDeValor.int, 'bebe', TipoAtividade.bebe, 4);
            },
            AssetImage(
                mudaImagemConforme(atividadeDoDia.getPontosAguaConsumida())),
            65.0,
            65.0,
          ),
          SizedBox(height: 6),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act3.png',
                  TipoDeValor.double, 'brinca', TipoAtividade.brinca, 3);
            },
            AssetImage(
                mudaImagemConforme(atividadeDoDia.getPontosHrsDeExercicios())),
            65.0,
            65.0,
          ),
          SizedBox(height: 6),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act5.png',
                  TipoDeValor.double, 'assiste', TipoAtividade.assiste, 5);
            },
            AssetImage(mudaImagemConforme(atividadeDoDia.getPontosQtdEmTela())),
            65.0,
            65.0,
          ),
          SizedBox(height: 6),
          _buildBtn(
            () {
              showAlertDialog1(context, 'assets/principal/Act6.png',
                  TipoDeValor.int, 'fastfood', TipoAtividade.fastfood, 6);
            },
            AssetImage(
                mudaImagemConforme(atividadeDoDia.getPontosEmFastFood())),
            65.0,
            65.0,
          ),
        ],
      ),
    );
  }

  Widget _dia_sem() {
    return Align(
      alignment: Alignment(0.0, -1.36),
      child: Image.asset(
        "assets/principal/Day.png",
        width: 224,
        height: 160,
      ),
    );
  }

  Widget _texto_dia_semana() {
    return Align(
      alignment: Alignment(0.0, -1.02),
      child: Text(
        'Hoje',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Riffic',
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _texto_dia() {
    return Align(
      alignment: Alignment(0.0, -0.91),
      child: Text(
        diasDaSemana(),
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Bahnschrift',
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _menu() {
    return Align(
      alignment: Alignment(0.0, 1),
      child: Container(
        width: 170,
        child: Row(
          children: <Widget>[
            Flexible(
              child: _buildBtn(
                () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: menu(context),
                        );
                      });
                },
                AssetImage('assets/principal/menu1.png'),
                70.0,
                70.0,
              ),
            ),
            Flexible(
              child: _buildBtn(
                () {
                  List<Atividade> atividadesDoMes = [];
                  int valorTotal = 0;
                  List<String> trofeus = [];
                  CollectionReference atividade =
                      FirebaseFirestore.instance.collection('atividadeUsuario');
                  atividade
                      .where("mes", isEqualTo: dateTime.month)
                      .where("ano", isEqualTo: dateTime.year)
                      .where('userId', isEqualTo: AuthService.to.user.uid)
                      .get()
                      .then((value) => {
                            value.docs.forEach((element) {
                              Atividade atividade = new Atividade();
                              if(dateTime.month == element['mes']) {
                                atividade.dia_semana = element['dia_semana'];
                                atividade.semana_ano = element['semana_ano'];
                                atividade.hrsDormidas = element['dorme'];
                               atividade.qtdAguaConsumida = element['agua'];
                               atividade.qtdComidaSaudavel =
                                  element['comidaSaudavel'];
                                atividade.hrsDeExercicios = element['exercicio'];
                               atividade.qtdEmTela = element['tv'];
                                atividade.qtdEmFastFood = element['fastFood'];
                                atividade.pegarPontos(true, true);
                                valorTotal +=
                                    atividade.somarPontosTotal(true, true);
                                atividadesDoMes.add(atividade);
                              } else if(weekNumber(dateTime) == element['semana_ano']) {
                                atividade.dia_semana = element['dia_semana'];
                                atividade.semana_ano = element['semana_ano'];
                                atividade.hrsDormidas = element['dorme'];
                                atividade.qtdAguaConsumida = element['agua'];
                                atividade.qtdComidaSaudavel =
                                  element['comidaSaudavel'];
                               atividade.hrsDeExercicios = element['exercicio'];
                                atividade.qtdEmTela = element['tv'];
                                atividade.qtdEmFastFood = element['fastFood'];
                                atividade.pegarPontos(true, true);
                                valorTotal +=
                                  atividade.somarPontosTotal(true, true);
                               atividadesDoMes.add(atividade);
                              }
                            })
                          })
                      .whenComplete(() => {
                            atividadesDoMes.sort((a, b) {
                              return a.semana_ano
                                  .toString()
                                  .toLowerCase()
                                  .compareTo(
                                      b.semana_ano.toString().toLowerCase());
                            }),
                            trofeus = separaAtividadesSemanas(atividadesDoMes),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: showTrofeus(context, trofeus, valorTotal),
                                  );
                                })
                          });
                },
                AssetImage('assets/principal/menu2.png'),
                70.0,
                70.0,
              ),
            ),
            Flexible(
              child: _buildBtn(
                () {
                  List<Atividade> atividadesDaSemana = [];
                  int valorTotal = 0;
                  CollectionReference atividade =
                      FirebaseFirestore.instance.collection('atividadeUsuario');
                  atividade
                      .where("semana_ano", isEqualTo: weekNumber(dateTime))
                      .where('userId', isEqualTo: AuthService.to.user.uid)
                      .get()
                      .then((value) => {
                            value.docs.forEach((element) {
                              Atividade atividade = new Atividade();
                              atividade.dia_semana = element['dia_semana'];
                              atividade.semana_ano = element['semana_ano'];
                              atividade.hrsDormidas = element['dorme'];
                              atividade.qtdAguaConsumida = element['agua'];
                              atividade.qtdComidaSaudavel =
                                  element['comidaSaudavel'];
                              atividade.hrsDeExercicios = element['exercicio'];
                              atividade.qtdEmTela = element['tv'];
                              atividade.qtdEmFastFood = element['fastFood'];
                              atividade.pegarPontos(true, true);
                              valorTotal +=
                                  atividade.somarPontosTotal(true, true);
                              atividadesDaSemana.add(atividade);
                            })
                          })
                      .whenComplete(() => {
                            verficaDiasExistentes(
                                atividadesDaSemana, atividadesDaSemana.length),
                            atividadesDaSemana.sort((a, b) {
                              return a.dia_semana
                                  .toString()
                                  .toLowerCase()
                                  .compareTo(
                                      b.dia_semana.toString().toLowerCase());
                            }),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showCalendario(
                                      context,
                                      AuthService.to.user.uid,
                                      weekNumber(dateTime),
                                      atividadesDaSemana,
                                      valorTotal);
                                })
                          });
                },
                AssetImage('assets/principal/menu3.png'),
                70.0,
                70.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _teste() {
    return Align(
      alignment: Alignment(0.0, 0.0),
      child: Container(
          // alignment: Alignment.centerLeft,
          height: 520,
          width: 400,
          decoration: BoxDecoration(
            // border: Border(
            //   top: BorderSide(width: 2.0, color: Colors.red),
            //   left: BorderSide(width: 2.0, color: Colors.red),
            //   right: BorderSide(width: 2.0, color: Colors.red),
            //   bottom: BorderSide(width: 2.0, color: Colors.red),
            // ),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/principal/Action1.png'),
            ),
          ),
          child: Stack(
            children: <Widget>[
              _dia_sem(),
              _texto_dia_semana(),
              _texto_dia(),
              _icons(),
              _btn_acts(context),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(AuthService.to.user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: 1000,
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.bottomCenter,
                          //   end: Alignment.topCenter,
                          //   colors: [
                          //     Color(0xFFCAD3E7),
                          //     Color(0xFFC1C9E2),
                          //   ],
                          // ),
                          color: Color(0xFFCAD3E7),
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            // horizontal: 120.0,
                            // vertical: 40.0,
                            vertical: MediaQuery.of(context).size.width * 0.17,
                          ),
                          child: Column(
                            children: <Widget>[
                              _teste(),
                              _menu(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }

  String converteString(double valor, int valor2) {
    if (valor2 < valor && (valor2 + 1) > valor) {
      return '${valor.toInt()}:30';
    } else {
      return '${valor.toInt()}:00';
    }
  }

  double converteDouble(String valor) {
    double num;
    try {
      if (valor.characters.elementAt(2) == ':') {
        double primeiroNum = double.tryParse(valor.characters.first) * 10;
        double segundoNum = double.tryParse(valor.characters.elementAt(1));
        num = primeiroNum + segundoNum;
      } else {
        num = double.tryParse(valor.characters.first);
      }
      if (valor.characters.elementAt(2) == '3') {
        num += 0.50;
      } else if (valor.characters.elementAt(3) == '3') {
        num += 0.50;
      }
      return num;
    } catch (e) {
      return 0.0;
    }
  }

  int acrescimoHoras(int valor, int valorMax) {
    if (valor < valorMax) {
      valor += 30;
    }
    return valor;
  }

  int decrescimoHoras(int valor, int valorMin) {
    if (valor > valorMin) {
      valor -= 30;
    }
    return valor;
  }

  String diasDaSemana() {
    var dias = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo',
    ];
    var mes = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];

    DateTime date = DateTime.now();

    return "${dias[date.weekday - 1]} - ${date.day}, ${mes[date.month - 1]} ";
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  String trofeuDaSemana(int valor) {
    TipoPontos pontos = new TipoPontos();
    Pontuacao pontuacao = new Pontuacao();
    pontuacao.qtdPontosTotais = valor;

    switch (pontos.totalDePontos(pontuacao)) {
      case TipoTrofeu.bronze:
        return 'assets/principal/Trophy_Bronze.png';
        break;
      case TipoTrofeu.prata:
        return 'assets/principal/Trophy_Silver.png';
        break;
      case TipoTrofeu.ouro:
        return 'assets/principal/Trophy_Gold.png';
        break;
      default:
        return 'assets/principal/Trofeu4.png';
    }
  }

  void verficaDiasExistentes(List<Atividade> semana, int quantidade) {
    DateTime date = DateTime.now();
    int numero = quantidade;
    int i = 1;
    if (numero < date.weekday) {
      semana.forEach((element) {
        if (i != date.weekday) {
          while (element.dia_semana > i) {
            Atividade atividadeDia = new Atividade();
            atividadeDia.dia_semana = i;
            atividadeDia.hrsDeExercicios = -1;
            atividadeDia.hrsDormidas = -1;
            atividadeDia.qtdAguaConsumida = -1;
            atividadeDia.qtdComidaSaudavel = -1;
            atividadeDia.qtdEmFastFood = -1;
            atividadeDia.qtdEmTela = -1;
            atividadeDia.semana_ano = weekNumber(dateTime);
            controller.criarAtividade(
                atividadeDia, AuthService.to.user.uid, i, weekNumber(dateTime), dateTime.month, dateTime.year);
            semana.add(atividadeDia);
            i++;
          }
          i++;
        }
      });
    }
  }

  List<String> separaAtividadesSemanas(List<Atividade> mes) {
    List<Atividade> semana1 = [];
    List<Atividade> semana2 = [];
    List<Atividade> semana3 = [];
    List<Atividade> semana4 = [];
    List<Atividade> dias = mes;
    int valorTotalSemana1 = 0;
    int valorTotalSemana2 = 0;
    int valorTotalSemana3 = 0;
    int valorTotalSemana4 = 0;
    _separaDiasEColocaSemana(dias, semana1);
    valorTotalSemana1 = _calculaValorTotalSemanal(semana1);
    _separaDiasEColocaSemana(dias, semana2);
    valorTotalSemana2 = _calculaValorTotalSemanal(semana2);
    _separaDiasEColocaSemana(dias, semana3);
    valorTotalSemana3 = _calculaValorTotalSemanal(semana3);
    _separaDiasEColocaSemana(dias, semana4);
    valorTotalSemana4 = _calculaValorTotalSemanal(semana4);
    
    return [
      trofeuDaSemana(valorTotalSemana1), 
      trofeuDaSemana(valorTotalSemana2), 
      trofeuDaSemana(valorTotalSemana3), 
      trofeuDaSemana(valorTotalSemana4)
    ];
  }

  void _separaDiasEColocaSemana(List<Atividade> dias, List<Atividade> semana) {
    int i = 0;
    if (dias.length == 0) {
      semana = [];
    } else {
      do {
        semana.add(dias.elementAt(0));
        dias.removeAt(0); 
       i++;
      } while (i < 7 && dias.length >= 1);
    }
  }

  int _calculaValorTotalSemanal(List<Atividade> semana) {
    int valor = 0;
    if(semana.length != 0) {
   semana.forEach((element) {
      valor += element.somarPontosTotal(true, true);
    });
    }

    return valor;
  }
  
}

String mudaImagemConforme(int valor) {
  switch (valor) {
    case 1:
      return 'assets/principal/Face1.png';
      break;
    case 2:
      return 'assets/principal/Face2.png';
      break;
    case 3:
      return 'assets/principal/Face3.png';
      break;
    default:
      return 'assets/principal/Boot.png';
  }
}

String mostrar_valores(String atv, int valor) {
  if ((atv == 'sono') | (atv == 'assiste') | (atv == 'brinca')) {
    return Utils.date(valor);
  } else {
    return valor.toString();
  }
}
