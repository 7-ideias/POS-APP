import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/login-resulltado-da-validacao.dart';

import '../controller/app_controller.dart';
import '../service/voltar_a_tela_de_encolha.dart';
import '../utilitarios/VariaveisGlobais.dart';
import '../utilitarios/widgetsGlobais.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {

  LoginPage({Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _celularController = TextEditingController();
  // TextEditingController _celularDoTitularController = TextEditingController();
  TextEditingController _identificacaoIdTitular = TextEditingController(text: '+5535992736863');
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

  String usuarioColaboradorNovo = '';

  String paisTitular = '';
  String paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador = '+55';

  bool ehColaborador = false;
  String celularDoTitular = '';


  void validarSenhaDigitada() {

    FocusManager.instance.primaryFocus?.unfocus();

    if(posicao1DaSenha.text.isEmpty ||
        posicao2DaSenha.text.isEmpty ||
        posicao3DaSenha.text.isEmpty ||
        posicao4DaSenha.text.isEmpty ||
        posicao5DaSenha.text.isEmpty ||
        posicao6DaSenha.text.isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text("verifique a senha digitada\n"
            "é obrigatório ter 6 dígitos"),
      ));

    }else {
      setState(() {
        if (ModalRoute
            .of(context)
            ?.settings
            .arguments
            .toString()
            .toUpperCase() == 'COLABORADOR') {
          ehColaborador = true;
          celularDoTitular = _identificacaoIdTitular.text;
          usuarioColaboradorNovo = 'COLABORADOR';
        }

        if (ModalRoute
            .of(context)
            ?.settings
            .arguments
            .toString()
            .toUpperCase() == 'USUARIO') {
          // ehColaborador = true;
          // celularDoTitular = _identificacaoIdTitular.text;
          usuarioColaboradorNovo = 'USUARIO';
        }

        if (ModalRoute
            .of(context)
            ?.settings
            .arguments
            .toString()
            .toUpperCase() == 'NOVO') {
          // ehColaborador = true;
          // celularDoTitular = _identificacaoIdTitular.text;
          usuarioColaboradorNovo = 'NOVO';
        }
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ValidaPage(
                celular: '$paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador${_celularController
                    .text}',
                senha: posicao1DaSenha.text + posicao2DaSenha.text +
                    posicao3DaSenha.text + posicao4DaSenha.text +
                    posicao5DaSenha.text + posicao6DaSenha.text,
                celularTitular: '$paisTitular$celularDoTitular',
                usuarioColaboradorNovo: usuarioColaboradorNovo,
              ),
        ),
      );

      //   if (isUserValid && isPasswordValid) {
      //     // Campos válidos, fazer a lógica de autenticação aqui
      //     print('Campos válidos');
      //     // Chamar a página de cadastro do cliente
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Index1Tela()),
      //     );
      //   } else {
      //     print('Campos inválidos');
      //   }
      // }

      // void _pular() {
      //   setState(() {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => Home()),
      //     );
      //   });

    }
  }

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
    final countryPicker = const FlCountryCodePicker();
    CountryCode? countryCode;
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
            // if(arguments.toString() == 'novo')
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    arguments.toString().toUpperCase(),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            SizedBox(
              height: 20
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [

                    /**
                     * ! logando o colaborador
                     */
                    if(arguments.toString() == 'colaborador')
                        SizedBox(
                            width: double.infinity * 0.8,
                            child: TextField(
                              controller: _identificacaoIdTitular,
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'identificacao',
                              ),
                            ),
                          ),

                    SizedBox(
                        height: 20
                    ),
                      // SizedBox(
                      //   width: double.infinity * 0.8,
                      //   child: TextFormField(
                      //     // focusNode: focoInicialNoCelular,
                      //     controller: _celularDoTitularController,
                      //     style: TextStyle(fontSize: 30),
                      //     keyboardType: TextInputType.number,
                      //     textDirection: TextDirection.ltr,
                      //     decoration: InputDecoration(
                      //       prefixIcon: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: GestureDetector(
                      //           onTap: (){
                      //             opcaoPaises('titular');
                      //           },
                      //           child: Container(
                      //             width: 130,
                      //             child: Row(
                      //               children: [
                      //                 Icon(Icons.phone,size: 35),
                      //                 SizedBox(width: 20),
                      //                 Text(paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador,style: TextStyle(fontSize: 30)),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       border: OutlineInputBorder(),
                      //       labelText: 'celular',
                      //       errorText: isUserValid ? null : 'Campo obrigatório',
                      //     ),
                      //   ),
                      // ),
                    // SizedBox(
                    //   height: 20
                    // ),

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
                                onTap: () async {
                                  final code = await countryPicker.showPicker(context: context);
                                  setState(() {
                                    countryCode = code;
                                    paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador = countryCode!.dialCode;
                                  });
                                  // opcaoPaises('');
                                },
                                child: Container(
                                  width: 130,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                          padding: EdgeInsets.only(right: 15,left: 15,top: 15,bottom: 15
                                          ),
                                          child: Text(paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
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
                              _validarSeOCelularFoiDigitado();
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
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 50,
                    //     width: double.infinity * 0.8,
                    //     child: ElevatedButton(
                    //       focusNode: focoNoLogin,
                    //       onPressed: _validateFields,
                    //       child: arguments.toString() == 'novo'
                    //           ? Text('cadastrar novo usuário',
                    //               style: TextStyle(fontSize: 18))
                    //           : Text('login', style: TextStyle(fontSize: 18)),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        validarSenhaDigitada();
                      },
                      child: UtilsWidgets.botaoMaster(
                          context,
                          AppController.instance.botaoConfirmar,
                          arguments.toString() == 'novo'
                              ? 'cadastrar novo usuário'
                              : 'login'),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 50,
                    //     color: Colors.red,
                    //     width: double.infinity * 0.8,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         voltarEscolha(context);
                    //       },
                    //       child: Text('voltar', style: TextStyle(fontSize: 18)),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        voltarEscolha(context);
                      },
                      child: UtilsWidgets.botaoMaster(
                          context,
                          AppController.instance.botaoNegar,'voltar'),
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
              // focoNoLogin.requestFocus();
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

  void _validarSeOCelularFoiDigitado() {

    if(_celularController.text.isEmpty || _celularController.text.length > 12){
      print("vazio");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text("informe um número de celular válido"),
      ));
    }  else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirme o n° do celular'),
            content: Text('$paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador${_celularController.text}'
                ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              TextButton(
                child: Text('Confirmar'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                  send('$paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador${_celularController.text}');
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> send (String celular) async {

    setState(() {
      // isLoading = true;
    });

    var url = '${VariaveisGlobais.endPoint}/usuario/recuperar-senha/' + celular;
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
        content: Text("verifique o codigo sms em seu aparelho"),
      ));
    }
  }




