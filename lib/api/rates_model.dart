import 'dart:convert';

RatesModel ratesModelFromJson(String str) =>
    RatesModel.fromJson(json.decode(str));

String ratesModelToJson(RatesModel data) => json.encode(data.toJson());

class RatesModel {  //constructor & member variable to make object
  RatesModel({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  String disclaimer;
  String license;
  int timestamp;
  String base;
  Map<String, double> rates;

  //JSON to RatesModel object and pass to map string, dynamic
  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
    disclaimer: json["disclaimer"],
    license: json["license"],
    timestamp: json["timestamp"],
    base: json["base"],
    rates: Map.from(json["rates"])
        .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  //Using toJson method to JSON object and get return map string, dynamic
  Map<String, dynamic> toJson() => {
    "disclaimer": disclaimer,
    "license": license,
    "timestamp": timestamp,
    "base": base,
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}