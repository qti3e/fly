import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;
import 'dart:math';

class Wave extends StatefulWidget {
  final double width;
  final double height;
  final double waveHeight;
  final Color color;
  final Duration duration;
  final Widget child;

  Wave(
      {this.height,
      this.width,
      this.duration,
      this.child,
      this.waveHeight = 10,
      this.color = Colors.pink});

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Offset> _waveList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(seconds: 2));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
        builder: (_, child) {
          if (widget.waveHeight == 0) {
            return child;
          }

          return ClipPath(
            clipper: WaveClipper(_controller.value, widget.waveHeight),
            child: child,
          );
        },
        child: Container(
            height: widget.height,
            width: widget.width,
            color: widget.color,
            child: widget.child));
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double _animation;
  final double _waveHeight;

  WaveClipper(this._animation, this._waveHeight);

  List<Offset> _waveList(Size size) {
    List<Offset> list = [];
    for (int i = 0; i <= size.width; i++) {
      list.add(new Offset(
          i.toDouble(),
          sin((this._animation * 360 - i) % 360 * Vector.degrees2Radians) *
                  _waveHeight +
              size.height -
              _waveHeight));
    }
    return list;
  }

  @override
  Path getClip(Size size) {
    if (_waveHeight == 0) {
      Path path = new Path();
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
      path.close();
      return path;
    }

    Path path = new Path();

    path.moveTo(0, size.height);

    path.addPolygon(_waveList(size), false);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      _animation != oldClipper._animation ||
      _waveHeight != oldClipper._waveHeight;
}

