import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:server_driven_ui_demo/models/models.dart';
import 'package:server_driven_ui_demo/widgets/primary_button.dart';
import 'package:server_driven_ui_demo/widgets/primary_text_input.dart';

class AddToDoScreen extends StatefulWidget {
  final AddToDoScreenConfig toDoScreenConfig;

  const AddToDoScreen({Key key, @required this.toDoScreenConfig})
      : super(key: key);

  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final Map<String, TextEditingController> controllers = Map();
  Map<String, bool> checkBoxes = Map();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController controller in controllers.values) {
      if (controller != null) {
        controller.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
            children: widget.toDoScreenConfig.inputs.map((e) {
          if (e is AddToDoTextInput) {
            return _handleTextInput(e);
          } else if (e is AddToDoCheckboxInput) {
            return _buildCheckboxInput(e);
          }

          return Container();
        }).toList()
              ..add(PrimaryButton(
                text: "Submit",
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Map<String, dynamic> returnValues = Map();
                    widget.toDoScreenConfig.inputs.forEach((element) {
                      if (element is AddToDoTextInput) {
                        returnValues[element.fieldName] =
                            controllers[element.fieldName].text;
                      } else if (element is AddToDoCheckboxInput) {
                        returnValues[element.fieldName] =
                            checkBoxes[element.fieldName];
                      }

                      print(returnValues);
                    });
                  }
                },
              ))),
      ),
    );
  }

  CheckboxListTile _buildCheckboxInput(AddToDoCheckboxInput e) {
    if (checkBoxes.containsKey(e.fieldName) == false) {
      checkBoxes[e.fieldName] = e.selectedByDefault;
    }

    return CheckboxListTile(
      title: Text(e.checkboxTitle),
      onChanged: (v) {
        checkBoxes[e.fieldName] = v;
        setState(() {});
      },
      value: checkBoxes[e.fieldName],
    );
  }

  PrimaryTextInput _handleTextInput(AddToDoTextInput e) {
    TextEditingController controller = TextEditingController();

    if (controllers.containsKey(e.fieldName) == false) {
      controllers[e.fieldName] = controller;
    }

    return PrimaryTextInput(
      validator: e.validator,
      controller: controllers[e.fieldName],
      hintText: e.hintText,
    );
  }
}
