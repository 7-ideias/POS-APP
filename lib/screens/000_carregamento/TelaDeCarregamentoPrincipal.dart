import 'package:flutter/material.dart';
import 'package:pos_app/app/page/pdf_create_page.dart';
import 'package:pos_app/desenvolvedor/desenvolvedor.dart';
import 'package:pos_app/desenvolvedor/tela-carrousel.dart';
import 'package:pos_app/desenvolvedor/tela_de_id.dart';
import 'package:pos_app/screens/001_login/LoginPage.dart';
import 'package:pos_app/screens/001_login/new-login-page.dart';
import 'package:pos_app/screens/002_main/home_tela.dart';
import 'package:pos_app/screens/003_register/products/CadastroProduto.dart';
import 'package:pos_app/screens/AgendaTela.dart';
import 'package:pos_app/screens/AjudaESuporteTela.dart';
import 'package:pos_app/screens/ClientesTela.dart';
import 'package:pos_app/screens/ConfiguracoesTela.dart';
import 'package:pos_app/screens/PedidosTela.dart';
import 'package:pos_app/screens/PerfilTela.dart';
import 'package:pos_app/screens/ResumoTela.dart';
import 'package:pos_app/screens/SejaProTela.dart';
import 'package:pos_app/screens/ServicosTela.dart';
import 'package:pos_app/screens/VendaTela.dart';
import 'package:pos_app/screens/caixa_tela.dart';
import 'package:pos_app/screens/castro-tela.dart';
import 'package:pos_app/screens/devolucao_tela.dart';
import 'package:pos_app/screens/financeiro_operacao.dart';
import 'package:pos_app/screens/prod_tela.dart';
import 'package:pos_app/screens/relatorios_tela.dart';
import 'package:pos_app/screens/trilhar/primeiro-uso.dart';
import 'package:pos_app/screens/venda_tela.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../../service/info-user-service.dart';
import '../003_register/clientes/CadastroClienteTela.dart';
import '../produtos_tela.dart';

class TelaDeCarregamentoPrincipal extends StatefulWidget {
  @override
  State<TelaDeCarregamentoPrincipal> createState() =>
      _TelaDeCarregamentoPrincipalState();
}

class _TelaDeCarregamentoPrincipalState
    extends State<TelaDeCarregamentoPrincipal> {
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
        '/home':(_) => PrimeiroUso(),
        // '/home': (_) => Home(),
        '/login': (_) => NewLoginPage(),
        '/agenda': (_) => AgendaTela(),
        '/ajuda': (_) => AjudaESuporteTela(),
        '/caixa': (_) => CaixaTela(),
        '/cadastros': (_) => CadastrosTela(),
        '/clientes': (_) => ClientesTela(),
        '/cadcliente': (_) => CadastroClienteTela(),
        '/cadastro_produto': (_) => CadastroProduto(),
        '/configs': (_) => ConfiguracoesTela(),
        '/devolucao': (_) => DevolucaoTela(),
        '/financeiro': (_) => FinanceiroTela(),
        '/pedidos': (_) => PedidosTela(),
        '/produtos': (_) => ProdutosTela(),
        '/produtos-geral': (_) => ProdTela(),
        '/relatorios': (_) => RelatoriosTela(),
        '/resumo': (_) => ResumoTela(),
        '/sejapro': (_) => SejaProTela(),
        '/servicos': (_) => ServicosTela(),
        '/perfil': (_) => PerfilTela(),
        // '/teste': (_) => Teste(),
        '/venda': (_) => VendaTela(),
        '/venda2': (_) => VendasTela2(),
        '/pdf': (_) => PDFCreatePage(),
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
    infoUserService();
    super.initState();
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
        child: VariaveisGlobais.usuarioDto.liberadoParaAcessar == false
            ? NewLoginPage()
            : Home(),
      ),
    );
  }
}
