import "dart:convert";
import 'dart:developer' as dev;
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
  int price; // price per day
  String color;
  String imageURL;

  Car({required this.brand, required this.model, required this.price, required this.color, required this.imageURL});
  factory Car.fromJSON(Map<String, dynamic> json) {
    print(json.toString());
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
  dynamic raw = jsonDecode(response.body);
  List<Car> result = List<Car>.empty(growable: true);
  for (int i = 0; i < raw.length; i++) {
    result.add(Car.fromJSON(raw[i]));
  }
  return result;
}


class Dealer {

  String name;


  Dealer(this.name);
  factory Dealer.fromJSON(Map<String, dynamic> json) {
    return Dealer(json["name"]);
  }
}


class Filter {

  String name;

  Filter(this.name);

}


Future<List<Dealer>> fetchDealers() async  {
  final response = await http.get(Uri.parse("$API_URL/dealers"));
  final raw = jsonDecode(response.body);
  List<Dealer> result = List<Dealer>.empty(growable: true);
  for (int i = 0; i < raw.length; i++) {
    result.add(Dealer.fromJSON(raw[i]));
  }
  return result;
}