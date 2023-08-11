import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/001_login/valida-user-page.dart';
import 'package:pos_app/screens/002_main/TelaPrincipal2.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController celularController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool isUserValid = false;
  bool isPasswordValid = false;
  late var celular;
  late var senha;

  void _validateFields() {
    // setState(() {
    //   isUserValid = userController.text.isNotEmpty;
    //   isPasswordValid = passwordController.text.isNotEmpty;
    //   validarSenhaDigitada();
    // });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ValidaPage(celular: celularController.text,senha: senhaController.text),),
    );
  }

  void validarSenhaDigitada() {
    if (isUserValid && isPasswordValid) {
      // Campos válidos, fazer a lógica de autenticação aqui
      print('Campos válidos');
      // Chamar a página de cadastro do cliente
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaPrincipal2()),
      );
    } else {
      // Campos inválidos, exibir mensagem de erro ou tomar a ação necessária
      print('Campos inválidos');
    }
  }

  void _pular() {
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaPrincipal2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50,),
          Stack(
            children: [
              Center(
                child: Lottie.asset(
                  'assets/login-security.json',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity * 0.8,
                    child: TextField(
                      controller: celularController,
                      style: TextStyle(fontSize: 22),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'celular',
                        errorText: isUserValid ? null : 'Campo obrigatório',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity * 0.8,
                    child: TextField(
                      controller: senhaController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 22),
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye),
                        border: OutlineInputBorder(),
                        labelText: 'senha',
                        errorText: isPasswordValid ? null : 'Campo obrigatório',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50,
                    width: double.infinity * 0.8,
                    child: ElevatedButton(
                      onPressed: _validateFields,
                      child: Text('login',style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50,
                    width: double.infinity * 0.8,
                    child: ElevatedButton(
                      onPressed: _pular,
                      child: Text('pular o login - APENAS PARA TESTE',style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
