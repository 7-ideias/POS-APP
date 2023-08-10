import 'package:flutter/material.dart';

class DesenvolvedorPage extends StatefulWidget {
  const DesenvolvedorPage({Key? key}) : super(key: key);

  @override
  State<DesenvolvedorPage> createState() => _DesenvolvedorPageState();
}

class _DesenvolvedorPageState extends State<DesenvolvedorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testes de desenvolvimento'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).pushNamed('/pdf');
                }, child: Text('tela de pdf')),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).pushNamed('/pdf');
                }, child: Text('teste pdf')),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(onPressed: () {
                    Navigator.of(context).pushNamed('/tela_de_identificacao_ou_cadastro');
                }, child: Text('logando')),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
