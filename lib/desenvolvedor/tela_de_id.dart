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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Column(
                children: [
                  buildSizedBox(context, Colors.indigo, 'Novo por aqui'),
                  SizedBox(
                    height: 50,
                  ),
                  buildSizedBox(context, Colors.red, 'Já tenho uma conta'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSizedBox(
      BuildContext context, MaterialColor color, String texto) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              texto,
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
