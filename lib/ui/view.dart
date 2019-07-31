import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fly/fly.dart';

class StoryView extends StatelessWidget {
  final WidgetDescriptor widgetDescriptor;

  StoryView({this.widgetDescriptor});

  Size getSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;

    if (widgetDescriptor.height != null) {
      height = widgetDescriptor.height;
    }

    if (widgetDescriptor.width != null) {
      width = widgetDescriptor.width;
    }

    double maxHeight = widgetDescriptor.maxHeight == null
        ? size.height
        : min(size.height, widgetDescriptor.maxHeight);

    double maxWidth = widgetDescriptor.maxWidth == null
        ? size.width
        : min(size.width, widgetDescriptor.maxWidth);

    width = min(maxWidth, width);
    height = min(maxHeight, height);

    if (widgetDescriptor.ratio == 0) {
      return Size(width, height);
    }

    // Now try to apply the ratio.
    double finalWidth = width;
    double finalHeight = width * widgetDescriptor.ratio;

    if (finalHeight > maxHeight) {
      finalHeight = height;
      finalWidth = finalHeight / widgetDescriptor.ratio;
    }

    return Size(finalWidth, finalHeight);
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/grid.jpg'),
              repeat: ImageRepeat.repeat)),
      child: Align(
          alignment: Alignment.topLeft,
          child: widgetDescriptor.builder(context)),
    );
  }
}
