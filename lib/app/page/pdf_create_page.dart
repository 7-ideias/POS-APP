// import 'package:flutter/material.dart';
//
// import 'report_pdf.dart';
//
// class PDFCreatePage extends StatefulWidget {
//   const PDFCreatePage({super.key});
//
//   @override
//   _PDFCreatePageState createState() => _PDFCreatePageState();
// }
//
// class _PDFCreatePageState extends State<PDFCreatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('teste de relatorio'),),
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.only(top: 30),
//           height: 40,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               elevation: 5,
//               padding: const EdgeInsets.all(12.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//             ),
//             child: const Text(
//               'gerar um relatorio',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//               reportView(context,'');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
