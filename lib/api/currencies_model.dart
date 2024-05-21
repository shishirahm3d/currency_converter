import 'dart:convert';
//key value return map string & dynamic
Map<String, String> allCurrenciesFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));
//convert json string to dart map object
String allCurrenciesToJson(Map<String, String> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));