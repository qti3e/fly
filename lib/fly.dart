library fly;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/ui/main.dart';
import 'package:fly/ui/theme.dart';

class Fly {
  /// List of Widget descriptors.
  final List<WidgetDescriptor> list = [];

  WidgetDescriptor add(String title, {WidgetBuilder builder}) {
    final descriptor = WidgetDescriptor(builder: builder, title: title);
    list.add(descriptor);
    return descriptor;
  }
}

class WidgetDescriptor {
  final WidgetBuilder builder;
  final String title;

  WidgetDescriptor({this.builder, this.title});
}

typedef FlyBuilder = void Function(Fly fly);

void runFly(FlyBuilder builder, {FlyThemeData theme}) {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(FlyApp(builder));
}
