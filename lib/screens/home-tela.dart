import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/screens/tela_index_1_principal.dart';
import 'package:pos_app/screens/tela_index_0_cadastros.dart';

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
            theme: ThemeData(
              primarySwatch: AppController.instance.corTelaFundo,
              brightness: Brightness.light,
            ),
            home: Scaffold(
              bottomNavigationBar: buildCurvedNavigationBar(),
              body: body(),
            ),
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
    return CurvedNavigationBar(
      // color: Colors.white10,
      index: 1,
      backgroundColor: _page == 0
          ? AppController.instance.corTelaFundo
          : _page == 1
          ? AppController.instance.corTelaFundo
          : AppController.instance.corTelaFundo,
      key: _bottomNavigationKey,
      items: <Widget>[
        SizedBox(
          height: 60,
          width: 60,
          child: Lottie.asset('assets/financeiro.json', fit: BoxFit.contain),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Lottie.asset('assets/home_icon.json', fit: BoxFit.contain),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Lottie.asset('assets/seller.json', fit: BoxFit.contain),
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
