import 'package:flutter/material.dart';

class MoedaTela extends StatefulWidget {
  const MoedaTela({Key? key}) : super(key: key);

  @override
  State<MoedaTela> createState() => _MoedaTelaState();
}

class _MoedaTelaState extends State<MoedaTela> {


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
                  escolherMoedaEProdsseuir('R\$');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    alignment: Alignment.center,
                    child: Text('R\$'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  escolherMoedaEProdsseuir('U\$\$');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.purple,
                    alignment: Alignment.center,
                    child: Text('U\$\$'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void escolherMoedaEProdsseuir(String moeda) {

    //TODO SALVAR MOEDA LOCAL E ATUALIZAR O BACKEND

    Navigator.of(context).pushNamed('/imagensIniciais');
  }
}
