// To parse this JSON data, do
//
//     final car = carFromMap(jsonString);

import 'dart:convert';

Car carFromMap(String str) => Car.fromMap(json.decode(str));

String carToMap(Car data) => json.encode(data.toMap());

class Car {
  Car({
    required this.carName,
    required this.country,
    required this.establishmentYear,
    required this.model,
  });

  final String carName;
  final String country;
  final int establishmentYear;
  final List<Model> model;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        carName: json["car_name"],
        country: json["country"],
        establishmentYear: json["establishment_year"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "car_name": carName,
        "country": country,
        "establishment_year": establishmentYear,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
      };
}

class Model {
  Model({
    required this.modelName,
    required this.price,
    required this.gasoline,
  });

  final String modelName;
  final int price;
  final bool gasoline;

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        price: json["price"],
        gasoline: json["gasoline"],
      );

  Map<String, dynamic> toMap() => {
        "model_name": modelName,
        "price": price,
        "gasoline": gasoline,
      };
}
