import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/home-tela.dart';
import 'package:pos_app/screens/tela_index_1_principal.dart';
import 'package:pos_app/screens/login-resulltado-da-validacao.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _celularController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

    TextEditingController posicao1DaSenha = TextEditingController();
    TextEditingController posicao2DaSenha = TextEditingController();
    TextEditingController posicao3DaSenha = TextEditingController();
    TextEditingController posicao4DaSenha = TextEditingController();
    TextEditingController posicao5DaSenha = TextEditingController();
    TextEditingController posicao6DaSenha = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  FocusNode focoNoLogin = FocusNode();

  FocusNode focoInicialNoCelular = FocusNode();

  bool isUserValid = false;
  bool isPasswordValid = false;
  late var celular;
  late var senha;

  String pais = '';

  void _validateFields() {
    debugPrint('posicao1DaSenha -> ' + posicao1DaSenha.text);
    debugPrint('posicao2DaSenha -> ' + posicao2DaSenha.text);
    debugPrint('posicao3DaSenha -> ' + posicao3DaSenha.text);
    debugPrint('posicao4DaSenha -> ' + posicao4DaSenha.text);
    debugPrint('posicao5DaSenha -> ' + posicao5DaSenha.text);
    debugPrint('posicao6DaSenha -> ' + posicao6DaSenha.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ValidaPage(
            celular: '$pais${_celularController.text}', senha: posicao1DaSenha.text+posicao2DaSenha.text
            +posicao3DaSenha.text+posicao4DaSenha.text+posicao5DaSenha.text+posicao6DaSenha.text),
      ),
    );
  }

  void validarSenhaDigitada() {
    if (isUserValid && isPasswordValid) {
      // Campos válidos, fazer a lógica de autenticação aqui
      print('Campos válidos');
      // Chamar a página de cadastro do cliente
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Index1Tela()),
      );
    } else {
      print('Campos inválidos');
    }
  }

  // void _pular() {
  //   setState(() {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Home()),
  //     );
  //   });
  // }

  @override
  void initState() {
    focoInicialNoCelular.hasFocus;
    super.initState();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Stack(
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/login-security.json',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            arguments.toString() == 'novo'
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'novo usuário!!!',
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    arguments.toString() == 'colaborador'
                        ? SizedBox(
                            width: double.infinity * 0.8,
                            child: TextField(
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'celular do titular',
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20
                    ),
                    SizedBox(
                      width: double.infinity * 0.8,
                      child: TextFormField(
                        focusNode: focoInicialNoCelular,
                        controller: _celularController,
                        style: TextStyle(fontSize: 30),
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: (){
                                  opcaoPaises();
                                },
                                child: Container(
                                  width: 130,
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone,size: 35),
                                      SizedBox(width: 20),
                                      Text(pais,style: TextStyle(fontSize: 30)),
                                    ],
                                  ),
                                ),
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'celular',
                          errorText: isUserValid ? null : 'Campo obrigatório',
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // SizedBox(
                    //   width: double.infinity * 0.8,
                    //   child: TextField(
                    //     controller: senhaController,
                    //     keyboardType: TextInputType.number,
                    //     style: TextStyle(fontSize: 22),
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //       suffixIcon: Icon(Icons.remove_red_eye),
                    //       border: OutlineInputBorder(),
                    //       labelText: 'senha',
                    //       errorText: isPasswordValid ? null : 'Campo obrigatório',
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgetCampoDigitacao(1, posicao1DaSenha, focusNode1),
                        widgetCampoDigitacao(2, posicao2DaSenha, focusNode2),
                        widgetCampoDigitacao(3, posicao3DaSenha, focusNode3),
                        widgetCampoDigitacao(4, posicao4DaSenha, focusNode4),
                        widgetCampoDigitacao(5, posicao5DaSenha, focusNode5),
                        widgetCampoDigitacao(6, posicao6DaSenha, focusNode6),
                      ],
                    ),
                    arguments.toString() != 'novo'
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/esqueceuSenha');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'esqueci a senha',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity * 0.8,
                        child: ElevatedButton(
                          focusNode: focoNoLogin,
                          onPressed: _validateFields,
                          child: arguments.toString() == 'novo'
                              ? Text('cadastrar novo usuário',
                                  style: TextStyle(fontSize: 18))
                              : Text('login', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        color: Colors.red,
                        width: double.infinity * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('voltar', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  SizedBox widgetCampoDigitacao(int posicao, TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.13,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, top: 8.0),
        child: TextField(
          onTap: () {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          },
          onChanged: (value) {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
            if (posicao == 1) {
              focusNode2.requestFocus();
            } else if (posicao == 2) {
              focusNode3.requestFocus();
            } else if (posicao == 3) {
              focusNode4.requestFocus();
            } else if (posicao == 4) {
              focusNode5.requestFocus();
            } else if (posicao == 5) {
              focusNode6.requestFocus();
            } else if (posicao == 6) {
              focoNoLogin.requestFocus();
            }
          },
          focusNode: focusNode,
          controller: controller,
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 22),
          decoration: InputDecoration(
            border: OutlineInputBorder(

            ),
          ),
        ),
      ),
    );
  }

  void opcaoPaises() {
    showCountryPicker(
      context: context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      exclude: <String>['KN', 'MF'],
      favorite: <String>['BR'],
      showPhoneCode: true,
      onSelect: (Country country) {
        print(country.phoneCode);
        setState(() {
          pais = '+${country.phoneCode}';
        });
      },
      // Optional. Sets the theme for the country list picker.
      countryListTheme: CountryListThemeData(
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'procurar',
          hintText: 'digite algo',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        // Optional. Styles the text in the search field
        searchTextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 25,
        ),
      ),
    );
  }

}
