// import 'package:flutter/material.dart';
// class CustomCircularProgressIndicator extends StatefulWidget {
//   @override
//   _CustomCircularProgressIndicatorState createState() =>
//       _CustomCircularProgressIndicatorState();
// }
// class _CustomCircularProgressIndicatorState
//     extends State<CustomCircularProgressIndicator>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat();
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 60,
//         height: 60,
//         child: Stack(
//           children: [
//             Positioned(
//               left: 30,
//               top: 0,
//               child: _Ball(color: Colors.red, controller: _controller),
//             ),
//             Positioned(
//               left: 60,
//               top: 30,
//               child: _Ball(color: Colors.blue, controller: _controller),
//             ),
//             Positioned(
//               left: 30,
//               top: 60,
//               child: _Ball(color: Colors.green, controller: _controller),
//             ),
//             Positioned(
//               left: 0,
//               top: 30,
//               child: _Ball(color: Colors.purple, controller: _controller),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class _Ball extends StatelessWidget {
//   final Color color;
//   final AnimationController controller;
//   const _Ball({
//     Key? key,
//     required this.color,
//     required this.controller,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: controller.value * 2 * 3.141592653589793,
//           child: child,
//         );
//       },
//       child: Container(
//         width: 20,
//         height: 20,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }