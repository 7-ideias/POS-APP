// import 'package:flutter/material.dart';
//
// class TelaLoginTeste extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.purple, Colors.orange, Colors.red],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: 20),
//               height: MediaQuery.of(context).size.height * 0.7,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(60),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     color: Colors.cyan,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Text(
//                     'Login',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Login',
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Senha',
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Entrar',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
