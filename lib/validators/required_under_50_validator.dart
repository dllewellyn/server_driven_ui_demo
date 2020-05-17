String requiredUnder50Validator(String text) {
  if (text.isEmpty) {
    return "Cannot be empty";
  }

  if (text.length > 50) {
    return "Asset name must be < 50 characters";
  }

  return null;
}