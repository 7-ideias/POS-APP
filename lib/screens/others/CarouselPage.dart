// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class CarouselPage extends StatelessWidget {
//
//   List<String> imagePaths = [
//     'assets/carlosFotoPerfil_laranja.jpg',
//     'assets/carlosFotoPerfil_laranja.jpg',
//     'assets/carlosFotoPerfil_laranja.jpg',
//     'assets/carlosFotoPerfil_laranja.jpg',
//     'assets/carlosFotoPerfil_laranja.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel Example'),
//       ),
//       body: CarouselSlider(
//         options: CarouselOptions(
//           height: 400.0,
//           autoPlay: true,
//           enlargeCenterPage: true,
//         ),
//         items: imagePaths.map((imagePath) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                 ),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }