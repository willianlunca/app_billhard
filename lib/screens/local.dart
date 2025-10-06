import 'package:app_billhard/screens/login.dart';
import 'package:app_billhard/screens/menu.dart';
import 'package:app_billhard/screens/termokip.dart';
import 'package:app_billhard/services/auth.dart';
import 'package:app_billhard/services/splashVideo.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart'; // caminho relativo para acessar a pasta colors
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Local extends StatefulWidget {
  const Local({super.key});

  @override
  State<Local> createState() => _LocalState();
}

class _LocalState extends State<Local> {
  bool _menuEstado = false;
  @override
  Widget build(BuildContext context) {
    const nomeFantasia = "Supermercados Camilo";
    const razSocial = "GCA Comercio de Alimentos LTDA";
    const apelido = "Loja 02 ( Maringa, Av Brasil)";
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
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width:
                    MediaQuery.of(context).size.width *
                    0.93, // 93% da largura da tela
                height: 60,

                decoration: BoxDecoration(
                  color: verdePrincipal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Row(
                      children: [
                        Text(
                          "Selecione:",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: bege,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 90,
                            child: Material(
                              color: Colors
                                  .transparent, // fundo transparente para mostrar o container
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // respeita o arredondamento

                                onTap: () {
                                  print("Container clicado!");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                        name: '/live',
                                      ),
                                      builder: (_) => const Live(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          nomeFantasia,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Razão Social:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              razSocial,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Apelido:",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              apelido,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* Inicio do card com informacoes de  temperatura */
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
