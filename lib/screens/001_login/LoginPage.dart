import 'package:flutter/material.dart';
import 'package:pos_app/screens/002_main/TelaPrincipal2.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isUserValid = false;
  bool isPasswordValid = false;

  void _validateFields() {
    setState(() {
      isUserValid = userController.text.isNotEmpty;
      isPasswordValid = passwordController.text.isNotEmpty;
      validarSenhaDigitada();
    });
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
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlueAccent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'email',
                        errorText: isUserValid ? null : 'Campo obrigatório',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity * 0.8,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'senha',
                        errorText: isPasswordValid ? null : 'Campo obrigatório',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40,
                    width: double.infinity * 0.8,
                    child: ElevatedButton(
                      onPressed: _validateFields,
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40,
                    width: double.infinity * 0.8,
                    child: ElevatedButton(
                      onPressed: _validateFields,
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40,
                    width: double.infinity * 0.8,
                    child: ElevatedButton(
                      onPressed: _pular,
                      child: Text('pular o login - APENAS PARA TESTE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
