library fly;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/ui/main.dart';
import 'package:fly/theme.dart';

class Fly {
  /// List of Widget descriptors.
  final List<WidgetDescriptor> list = [];

  WidgetDescriptor add(String title,
      {@required WidgetBuilder builder,
      double ratio = 1,
      double width,
      double height,
      double maxWidth ,
      double maxHeight}) {
    final descriptor = WidgetDescriptor(
        builder: builder,
        title: title,
        ratio: ratio,
        width: width,
        height: height,
        maxWidth: maxWidth,
        maxHeight: maxHeight);
    list.add(descriptor);
    return descriptor;
  }
}

class WidgetDescriptor {
  final WidgetBuilder builder;
  final String title;
  final double ratio;
  final double width;
  final double height;
  final double maxWidth;
  final double maxHeight;

  WidgetDescriptor(
      {this.builder,
      this.title,
      this.ratio,
      this.width,
      this.height,
      this.maxWidth,
      this.maxHeight});
}

typedef FlyBuilder = void Function(Fly fly);

void runFly(FlyBuilder builder, {FlyThemeData theme}) {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(FlyApp(builder));
}
