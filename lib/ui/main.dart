import 'package:flutter/material.dart';
import 'package:fly/fly.dart';
import 'package:fly/state.dart';
import 'package:fly/ui/dashboard.dart';
import 'package:fly/ui/theme.dart';

class FlyApp extends StatelessWidget {
  final FlyBuilder builder;
  final FlyState state = FlyState();

  FlyApp(this.builder);

  @override
  Widget build(BuildContext context) {
    Fly fly = Fly();
    builder(fly);
    state.updateFly(fly);

    return StreamBuilder(
      stream: applicationTheme.changeStream,
      builder: (context, value) => MaterialApp(
          title: 'Flutter Fly',
          theme: applicationTheme.materialTheme,
          home: DashboardPage(state)),
    );
  }
}
