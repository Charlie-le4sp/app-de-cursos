// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, library_private_types_in_public_api

import 'package:flutter/material.dart';

class AnimatedTap extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scale;

  const AnimatedTap({
    Key? key,
    required this.child,
    required this.onTap,
    this.scale = 0.8,
  }) : super(key: key);

  @override
  _AnimatedTapState createState() => _AnimatedTapState();
}

class _AnimatedTapState extends State<AnimatedTap>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: widget.scale).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
