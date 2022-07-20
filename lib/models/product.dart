import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String? name;
  final String? description;
  final int? price;

  Product({this.name, this.description, this.price});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      name: parsedJson['name'] ?? "",
      description: parsedJson['desc'] ?? "",
      price: parsedJson['price'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "desc": description,
      "price": price,
    };
  }
}