// void opcaoPaises(String titular) {
  //   showCountryPicker(
  //     context: context,
  //     //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
  //     exclude: <String>['KN', 'MF'],
  //     favorite: <String>['BR'],
  //     showPhoneCode: true,
  //     onSelect: (Country country) {
  //       print(country.phoneCode);
  //       setState(() {
  //         if(titular == 'titular'){
  //           paisTitular = '+${country.phoneCode}';
  //         }else{
  //           paisDoCaraQueQuerLogarPodeSerOTitularOuColaborador = '+${country.phoneCode}';
  //         }
  //       });
  //     },
  //     // Optional. Sets the theme for the country list picker.
  //     countryListTheme: CountryListThemeData(
  //       // Optional. Sets the border radius for the bottomsheet.
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(40.0),
  //         topRight: Radius.circular(40.0),
  //       ),
  //       // Optional. Styles the search field.
  //       inputDecoration: InputDecoration(
  //         labelText: 'procurar',
  //         hintText: 'digite algo',
  //         prefixIcon: const Icon(Icons.search),
  //         border: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: const Color(0xFF8C98A8).withOpacity(0.2),
  //           ),
  //         ),
  //       ),
  //       // Optional. Styles the text in the search field
  //       searchTextStyle: TextStyle(
  //         color: Colors.blue,
  //         fontSize: 25,
  //       ),
  //     ),
  //   );
  // }

}
