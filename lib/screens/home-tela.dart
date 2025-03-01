import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/screens/tela_index_0_cadastros.dart';
import 'package:pos_app/screens/tela_index_1_principal.dart';

import '../app/page/pdf_create_page.dart';
import '../desenvolvedor/desenvolvedor.dart';
import 'cadastrando-novo-colaborador.dart';
import 'idioma-tela.dart';
import 'login-tela.dart';
import 'operacao-nova-tela.dart';
import 'operacao-list-tela.dart';
import 'tela_index_2_operacoes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

@override
_HomeState createState() => _HomeState();}

class _HomeState extends State<Home> {
  int _page = 1;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _page = 1; // Definindo o valor inicial como 1
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppController.instance.buildThemeData(),
            home: Scaffold(
              bottomNavigationBar: buildCurvedNavigationBar(),
              body: body(),
            ),
            routes: {
              // '/inserindoProduto': (context) => InserindoProduto(),
              // '/ajuda': (_) => AjudaESuporteTela(),
              // '/agenda': (_) => AgendaTela(),
              // // '/cadastro_produto': (_) => CadastroProduto(),
              // // '/cadastros': (_) => CadastrosTela(),
              // // '/cadcliente': (_) => CadastroClienteTela(),
              // '/caixa': (_) => CaixaTela(),
              // '/clientes': (_) => ClientesTela(),
              '/colaborador': (_) => NovoColaborador(),
              // '/configs': (_) => ConfiguracoesTela(),
              '/desenvolvedor': (_) => DesenvolvedorPage(),
              // '/devolucao': (_) => DevolucaoTela(),
              // '/esqueceuSenha': (_) => EsqueceuTelaSenha(),
              // '/esqueceuSenhaInformarSMS': (_) => EsqueceuSenhaDigitarSmsTela(),
              // // '/financeiro': (_) => CadastrosTela(),
              '/home': (_) => Home(),
              '/idioma': (_) => IdiomaTela(),
              // '/imagensIniciais': (_) => JornadaTela(),
              '/login': (_) => LoginPage(),
              // '/moeda': (_) => MoedaTela(),
              '/operacaoNova': (_) => OperacaoNova(),
              '/operacoes': (_) => OperacaoTela(),
              // '/pdf': (_) => PDFCreatePage(),
              // '/pedidos': (_) => PedidosTela(),
              // '/perfil': (_) => PerfilTela(),
              // '/produtos': (_) => ProdutosTela(),
              // '/relatorios': (_) => RelatoriosTela(),
              // '/resumo': (_) => ResumoTela(),
              // '/servicos': (_) => ServicosTela(),
              // '/tela_de_identificacao_ou_cadastro': (_) => TelaInicio(),
              // '/venda': (_) => VendaTela(),
              '/index2Tela': (_) => Index2Tela(),
            },
          );
        }
    );
  }

  Widget body() {
    return _page == 0
        ? Index0Tela()
        : _page == 1
        ? Index1Tela()
        : Index2Tela();
  }

  CurvedNavigationBar buildCurvedNavigationBar() {
    var tamanhoDoIcone = 35.0;
    return CurvedNavigationBar(
      // color: Colors.white10,
      index: 1,
      backgroundColor: AppController.instance.buildThemeData().primaryColorDark,
      key: _bottomNavigationKey,
      items: <Widget>[
        SizedBox(
          height: tamanhoDoIcone,
          width: tamanhoDoIcone,
          child: Lottie.asset('assets/cadastros.json', fit: BoxFit.contain),
        ),
        SizedBox(
          height: tamanhoDoIcone,
          width: tamanhoDoIcone,
          child: Lottie.asset('assets/home_icon.json', fit: BoxFit.contain),
        ),
        SizedBox(
          height: tamanhoDoIcone,
          width: tamanhoDoIcone,
          child: Lottie.asset('assets/sell-in.json', fit: BoxFit.contain),
        ),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }

}
