

class ToDoListScreenConfig {
  final SingleWidget widget;

  ToDoListScreenConfig(this.widget);
}

abstract class SingleWidget {
  final String widgetName;

  SingleWidget(this.widgetName);
}

class ColumnWidget extends SingleWidget {
  final List<SingleWidget> children;

  ColumnWidget(this.children) : super("column");
}

class RowWidget extends SingleWidget {
  final List<SingleWidget> children;

  RowWidget(this.children) : super("row");
}

class TextWidget extends SingleWidget {
  final String textValue;

  TextWidget(this.textValue) : super("text");
}

class ReadonlyCheckboxWidget extends SingleWidget {
  final bool isChecked;

  ReadonlyCheckboxWidget(this.isChecked) : super("checkbox");
}

class SpacerWidget extends SingleWidget {
  SpacerWidget() : super("spacer");
}

SingleWidget configParser(dynamic) {
  SingleWidget returnValue;
  switch (dynamic["type"]) {
    case "text":
      return TextWidget(dynamic["textValue"]);
    case "row":
      return RowWidget(
          (dynamic["children"] as List).map((e) => configParser(e)).toList());
    case "column":
      return ColumnWidget(
          (dynamic["children"] as List).map((e) => configParser(e)).toList());
    case "checkbox":
      return ReadonlyCheckboxWidget(dynamic["checked"]);
    case "spacer":
      return SpacerWidget();
  }

  return returnValue;
}
