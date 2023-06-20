import "dart:convert";

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "./constants.dart";

class NavigationItem {

  IconData iconData;

  NavigationItem(this.iconData);

}

List<NavigationItem> getNavigationItemList(){
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.calendar_today),
    NavigationItem(Icons.notifications),
    NavigationItem(Icons.person),
  ];
}

class Car {

  String brand;
  String model;
  double price; // price per day
  String color;
  String imageURL;

  Car({required this.brand, required this.model, required this.price, required this.color, required this.imageURL});
  factory Car.fromJSON(Map<String, dynamic> json) {
    return Car(
      brand: json["brand"],
      model: json["model"],
      price: json["price"],
      color: json["color"],
      imageURL: json["image_url"]
    );
  }
}

Future<List<Car>> fetchCars() async {
  final http.Response response = await http.get(Uri.parse("$API_URL/cars"));
  dynamic raw = jsonDecode(response.body).cars;
  List<Car> result = List<Car>.empty(growable: true);
  for (int i = 0; i < raw.length; i++) {
    result[i] = Car.fromJSON(raw[i]);
  }
  return result;
}


class Dealer {

  String name;
  int offers;
  String image;


  Dealer(this.name, this.offers, this.image);

}


class Filter {

  String name;

  Filter(this.name);

}
