import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:pos_app/screens/preview-page.dart';
import 'package:http/http.dart' as http;


class NovoColaborador extends StatefulWidget {
  File file;


    NovoColaborador({super.key, required this.file});

  @override
  State<NovoColaborador> createState() => _NovoColaboradorState();
}

class _NovoColaboradorState extends State<NovoColaborador> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController rgController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController complementoController = TextEditingController();

  String? foto;
  String? nome;
  String? email;
  String? tel;
  String? rg;
  String? cpf;
  String? cep;
  String? endereco;
  String? bairro;
  String? uf;
  String? complemento;
  final picker = ImagePicker();

  DateTime date = DateTime.now();

  TextEditingController controllerData = TextEditingController();

  bool fazVenda = true;
  bool cadastraProduto = true;
  bool veEstoque = true;
  bool editaProduto = true;
  bool lancaServico = true;
  bool prestaServico = true;
  bool editaCliente = true;
  bool geraRelatorio = true;
  bool recebeNoCaixa = true;
  bool veQuantoVendeu = true;

  Future chamaAGaleria() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        widget.file = File(file.path);
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(color: AppController.instance.corLetras),
            'Novo colaborador'),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                color: AppController.instance.corPrincipal,
                child: Image.asset('assets/employee-data-folder.png'),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.22,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.09,
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.155 / 1.8,
                    backgroundColor: AppController.instance.corTelaAcima),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.155 / 2,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      widget.file != null && widget.file.path.isNotEmpty
                          ? AssetImage(widget.file.path)
                          : AssetImage('assets/male-profile-picture.png'),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.11,
                  child: widget.file != null && widget.file.path.isNotEmpty
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildJanelinhaQueSobe(context);
                                }),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return buildJanelinhaQueSobe(context);
                            },
                          ),
                          child: Lottie.asset(
                            'assets/instagram-camera.json',
                            height: MediaQuery.of(context).size.height *
                                0.155 /
                                1.5,
                          ),
                        )),
            ],
          ),
          Container(
            color: AppController.instance.corTelaAcima,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
          ), //'informações pessoais'
          Container(
            color: AppController.instance.corTelaAcima,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: Card(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  color: AppController.instance.corPrincipal,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: nomeController,
                          decoration: InputDecoration(
                              label: Text('Nome'),
                              labelStyle: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.5)),
                              suffixIcon: Icon(
                                Icons.person,
                                color: AppController.instance.corTelaAcima,
                              )),
                        ),
                      ), //nome
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              label: Text('Email'),
                              labelStyle: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.5)),
                              suffixIcon: Icon(
                                Icons.email,
                                color: AppController.instance.corTelaAcima,
                              )),
                        ),
                      ), //email
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: telController,
                          decoration: InputDecoration(
                              label: Text('Telefone de acesso'),
                              labelStyle: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.5)),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: AppController.instance.corTelaAcima,
                              )),
                        ),
                      ), //telefone
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: rgController,
                                decoration: InputDecoration(
                                    label: Text('RG'),
                                    labelStyle: TextStyle(
                                        color: AppController.instance.corLetras,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5)),
                                    suffixIcon: Icon(
                                      Icons.account_box_outlined,
                                      color:
                                          AppController.instance.corTelaAcima,
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: cpfController,
                                decoration: InputDecoration(
                                    label: Text('CPF'),
                                    labelStyle: TextStyle(
                                        color: AppController.instance.corLetras,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5)),
                                    suffixIcon: Icon(
                                      Icons.people_alt_outlined,
                                      color:
                                          AppController.instance.corTelaAcima,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ), //rg e cpf
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, style: BorderStyle.solid)),
                          child: CupertinoButton(
                            onPressed: () => _showDialog(
                              CupertinoDatePicker(
                                dateOrder: DatePickerDateOrder.dmy,
                                initialDateTime: date,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                showDayOfWeek: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(
                                    () => date = newDate,
                                  );
                                },
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    style: TextStyle(
                                        color: AppController.instance.corLetras,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                    'Data de nascimento'),
                                Text(
                                  '${date.day}/${date.month}/${date.year}',
                                  style: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ), // data nascimento
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '———Dados endereço———',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppController.instance.corLetras,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ), //'---dados endereco---'
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Card(
                                  color: AppController.instance.corTelaAcima,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: cepController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              label: Text('CEP'),
                                              labelStyle: TextStyle(
                                                  color: AppController
                                                      .instance.corLetras,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300),
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 0.5)),
                                              suffixIcon: Icon(
                                                Icons.home,
                                                color: AppController
                                                    .instance.corPrincipal,
                                              )),
                                        ), // cep
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: TextFormField(
                                            controller: enderecoController,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                                label: Text('Endereço'),
                                                labelStyle: TextStyle(
                                                    color: AppController
                                                        .instance.corLetras,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.5)),
                                                suffixIcon: Icon(
                                                  Icons.home,
                                                  color: AppController
                                                      .instance.corPrincipal,
                                                )),
                                          ),
                                        ), // endereco
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: TextFormField(
                                                  controller: bairroController,
                                                  decoration: InputDecoration(
                                                      label: Text('Bairro'),
                                                      labelStyle: TextStyle(
                                                          color: AppController
                                                              .instance
                                                              .corLetras,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .w300),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      width:
                                                                          0.5)),
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .account_box_outlined,
                                                        color: AppController
                                                            .instance
                                                            .corTelaAcima,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: TextFormField(
                                                  controller: ufController,
                                                  decoration: InputDecoration(
                                                      label: Text('UF'),
                                                      labelStyle: TextStyle(
                                                          color: AppController
                                                              .instance
                                                              .corLetras,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .w300),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      width:
                                                                          0.5)),
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .people_alt_outlined,
                                                        color: AppController
                                                            .instance
                                                            .corTelaAcima,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: TextFormField(
                                            controller: complementoController,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                                label: Text('Complemento'),
                                                labelStyle: TextStyle(
                                                    color: AppController
                                                        .instance.corLetras,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.5)),
                                                suffixIcon: Icon(
                                                  Icons.home,
                                                  color: AppController
                                                      .instance.corPrincipal,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), //CEP
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: AppController.instance.corPrincipal,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.03,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppController.instance.corTelaAcima),
                        child: Text(
                            style: TextStyle(
                                color: AppController.instance.corLetras,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                            'Permissões'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode fazer venda?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: fazVenda,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            fazVenda = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode cadastrar produto?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: cadastraProduto,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            cadastraProduto = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Pode ver estoque do produto?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: veEstoque,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            veEstoque = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode editar um produto?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: editaProduto,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            editaProduto = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode lançar serviço?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: lancaServico,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            lancaServico = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'O colaborador presta serviço?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: prestaServico,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            prestaServico = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode editar um cliente?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: editaCliente,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            editaCliente = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode gerar relatórios?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: geraRelatorio,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            geraRelatorio = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode receber no caixa?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: recebeNoCaixa,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            recebeNoCaixa = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras),
                          'Colaborador pode ver quanto vendeu?'),
                      Switch(
                        // This bool value toggles the switch.
                        value: veQuantoVendeu,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            veQuantoVendeu = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppController.instance.corPrincipal,
                              AppController.instance.corTelaAcima
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(
                                  2, 4),
                            ),
                          ]),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            fazerRequisicao();
                          },
                          child: Text(
                              style: TextStyle(
                                fontSize: 30,
                                color: AppController.instance.corLetras.withOpacity(0.6),
                                fontWeight: FontWeight.w700,
                              ),
                              'Cadastrar')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildJanelinhaQueSobe(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context); // Fechar a janela
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CameraCamera(
                          onFile: (file) {
                            showPreview(file);
                            Navigator.pop(context);
                            setState(() {
                              widget.file = file;
                            });
                          },
                        )),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Galeria'),
            onTap: () {
              chamaAGaleria();
            },
          ),
        ],
      ),
    );
  }

  showPreview(file) async {
    file = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(file: file),
        ));
    if (file != null) {
      setState(() {
        widget.file = file;
      });
      Get.back();
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> fazerRequisicao() async {
    foto = widget.file.path;
    nome = nomeController.text;
    tel = telController.text;
    cpf = cpfController.text;
    rg = rgController.text;
    email = emailController.text;
    cep = cepController.text;
    endereco = enderecoController.text;
    bairro = bairroController.text;
    complemento = complementoController.text;
    final String apiUrl = 'http://localhost:8082/usuario/novo-colaborador';
    Future<List<int>> getImageBytes() async {
      File path = File(widget.file.path);
      path.existsSync();
      return await path.readAsBytes();
    }
    List<int> imageBytes = await getImageBytes();
    String imageEm64 = base64Encode(imageBytes);

    final payload = {
      "fotoDePerfil": imageEm64,
      "celularDeAcesso": "551102108432",
      "objPessoa": {
        "atencao": "atencao",
        "nome": nome,
        "nomeDeGuerra": "nomeDeGuerra",
        "celular": tel,
        "senha": "000000",
        "cpf": cpf,
        "rg": rg,
        "dataDeNascimento": "$date",
        "email": email,
        "objEndereco": {
          "cep": cep,
          "logradouro": endereco,
          "complemento": complemento,
          "bairro": bairro,
          "localidade": "localidade",
          "uf": uf
        },
        "objetoLinhaDeCredito": {"limite": 1.99}
      },
      "objAutorizacoes": {
        "podeFazerDevolucao": true,
        "podeCadastrarProduto": '$cadastraProduto',
        "objProdutosPode": {
          "podeVerEstoqueDeProduto": '$veEstoque',
          "podeEditarProduto": '$editaProduto',
          "valorDaComissao": 0.00
        },
        "objVendasPode": {"fazVenda": '$fazVenda', "comissaoDeVendas": 0.00},
        "objAssistenciaTecnicaPode": {
          "lancaServico": '$lancaServico',
          "ehUmTecnicoEFazAssistenciaTecnica": true,
          "comissaoDeAssistencia": 0.00
        },
        "objClientesPode": {"podeEditarCliente": '$editaCliente'},
        "objRelatoriosPode": {"geraRelatorioDeVendas": '$geraRelatorio'},
        "objLancamentosFinanceirosPode": {
          "podeReceberNoCaixa": '$recebeNoCaixa',
          "podeVerQuantoVendeu": '$veQuantoVendeu'
        }
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'idUser': '5dab33ff2a8c4d6690547e33708fa2b1'
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) {
      // Requisição bem-sucedida
      print('Requisição enviada com sucesso!');
      print('Resposta da API: ${response.statusCode}');
    } else {
      // Requisição falhou
      print('Falha na requisição. Código de status: ${response.statusCode}');
    }
  }
}
