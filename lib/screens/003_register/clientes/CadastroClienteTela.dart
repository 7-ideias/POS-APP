// import 'package:flutter/material.dart';
//
// class CadastroClienteTela extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Novo Cliente'),
//           leading: IconButton(
//             icon: Icon(Icons.accessibility),
//             onPressed: () {
//               Navigator.of(context)
//                   .pop(); // Ação quando o ícone for pressionado
//             },
//           ),
//           actions: [],
//         ),
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Nome',
//                       ),
//                     ),
//                     SizedBox(height: 16.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Celular',
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     SizedBox(height: 16.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Telefone',
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     SizedBox(height: 16.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'E-mail',
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(height: 16.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'CPF/CNPJ',
//                       ),
//                     ),
//                     SizedBox(height: 16.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Lógica para realizar o cadastro
//                       },
//                       child: Text('Cadastrar'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
