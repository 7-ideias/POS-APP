import 'package:flutter/material.dart';

import '../../service/NotificationService.dart';
import '../../utilitarios/Donut.dart';
import '../../utilitarios/MenuLateral.dart';
import '../../utilitarios/VariaveisGlobais.dart';

class TelaPrincipal2 extends StatefulWidget {
  @override
  _TelaPrincipal2State createState() => _TelaPrincipal2State();
}

class _TelaPrincipal2State extends State<TelaPrincipal2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(VariaveisGlobais.NOME_SISTEMA),
      ),
      drawer: MenuLateral(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 16),
          if (_isExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Card(
                    elevation: 3,
                    child: Text('nova venda',
                        style: TextStyle(fontSize: 30, color: Colors.indigo)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                buildFloatingActionButton(
                  icon: Icons.add,
                  onPressed: () {
                    Navigator.pushNamed(context, '/venda');
                  },
                ),
              ],
            ),
          SizedBox(height: 16),
          if (_isExpanded) SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isExpanded
                  ? Container(
                      child: Card(
                        elevation: 3,
                        child: Text('cancelar',
                            style:
                                TextStyle(fontSize: 30, color: Colors.indigo)),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 20,
              ),
              buildFloatingActionButton(
                icon: _isExpanded ? Icons.close : Icons.add,
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    _isExpanded
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildFloatingActionButton(
                icon: Icons.refresh,
                onPressed: () {
                  //todo
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              color: Colors.indigo,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text('Boa tarde',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text('Nome do Usuário',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Card(
                    color: Colors.indigoAccent,
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: Container(
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
            // color: _isExpanded ? Colors.black.withOpacity(1) : null,
            child: Column(
          children: [
            _isExpanded ? Container() : Donut(context),
          ],
        )),
      ]),
    );
  }

  Widget buildFloatingActionButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: onPressed,
    );
  }
}
