abstract class Serializable<T> {
  String record;
  String records;
  T fromJson(Map<String, dynamic> json, {Map<String, dynamic> includedJson});
  List<T> fromJsonArray(List<dynamic> jsonArray);
  Map<String, dynamic> toJson(T t);
  List<dynamic> toJsonArray(List<T> tList);
}
