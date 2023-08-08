// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled/screens/others/CarouselPage.dart';
// import 'package:untitled/screens/others/CepEnvio.dart';
// import 'package:untitled/screens/001_login/TelaLoginTeste.dart';
//
// class CadastroClientePage extends StatefulWidget {
//   @override
//   _CadastroClientePageState createState() => _CadastroClientePageState();
// }
//
// class _CadastroClientePageState extends State<CadastroClientePage> {
//   int _currentIndex = 0;
//   final nomeController = TextEditingController();
//   final enderecoController = TextEditingController();
//   final telefoneController = TextEditingController();
//
//   void _salvarCliente() async {
//     String nome = nomeController.text;
//     String endereco = enderecoController.text;
//     String telefone = telefoneController.text;
//     // Enviar dados para o servidor
//     Map<String, String> data = {
//       'nome': nome,
//       'endereco': endereco,
//       'telefone': telefone,
//     };
//     var response = await http.post(
//       Uri.parse('http://localhost:3000/testenovo'),
//       body: jsonEncode(data),
//       headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200) {
//       print('Salvei com sucesso');
//       // Limpar campos
//       nomeController.clear();
//       enderecoController.clear();
//       telefoneController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastro de Cliente'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: TextField(
//                   controller: nomeController,
//                   decoration: InputDecoration(
//                     labelText: 'Nome',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: TextField(
//                   controller: enderecoController,
//                   decoration: InputDecoration(
//                     labelText: 'Endereço',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: TextField(
//                   controller: telefoneController,
//                   decoration: InputDecoration(
//                     labelText: 'Telefone',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _salvarCliente,
//                 child: Text('Salvar'),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CarouselPage()),
//                   );
//                 },
//                 child: Text('Abrir Carousel'),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CepEnvio()),
//                   );
//                 },
//                 child: Text('CEP envio'),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => TelaLoginTeste()),
//                   // );
//                 },
//                 child: Text('nova tela login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }
//
//   BottomNavigationBar buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: (int index) {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Buscar',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Perfil',
//         ),
//       ],
//     );
//   }
// }
