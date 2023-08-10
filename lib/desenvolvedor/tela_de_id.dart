import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        children: [
          GestureDetector(
            child: SizedBox(
              child: Lottie.asset('assets/cloud-astronaut.json'),
            ),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          GestureDetector(
            child: SizedBox(
              child: Lottie.asset('assets/startup-growth.json'),
            ),
          ),
        ],
      ),
    );
  }
}
