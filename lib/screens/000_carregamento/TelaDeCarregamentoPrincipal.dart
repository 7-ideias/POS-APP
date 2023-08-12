import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pos_app/app/app.dart';
import 'package:pos_app/app/page/pdf_create_page.dart';
import 'package:pos_app/desenvolvedor/desenvolvedor.dart';
import 'package:pos_app/desenvolvedor/tela-carrousel.dart';
import 'package:pos_app/desenvolvedor/tela_de_id.dart';
import 'package:pos_app/screens/001_login/LoginPage.dart';
import 'package:pos_app/screens/002_main/home_tela.dart';
import 'package:pos_app/screens/002_main/principal_tela.dart';
import 'package:pos_app/screens/003_register/products/CadastroProduto.dart';
import 'package:pos_app/screens/AgendaTela.dart';
import 'package:pos_app/screens/AjudaESuporteTela.dart';
import 'package:pos_app/screens/ClientesTela.dart';
import 'package:pos_app/screens/ConfiguracoesTela.dart';
import 'package:pos_app/screens/PedidosTela.dart';
import 'package:pos_app/screens/PerfilTela.dart';
import 'package:pos_app/screens/RelatoriosTela.dart';
import 'package:pos_app/screens/ResumoTela.dart';
import 'package:pos_app/screens/SejaProTela.dart';
import 'package:pos_app/screens/ServicosTela.dart';
import 'package:pos_app/screens/VendaTela.dart';
import 'package:pos_app/screens/financeiro_operacao.dart';
import 'package:pos_app/screens/venda_tela.dart';
import '../001_login/valida-user-page.dart';
import '../003_register/clientes/CadastroClienteTela.dart';
import '../produtos_tela.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaDeCarregamentoPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // textTheme: GoogleFonts.lobsterTextTheme(Theme.of(context).textTheme),
        // fontFamily: 'Georgia',
      ),
      home: SplashPage(),
      routes: {
        '/home ': (_) => Home(),
        '/login': (_) => LoginPage(),
        '/agenda': (_) => AgendaTela(),
        '/ajuda': (_) => AjudaESuporteTela(),
        '/clientes': (_) => ClientesTela(),
        '/cadcliente': (_) => CadastroClienteTela(),
        '/cadastro_produto': (_) => CadastroProduto(),
        '/configs': (_) => ConfiguracoesTela(),
        '/financeiro': (_) => FinanceiroTela(),
        '/pedidos': (_) => PedidosTela(),
        '/produtos': (_) => ProdutosTela(),
        '/relatorios': (_) => RelatoriosTela(),
        '/resumo': (_) => ResumoTela(),
        '/sejapro': (_) => SejaProTela(),
        '/servicos': (_) => ServicosTela(),
        '/perfil': (_) => PerfilTela(),
        // '/teste': (_) => Teste(),
        '/venda': (_) => VendaTela(),
        '/venda2': (_) => VendasTela2(),
        '/pdf': (_) => App(),
        '/desenvolvedor': (_) => DesenvolvedorPage(),
        '/tela_de_identificacao_ou_cadastro': (_) => TelaInicio(),
        '/imagensIniciais': (_) => TelaComCarousel(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
