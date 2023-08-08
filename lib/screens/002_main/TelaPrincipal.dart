// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:untitled/utilitarios/MenuLateral.dart';
//
// import 'IconWithLabel.dart';
//
// class TelaPrincipal extends StatefulWidget {
//   @override
//   _TelaPrincipalState createState() => _TelaPrincipalState();
// }
//
// class _TelaPrincipalState extends State<TelaPrincipal> {
//   int _currentIndex = 0;
//
//   Color _currentColor = Colors.red;
//
//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _currentColor = _currentColor == Colors.red ? Colors.white : Colors.red;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tela Principal'),
//       ),
//       body: tela2(),
//       drawer: MenuLateral(context),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               // Lógica para quando o botão do carrinho de compras for pressionado
//             },
//             child: Icon(Icons.shopping_cart),
//           ),
//           SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: () {
//               // Lógica para quando o botão de adição for pressionado
//             },
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }
//
//   Widget tela() {
//     return Container(
//         // color: Colors.white,
//         child: Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: Colors.yellow,
//     ));
//   }
//
//   BottomNavigationBar buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: (int index) {
//         if (index == 1) {
//           // Abra o menu suspenso que ocupa 50% da tela
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return Dialog(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text('Novo'),
//                         ],
//                       ),
//                       SizedBox(height: 10.0),
//                       Row(
//                         children: [
//                           Text('Pedido'),
//                         ],
//                       ),
//                       SizedBox(height: 10.0),
//                       botoesDePedido(),
//                       SizedBox(height: 10.0),
//                       Row(
//                         children: [
//                           Text('Cadastro'),
//                         ],
//                       ),
//                       SizedBox(height: 10.0),
//                       itensDeCadastro()
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'BT1',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'NOVO',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'BT2',
//         ),
//       ],
//     );
//   }
//
//   Widget itensDeCadastro() {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconWithLabel(
//             icon: Icons.home,
//             label: 'Receita',
//           ),
//           SizedBox(width: 10),
//           IconWithLabel(
//             icon: Icons.search,
//             label: 'Despesa',
//           ),
//           SizedBox(width: 10),
//           IconWithLabel(
//             icon: Icons.favorite,
//             label: 'Agenda',
//           ),
//           SizedBox(width: 10),
//           IconWithLabel(
//             icon: Icons.shopping_cart,
//             label: 'Serviço',
//           ),
//           SizedBox(width: 10),
//           IconWithLabel(
//             icon: Icons.person,
//             label: 'Produto',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container botoesDePedido() {
//     return Container(
//       height: MediaQuery.of(context).size.height / 5,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     child: getCardDePedido('Serviço'),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: getCardDePedido('Venda'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 10,
//           ),
//           Expanded(
//             child: Container(
//               child: Card(
//                 elevation: 2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.accessibility),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('PDV'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Card getCardDePedido(String texto) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.abc_rounded),
//             SizedBox(
//               width: 10,
//             ),
//             Text(texto),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget tela2() {
//     return Container(
//       color: Colors.yellow,
//       height: double.infinity,
//       width: double.infinity,
//       child: Column(
//         children: [
//           buildColorido(context),
//         ],
//       ),
//     );
//   }
//
//   double width() => 90;
//
//   Widget buildColorido(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 90,
//             height: 90,
//             margin: EdgeInsets.only(right: 20),
//             color: _currentColor,
//           ),
//           Container(
//             width: 90,
//             height: 90,
//             margin: EdgeInsets.only(right: 20),
//             color: _currentColor,
//           ),
//           Container(
//             width: 90,
//             height: 90,
//             color: _currentColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
