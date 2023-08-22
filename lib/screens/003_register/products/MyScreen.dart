// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'Produto.dart';
// import 'User.dart';
//
// class MyScreen extends StatelessWidget {
//   Future<List<Produto>> fetchUsers() async {
//     final response = await http.get(
//         // Uri.parse('https://sixbackend-70ed1c73ebec.herokuapp.com/lista/produtos'),
//       Uri.parse('http://localhost:8082/lista/produtos'),
//       // Uri.parse('https://jsonplaceholder.typicode.com/users'),
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<Produto> produtoList = [];
//       // List<User> users = [];
//       for (var item in data) {
//         produtoList.add(Produto.fromJson(item));
//         // users.add(User.fromJson(item));
//       }
//       return produtoList;
//       // return users;
//     } else {
//       throw Exception('Erro ao carregar os usuários');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Minha Tela'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             fetchUsers().then((users) {
//               // Faça algo com a lista de usuários
//               for (var user in users) {
//                 print(user.nomeProduto);
//               }
//             }).catchError((error) {
//               // Trate o erro
//               print(error);
//             });
//           },
//           child: Text('Chamar API'),
//         ),
//       ),
//     );
//   }
// }
