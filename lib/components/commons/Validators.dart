class Validators {
  static String validateText(String fieldName, String value,
      {bool required, int minText, int maxText}) {
    String valueValidate = (value == null ? "" : value.trim());

    if (required == true && valueValidate.length == 0) {
      return "$fieldName is required";
    }

    if (minText != null && valueValidate.length < minText) {
      return "Min ${fieldName.toLowerCase()} value is ${minText.toString()}";
    }

    if (maxText != null && valueValidate.length > maxText) {
      return "Max ${fieldName.toLowerCase()} value is ${maxText.toString()}";
    }

    return null;
  }

  static bool validateEmail(String value) {
    if (value == null) return false;
    if (value.trim().length == 0) return false;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    return !regex.hasMatch(value);
  }

  static String validateInt(String fieldName, int value, {bool required, int minValue, int maxValue}){

    int valueValidate = (value == null ? 0 : value);

    if (required == true && valueValidate == 0) {
      return "$fieldName is required";
    }

    if (minValue != null && valueValidate < minValue) {
      return "Min ${fieldName.toLowerCase()} value greater than $minValue";
    }

    if (maxValue != null && valueValidate > maxValue) {
      return "Max ${fieldName.toLowerCase()} value lower than $maxValue";
    }

    return null;

  }
}
