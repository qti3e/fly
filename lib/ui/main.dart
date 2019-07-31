import 'package:flutter/material.dart';
import 'package:fly/fly.dart';
import 'package:fly/state.dart';
import 'package:fly/theme.dart';
import 'package:fly/ui/view.dart';

class FlyApp extends StatefulWidget {
  final FlyBuilder builder;
  final FlyState state = FlyState();

  FlyApp(this.builder);

  @override
  _FlyAppState createState() => _FlyAppState();
}

class _FlyAppState extends State<FlyApp> {
  Widget _buildListItem(WidgetDescriptor widgetDescriptor) {
    bool selected = widgetDescriptor == widget.state.selected;

    return ListTile(
      title: Text(widgetDescriptor.title),
      trailing: !selected ? Icon(Icons.keyboard_arrow_right) : null,
      leading: selected ? Icon(Icons.done) : null,
      onTap: () {
        if (!selected)
          setState(() {
            widget.state.select(widgetDescriptor);
          });
      },
    );
  }

  Widget _buildDrawerContent() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView(
          children: widget.state.list.map(_buildListItem).toList(),
        ))
      ],
    );
  }

  Widget _buildBody() {
    if (widget.state.list.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_dissatisfied, size: 130, color: Colors.grey),
            Text('No story found.'),
            Text('Please checkout the examples provided by Fly.')
          ],
        ),
      );
    }

    if (widget.state.isSelected == false) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_satisfied, size: 130, color: Colors.grey),
            Text('Please chose a item from the menu.'),
          ],
        ),
      );
    }

    if (widget.state.selected == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.not_interested, size: 130, color: Colors.grey),
            Text('Story has been moved and we were not able to detect it.'),
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: StoryView(
          widgetDescriptor: widget.state.selected,
        ),
      ),
    );
  }

  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fly'),
      ),
      drawer: widget.state.list.length == 0
          ? null
          : Drawer(
              semanticLabel: 'Stories List',
              child: _buildDrawerContent(),
            ),
      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Fly fly = Fly();
    widget.builder(fly);
    widget.state.updateFly(fly);

    return StreamBuilder(
      stream: applicationTheme.changeStream,
      builder: (context, value) => MaterialApp(
          title: 'Flutter Fly',
          theme: applicationTheme.materialTheme,
          home: _buildView()),
    );
  }
}
