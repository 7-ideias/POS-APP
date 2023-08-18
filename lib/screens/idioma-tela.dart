import 'package:flutter/material.dart';

class IdiomaTela extends StatefulWidget {
  const IdiomaTela({Key? key}) : super(key: key);

  @override
  State<IdiomaTela> createState() => _IdiomaTelaState();
}

class _IdiomaTelaState extends State<IdiomaTela> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  darUmGetNoIdiomaSelecionadoEProsseguir('portugues-br');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text('portugues brasil'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  darUmGetNoIdiomaSelecionadoEProsseguir('ingles');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.center,
                    child: Text('ingles'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  darUmGetNoIdiomaSelecionadoEProsseguir('idioma-espanhol');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: Text('espanhol'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void darUmGetNoIdiomaSelecionadoEProsseguir(String idiomaEscolhido) {

    //TODO GET NO IDIOMA

    //TODO SALVAR LOCALMENTE

    Navigator.of(context).pushNamed('/moeda');
  }
}
