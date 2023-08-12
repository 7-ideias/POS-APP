import 'package:flutter/material.dart';

class ShakeIcon extends StatefulWidget {
  final Icon icon;

  ShakeIcon({required this.icon});

  @override
  _ShakeIconState createState() => _ShakeIconState();
}

class _ShakeIconState extends State<ShakeIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -5, end: 5).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: widget.icon,
        );
      },
    );
  }
}