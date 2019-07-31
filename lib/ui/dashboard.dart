import 'package:flutter/material.dart';
import 'package:fly/fly.dart';
import 'package:fly/state.dart';

class DashboardPage extends StatefulWidget {
  final FlyState state;

  DashboardPage(this.state);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  Widget _buildListItem(WidgetDescriptor widgetDescriptor) {
    return ListTile(
      title: Text(widgetDescriptor.title),
      leading: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          widget.state.select(widgetDescriptor);
        });
      },
    );
  }

  Widget _buildDrawerContent() {
    return Column(
      children: <Widget>[
        Text('# Your widgets'),
        Expanded(
            child: ListView(
          children: widget.state.list.map(_buildListItem).toList(),
        ))
      ],
    );
  }

  Widget _buildBox(Widget view) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/grid.jpg'),
              repeat: ImageRepeat.repeat)),
      child: Align(
        alignment: Alignment.topLeft,
        child: view,
      ),
    );
  }

  Widget _buildBody() {
    if (widget.state.isSelected == false) {
      return Center(
        child: Text('Please chose a item from the menu.'),
      );
    }

    if (widget.state.selected == null) {
      return Center(
          child: Icon(
        Icons.not_interested,
        size: 130,
        color: Colors.grey,
      ));
    }

    Widget view = widget.state.selected.builder(context);
    return Center(
      child: _buildBox(view),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fly'),
      ),
      drawer: Drawer(
        semanticLabel: 'Stories List',
        child: _buildDrawerContent(),
      ),
      body: _buildBody(),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}
