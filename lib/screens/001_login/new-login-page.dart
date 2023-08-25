import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/001_EsqueceuSenha/recuperando-senha.dart';
import 'package:pos_app/screens/001_login/valida-user-page.dart';
import 'package:http/http.dart' as http;
import 'package:validatorless/validatorless.dart';
import 'package:country_picker/country_picker.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  State<NewLoginPage> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  bool _obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String countryCode = '';

  @override
  Widget build(BuildContext context) {
    void _validateFields() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ValidaPage(
            /*
            gambiarra pra aparecer +55 pro usuario, mas nao enviar pro baack
             */
            celular: celularController.text.replaceAll('+', ''), senha: senhaController.text),
        ),
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 150,
          left: 28.5,
          right: 28.5,
        ),
        color: const Color(0xFF003366),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 371,
              height: 141,
              child: Lottie.asset(
                'assets/woman-paying.json',
              ),
            ),
            const SizedBox(
              height: 135,
            ),
            TextFormField(
              controller: celularController,
              validator: Validatorless.multiple([
                Validatorless.number("Insira somente numeros"),
                Validatorless.regex(RegExp(r'^\d{11}$'), "Número de celular inválido")
              ]),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Celular",
                labelStyle: TextStyle(
                  color: Color(0xFF66A3D2),
                  fontSize: 25,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
              key: formKey,
              onTap: (){
                showCountryPicker(
                  favorite: ['BR'],
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    setState(() {
                      /*
                         gambiarra pra aparecer +55 pro usuario, mas nao enviar pro baack
                      */
                      countryCode = '+${country.phoneCode}';
                      celularController.text = countryCode;
                    });
                  },
                );
              },
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecuperandoSenha()),
                    ),
                    child: const Text(
                      "Recuperar senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0x6cc3c3c3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: Validatorless.max(6, 'A senha deve conter no maximo 6 digitos.'),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Senha",
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
            const SizedBox(
              height: 80,
            ),
            Container(
              width: 276,
              height: 46,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      stops: [0.3, 1],
                      colors: [Color(0xff386DBD), Color(0xFF66A3D2)]),
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: _validateFields,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Entrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        child: Lottie.asset('assets/login.json'),
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: 371,
              height: 0.5,
              color: const Color(0xffC3C3C3),
            ),
            Container(
              height: 35,
              width: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  style: TextStyle(color: Color(0xffC3C3C3)),
                  "Nāo tenho conta, criar agora",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}