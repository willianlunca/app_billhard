import 'package:app_billhard/screens/login.dart';
import 'package:app_billhard/screens/menu.dart';
import 'package:app_billhard/services/auth.dart';
import 'package:app_billhard/services/splashVideo.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart'; // caminho relativo para acessar a pasta colors
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  bool _menuEstado = false;
  @override
  Widget build(BuildContext context) {
    const descricaoEquipamento = "Câmara Fria Nutribreads";
    const produto = "Pão Francês";
    const setor = "Depósito";
    const statusProduto = "PRODUTO EM SEGURANÇA";
    const ultimaTransmissao = "2 min";
    const temperAtual = -15.4;
    const temperMedia = -15.4;
    const serialModulo = "BHD-21909852025";
    const double minYGraficoDiario = -25.0;
    const double maxYGraficoDiario = 12.0;

    const double larguraMenu = 260;

    if (!_menuEstado) {}
    return Scaffold(
      backgroundColor: verdePrincipal,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              margin: const EdgeInsets.only(top: 70),
              width:
                  MediaQuery.of(context).size.width *
                  0.93, // 93% da largura da tela
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo/termokip-versao-15.png',
                    // largura da imagem
                    height: 80, // altura da imagem
                  ),
                  IconButton(
                    //*********************************************************************************************************** */
                    onPressed: () async {
                      GlobalSideMenu.I.toggle();

                      //await updateSplash(context, show: true);
                      /** Encerra a secao do usuario no supabase  */
                      //await Supabase.instance.client.auth.signOut();

                      /** Busca o uuid do usuario passado na funcao  */
                      /*final id = await getUserIdByEmail(
                        "willian_lunca@hotmail.com",
                      );

                      if (id != null) {
                        print("ID do usuário: $id");
                      } else {
                        print("Usuário não encontrado.");
                      }
                      */
                      //await updateSplash(context, show: false);
                      /** Forca a voltar para pagina de login */
                      /*
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Login()),
                        (Route<dynamic> route) =>
                            false, // remove todas as rotas anteriores
                      );
                      */

                      print("Botão Menu Pressionado");
                    },
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    iconSize: 35,
                  ),
                ],
              ),
            ),

            Expanded(
              // expande o conteudo abaixo do cabecalho, tornando uma lista dinamica.
              child: RefreshIndicator(
                onRefresh: () async {
                  print("Atualizando...");
                },
                color: Colors.black, // cor da “bolinha”/ícone que gira
                backgroundColor: verdeSecundario, // cor do círculo de fundo
                strokeWidth: 2.0, // espessura do traço do spinner
                child: MediaQuery.removePadding(
                  // Remove o espaco entre os elementos e o cabecalho.
                  context: context,
                  removeTop:
                      true, // Diz onde remover o espaco, top, left, right, bottom
                  child: ListView(
                    children: [
                      /** parou aqui  */
                      if (!_menuEstado)
                        Center(
                          child: FractionallySizedBox(
                            /* Inicio do card localizacao do equipamento e produto */
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width *
                                  0.93, // 93% da largura da tela
                              height: 140,
                              decoration: BoxDecoration(
                                color: verdeSecundario,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          descricaoEquipamento,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Produto:",
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    produto,
                                                    style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Seção:",
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    setor,
                                                    style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Ultima Transmissão:",
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    ultimaTransmissao,
                                                    style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Serial do modulo:",
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    serialModulo,
                                                    style: const TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      /* Inicio do card com informacoes de  temperatura */
                      Container(
                        margin: EdgeInsets.only(top: 5),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.93,
                              // 93% da largura da tela
                              height: 140,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.915 /
                                        2, // 93% da largura da tela
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      color: terraCota,
                                    ),

                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Temperatura Atual',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 138,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            temperAtual
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 44,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            '°C',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 22,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.915 /
                                        2, // 93% da largura da tela
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: bege,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 15,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Temperatura Média',
                                                      style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 138,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,

                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                  top: 10,
                                                                ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  temperMedia
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        44,
                                                                    color:
                                                                        terraCota,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            '°C',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 22,
                                                              color: terraCota,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width:
                                MediaQuery.of(context).size.width *
                                0.93, // 93% da largura da tela
                            height: 60,

                            decoration: BoxDecoration(
                              color: terraCota,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  statusProduto,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            "Gráfico de temperatura",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 20,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            "24h",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 35,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.93, // 93% da largura da tela
                                    height: 270,
                                    child: LineChart(
                                      LineChartData(
                                        lineTouchData: LineTouchData(
                                          handleBuiltInTouches:
                                              true, // garante o tooltip padrão
                                          touchTooltipData: LineTouchTooltipData(
                                            getTooltipColor: (touchedSpot) =>
                                                verdeSecundario,
                                            fitInsideHorizontally: true,
                                            fitInsideVertically: true,
                                            getTooltipItems: (touchedSpots) {
                                              return touchedSpots.map((spot) {
                                                return LineTooltipItem(
                                                  '${spot.y.toStringAsFixed(1)} °C', // texto do valor
                                                  const TextStyle(
                                                    color: Colors
                                                        .black, // ⬅️ cor do texto do tooltip
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                          ),
                                        ),

                                        minX: 0,
                                        maxX: 23, // você tem 24 pontos (0..23)
                                        minY: minYGraficoDiario,
                                        maxY: maxYGraficoDiario,
                                        gridData: FlGridData(
                                          show: true, // ativa o grid
                                          drawVerticalLine:
                                              false, // 🔴 só horizontais
                                          horizontalInterval:
                                              5, // intervalo entre linhas (ex: a cada 5 unidades)
                                          getDrawingHorizontalLine: (value) {
                                            return FlLine(
                                              color: Colors.black26,
                                              // cor das linhas
                                              strokeWidth: 1, // espessura
                                              dashArray: [
                                                5,
                                                5,
                                              ], // opcional: linhas tracejadas
                                            );
                                          },
                                        ),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          topTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ), // 🔴 sem títulos no topo
                                          ),
                                          rightTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ), // 🔴 sem títulos à direita
                                          ),
                                        ),

                                        borderData: FlBorderData(show: false),

                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: const [
                                              FlSpot(
                                                00,
                                                -15.4,
                                              ), // leitura inicial
                                              FlSpot(01, -15.2), // após 1 min
                                              FlSpot(02, -15.6), // após 2 min
                                              FlSpot(03, -15.3), // após 3 min
                                              FlSpot(04, -15.4),
                                              FlSpot(05, -15.4),
                                              FlSpot(06, -12.3),
                                              FlSpot(07, -12.4),
                                              FlSpot(08, -12.5),
                                              FlSpot(09, -8.4),
                                              FlSpot(10, -7.4),
                                              FlSpot(11, -6.4),
                                              FlSpot(12, -12.4),
                                              FlSpot(13, -14.4),
                                              FlSpot(14, -15.4),
                                              FlSpot(15, -17.4),
                                              FlSpot(16, -18.4),
                                              FlSpot(17, -19.4),
                                              FlSpot(18, -21.4),
                                              FlSpot(19, -21.4),
                                              FlSpot(20, -22.0),
                                              FlSpot(21, -22.0),
                                              FlSpot(22, -22.0),
                                              FlSpot(23, -15.4),
                                              // após 4 min
                                            ],
                                            isCurved: true,

                                            color: terraCota, // 🔵 cor da linha
                                            dotData: FlDotData(show: false),
                                            // desativa as bolinhas
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //navbar inferior
        backgroundColor: verdePrincipal,
        selectedItemColor: Colors.white, // ícone/label selecionados
        unselectedItemColor: Colors.white, // ícone/label não selecionados
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false, // 🚫 esconde label selecionado
        showUnselectedLabels: false,
        selectedFontSize: 0, // remove o espaço reservado ao label
        unselectedFontSize: 0, // remove o espaço reservado ao label
        currentIndex: 0, // fixo
        iconSize: 34,
        onTap: (i) {
          // Acoes dos botões.
          switch (i) {
            case 0:
              print('Live Pressionado');
              break;
            case 1:
              print('Relatórios Precionado');
              break;
            case 2:
              print('Graficos  Precionado');
              break;
            case 3:
              print('Usuario Precionado');
              break;
          }
        }, // sem ação
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 13, left: 70),
              child: ImageIcon(AssetImage('assets/icons/billhard-live-4.png')),
            ),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 13, left: 30),
              child: ImageIcon(
                AssetImage('assets/icons/billhard-relatorios-2.png'),
              ),
            ),
            label: 'Relatórios',
          ), //  icon: ImageIcon(AssetImage('assets/icons/sensor_outline.png')), para alterar o icone
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 13, right: 30),
              child: ImageIcon(
                AssetImage('assets/icons/billhard-graficos-2.png'),
              ),
            ),
            label: 'Graficos',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 13, right: 70),
              child: ImageIcon(
                AssetImage('assets/icons/billhard-usuario-2.png'),
              ),
            ),
            label: 'Usuario',
          ),
        ],
      ),
    );
  }
}
