export 'add_to_do_screen_config.dart';

const sampleConfig = """
[
  {
    "type": "text",
    "hintText": "Todo name",
    "validator": "required_under_50",
    "fieldName": "name"
  },
  {
    "type": "text",
    "hintText": "Todo name",
    "validator": "optional",
    "fieldName": "description"
  },
  {
    "type": "check",
    "selectedByDefault": false,
    "checkboxTitle": "Completed?",
    "fieldName": "completed"
  }
]
""";
