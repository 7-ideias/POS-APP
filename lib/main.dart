import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/screens/003_register/clientes/CadastroClienteTela.dart';
import 'package:pos_app/screens/esqueceu-senha-digitar-sms.dart';
import 'package:pos_app/screens/esqueceu-senha-tela.dart';
import 'package:pos_app/screens/idioma-tela.dart';
import 'package:pos_app/screens/moeda-tela.dart';
import 'package:pos_app/screens/produto-list-tela.dart';
import 'package:pos_app/service/NotificationService.dart';
import 'package:pos_app/service/info-user-service.dart';
import 'package:pos_app/service/verifica-atualizacoes-para-cada-usuario.dart';
import 'package:pos_app/app/page/pdf_create_page.dart';
import 'package:pos_app/desenvolvedor/desenvolvedor.dart';
import 'package:pos_app/screens/jornada-tela.dart';
import 'package:pos_app/desenvolvedor/tela_de_id.dart';
import 'package:pos_app/screens/login-tela.dart';
import 'package:pos_app/screens/home-tela.dart';
import 'package:pos_app/screens/003_register/products/CadastroProduto.dart';
import 'package:pos_app/screens/AgendaTela.dart';
import 'package:pos_app/screens/AjudaESuporteTela.dart';
import 'package:pos_app/screens/ClientesTela.dart';
import 'package:pos_app/screens/ConfiguracoesTela.dart';
import 'package:pos_app/screens/PedidosTela.dart';
import 'package:pos_app/screens/PerfilTela.dart';
import 'package:pos_app/screens/ResumoTela.dart';
import 'package:pos_app/screens/ServicosTela.dart';
import 'package:pos_app/screens/VendaTela.dart';
import 'package:pos_app/screens/caixa_tela.dart';
import 'package:pos_app/screens/castro-tela.dart';
import 'package:pos_app/screens/devolucao_tela.dart';
import 'package:pos_app/screens/financeiro_operacao.dart';
import 'package:pos_app/screens/operacao-nova-tela.dart';
import 'package:pos_app/screens/relatorios_tela.dart';
import 'package:pos_app/screens/operacao-tela.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../../service/info-user-service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  await infoUserService();

  //**************************************************************
  var cron = new Cron();
  cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
    atualizacoesParaUsuarioService();
  });
  //
  // cron.schedule(Schedule.parse('8-11 * * * *'), () async {
  //   print('between every 8 and 11 minutes');
  // });
  //**************************************************************
  //**************************************************************
  // runApp(const App()); //TODO PARA TESTAR O RELATORIO
  //**************************************************************
  runApp(TelaDeCarregamentoPrincipal());

  // final rotina = Rotina();
  // rotina.iniciarRotina();
  //**************************************************************

  //**************************************************************
  // Aguarda 5 minutos e depois para a rotina
  // Timer(Duration(minutes: 5), () {
  //   rotina.pararRotina();
  // });
  //**************************************************************
}

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
        '/ajuda': (_) => AjudaESuporteTela(),
        '/agenda': (_) => AgendaTela(),
        '/cadastro_produto': (_) => CadastroProduto(),
        '/cadastros': (_) => CadastrosTela(),
        '/cadcliente': (_) => CadastroClienteTela(),
        '/caixa': (_) => CaixaTela(),
        '/clientes': (_) => ClientesTela(),
        '/configs': (_) => ConfiguracoesTela(),
        '/desenvolvedor': (_) => DesenvolvedorPage(),
        '/devolucao': (_) => DevolucaoTela(),
        '/esqueceuSenha': (_) => EsqueceuTelaSenha(),
        '/esqueceuSenhaInformarSMS': (_) => EsqueceuSenhaDigitarSmsTela(),
        '/financeiro': (_) => FinanceiroTela(),
        '/home': (_) => Home(),
        '/idioma': (_) => IdiomaTela(),
        '/imagensIniciais': (_) => JornadaTela(),
        '/login': (_) => LoginPage(),
        '/moeda': (_) => MoedaTela(),
        '/operacaoNova': (_) => OperacaoNova(),
        '/operacoes': (_) => OperacaoTela(),
        '/pdf': (_) => PDFCreatePage(),
        '/pedidos': (_) => PedidosTela(),
        '/perfil': (_) => PerfilTela(),
        '/produtos': (_) => ProdutosTela(),
        '/relatorios': (_) => RelatoriosTela(),
        '/resumo': (_) => ResumoTela(),
        '/servicos': (_) => ServicosTela(),
        '/tela_de_identificacao_ou_cadastro': (_) => TelaInicio(),
        '/venda': (_) => VendaTela(),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: VariaveisGlobais.usuarioDto.liberadoParaAcessar == false
              ? const IdiomaTela()
              : const Home() ,

            //
            // VariaveisGlobais.usuarioDto.liberadoParaAcessar == false
            // ? LoginPage()
            // : Home(),
      ),
    );
  }
}

