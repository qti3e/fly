import 'package:fly/fly.dart';

class FlyState {
  Fly fly;
  String _selectedTitle;
  WidgetDescriptor _widgetDescriptor;

  List<WidgetDescriptor> get list => fly.list;

  WidgetDescriptor get selected => _widgetDescriptor;

  bool get isSelected => _selectedTitle != null;

  void select(WidgetDescriptor widgetDescriptor) {
    _widgetDescriptor = widgetDescriptor;
    _selectedTitle = widgetDescriptor?.title;
  }

  void updateFly(Fly newFly) {
    Fly oldFly = fly;
    fly = newFly;

    // Just in case.
    if (newFly == oldFly) return;

    // Special cases;
    if (newFly.list.length == 0) {
      _widgetDescriptor = null;
      return;
    }

    // If no story is currently selected, just skip the search.
    if (_selectedTitle == null) {
      return;
    }

    // Try to find the currently selected story by its title.
    for (WidgetDescriptor widgetDescriptor in newFly.list) {
      // We found it.
      if (widgetDescriptor.title == _selectedTitle) {
        select(widgetDescriptor);
        return;
      }
    }

    // User removed one or more stories including the selected story.
    if (newFly.list.length < oldFly.list.length) {
      _widgetDescriptor = null;
      // We don't change the _selectedTitle as user might add the story again
      // and would expect to see it there.
      return;
    }

    // Compute the title diffs.
    Set<String> newFlyTitles = Set();
    Set<String> oldFlyTitles = Set();

    newFlyTitles.addAll(newFly.list.map((wd) => wd.title));
    oldFlyTitles.addAll(oldFly.list.map((wd) => wd.title));

    // Titles that are in newFly, but not in the oldFly
    Set<String> newlyAddedTitles = newFlyTitles.difference(oldFlyTitles);
    // Titles that are in oldFly, but not in the newFly.
    Set<String> removedTitles = oldFlyTitles.difference(newFlyTitles);

    // Only one title has been changed.
    if (newlyAddedTitles.length == 1 && removedTitles.length == 1) {
      String newTitle = newlyAddedTitles.first;
      select(newFly.list.firstWhere((wd) => wd.title == newTitle));
      return;
    }

    // Ok, now we're really screwed!
    // To be continued...

    // Sorry...
    _widgetDescriptor = null;
  }
}
