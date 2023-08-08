import 'package:flutter/material.dart';

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('jornada')),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            color: Colors.white24,
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Text('o login é feito \ncom celular', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 30,
                    ),
                    buildSizedBox(context, Colors.indigo, 'novo por aqui', 0),
                    SizedBox(
                      height: 50,
                    ),
                    buildSizedBox(context, Colors.red, 'já tenho uma conta', 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSizedBox(
      BuildContext context, MaterialColor color, String texto, int i) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.3,
      child: GestureDetector(
        child: Card(
          elevation: 50,
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: TextStyle(fontSize: 22,color: Colors.white),
                textAlign: TextAlign.center,

              )
            ],
          ),
        ),
        onTap: () {
          if (i == 0) {
            Navigator.of(context)
                .pushNamed('/loginUsuarioNovo');
          }
          if (i == 1) {
            Navigator.of(context)
                .pushNamed('/loginUsuarioAtivo');
          }
        },
      ),
    );
  }
}
