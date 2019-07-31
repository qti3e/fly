import 'package:flutter/material.dart';
import 'package:fly/examples/wave.dart';

import 'fly.dart';

void main() {
  runFly(flyMain);
}

void flyMain(Fly fly) {
  fly.add('Wave #2', builder: (BuildContext context) {
    return Center(
      child: Wave(
        height: 200,
        color: Color(0xff00ff00),
      ),
    );
  }, ratio: 16 / 9);
}
