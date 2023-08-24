import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:validatorless/validatorless.dart';

class NovaSenhaPage extends StatefulWidget {
  @override
  State<NovaSenhaPage> createState() => _NovaSenhaPageState();
}

class _NovaSenhaPageState extends State<NovaSenhaPage> {
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF003366),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'Agora sim!',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Caprasimo',
                    color: Color(0xffC3C3C3),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  'Crie uma nova senha',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffCEC10D),
                      fontFamily: 'Caprasimo'),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Lottie.asset('assets/Password Recovery-2.json'),
              ),
              TextFormField(
                controller: novaSenhaController,
                validator: Validatorless.max(
                    6, 'A senha deve conter no maximo 6 digitos.'),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nova senha",
                  labelStyle: const TextStyle(
                    color: Color(0xFF66A3D2),
                    fontSize: 25,
                  ),
                  suffixIcon: IconButton(
                    alignment: Alignment.centerRight,
                    icon: _obscureText
                        ? Lottie.asset('assets/olho-aberto-senha.json')
                        : Lottie.asset('assets/olho-fechado-senha.json'),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: confirmaSenhaController,
                validator: Validatorless.multiple([
                  Validatorless.max(
                      6, 'A senha deve conter no maximo 6 dígitos.'),
                  Validatorless.compare(novaSenhaController, 'As senhas devem ser iguais.')
                ]),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Confirmar senha",
                  labelStyle: const TextStyle(
                    color: Color(0xFF66A3D2),
                    fontSize: 25,
                  ),
                  suffixIcon: IconButton(
                    alignment: Alignment.centerRight,
                    icon: _obscureText
                        ? Lottie.asset('assets/olho-aberto-senha.json')
                        : Lottie.asset('assets/olho-fechado-senha.json'),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                obscureText: _obscureText,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  formKey.currentState?.validate();

                  // Implementar a lógica para enviar o código
                },
                child: const Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffC3C3C3),
                  ),
                  'Redefinir senha',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
