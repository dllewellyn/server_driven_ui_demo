import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:server_driven_ui_demo/models/add_to_do_screen_config.dart';
import 'package:server_driven_ui_demo/models/todo_list_config.dart';
import 'package:server_driven_ui_demo/screens/add_to_do_screen.dart';

import 'models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        config: ToDoListScreenConfig(configParser(json.decode("""
            {
  "type": "column",
  "children": [
    {
      "type": "row",
      "children": [
        {
          "type": "text",
          "textValue": "Sample todo"
        },
        {
          "type": "spacer"
        },
        {
          "type": "checkbox",
          "checked": true
        }
      ]
    }
  ]
}
"""))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ToDoListScreenConfig config;

  MyHomePage({Key key, @required this.config}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddToDoScreen(
                    toDoScreenConfig: AddToDoScreenConfig.fromJson(
                        json.decode(sampleConfig) as List),
                  ))),
        ),
        appBar: AppBar(),
        body: Center(
          child: buildWidget(widget.config.widget),
        ));
  }

  Widget buildWidget(SingleWidget widget) {
    if (widget is ColumnWidget) {
      return Column(
        children: widget.children.map((e) => buildWidget(e)).toList(),
      );
    } else if (widget is RowWidget) {
      return Row(
        children: widget.children.map((e) => buildWidget(e)).toList(),
      );
    } else if (widget is TextWidget) {
      return Text(widget.textValue);
    } else if (widget is ReadonlyCheckboxWidget) {
      return Checkbox(value: widget.isChecked, onChanged: (_) {});
    } else if (widget is SpacerWidget) {
      return Spacer();
    }

    return Container();
  }
}
