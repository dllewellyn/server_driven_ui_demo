export 'optional_text_validator.dart';
export 'required_under_50_validator.dart';



import 'required_under_50_validator.dart';
import 'optional_text_validator.dart';

const Map<String, Function(String)> validatorMap = {
  "optional": optionalTextValidator,
  "required_under_50": requiredUnder50Validator
};