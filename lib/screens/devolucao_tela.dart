import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controller/app_controller.dart';

class DevolucaoTela extends StatefulWidget {
  const DevolucaoTela({Key? key}) : super(key: key);

  @override
  State<DevolucaoTela> createState() => _DevolucaoTelaState();
}

class _DevolucaoTelaState extends State<DevolucaoTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'devolução',
        textAlign: TextAlign.center,
      ))),
      body: Container(
          child: ListView(
            children: [
              Card(
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 200,
                  width: 200,
                  child: Lottie.asset(
                    'assets/clientes.json',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 100,
                  width: 100,
                  child: Center(child: Text('digite o numero', style: TextStyle(fontSize: 50),)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 100,
                  width: 100,
                  child: Center(child: Text('123...', style: TextStyle(fontSize: 50),)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RetornoDaDevolucao()),
                    );
                  },
                  child: Container(
                    color: AppController.instance.corTelaAcima,
                    height: 100,
                    width: 100,
                    child: Center(child: Text('botao', style: TextStyle(fontSize: 50),)),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class RetornoDaDevolucao extends StatefulWidget {
  const RetornoDaDevolucao({Key? key}) : super(key: key);

  @override
  State<RetornoDaDevolucao> createState() => _RetornoDaDevolucaoState();
}

class _RetornoDaDevolucaoState extends State<RetornoDaDevolucao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

