import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_storage.dart';
import 'package:coffee_monitor/models/coffee.dart';

class CoffeeService extends StateNotifier<List<Coffee>> {
  // singleton
  CoffeeService._privateConstructor() : super([]);
  static final CoffeeService _instance = CoffeeService._privateConstructor();

  static CoffeeService get instance {
    return _instance;
  }

  get coffees => state;

  updateCoffees(List<Coffee> coffees) {
    state = coffees;
  }

  init() async {
    List<Coffee> coffees = await _getAllCoffees();
    state = coffees;
  }

  _getAllCoffees() async {
    String resultAsString =
        await LocalStorage.instance.getData('coffees_list') ?? '';

    if (resultAsString.isEmpty) {
      resultAsString = '[]';
    }

    var json = jsonDecode(resultAsString);

    if (json is! List) {
      return [];
    }

    List coffees =
        json.map<Coffee>((coffee) => Coffee.fromJson(coffee)).toList();

    return coffees;
  }

  saveCoffee(Coffee coffee) async {
    // LocalStorage.instance.removeData('coffees_list');

    String resultAsString =
        await LocalStorage.instance.getData('coffees_list') ?? '[]';

    var json = jsonDecode(resultAsString);

    var coffees = json.map<Coffee>((coffee) => Coffee.fromJson(coffee)).toList()
        as List<Coffee>;

    // if exists, dont add
    if (coffees.any((element) => element.name == coffee.name)) {
      return;
    }

    coffee.id = DateTime.now().millisecondsSinceEpoch;

    coffees.add(coffee);

    state = coffees;
    // save the updated list in local storage
    var coffeesParsed = jsonEncode(coffees);
    await LocalStorage.instance
        .saveData('coffees_list', coffeesParsed.toString());
  }

  removeByKey(int id) async {
    String resultAsString =
        await LocalStorage.instance.getData('coffees_list') ?? '[]';

    var json = jsonDecode(resultAsString);

    var coffees = json.map<Coffee>((coffee) => Coffee.fromJson(coffee)).toList()
        as List<Coffee>;

    coffees.removeWhere((element) => element.id == id);

    state = coffees;

    // save the updated list of coffees
    var coffeesParsed = jsonEncode(coffees);
    await LocalStorage.instance
        .saveData('coffees_list', coffeesParsed.toString());
  }
}
