import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/services/coffee_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coffeesProvider =
    StateNotifierProvider<CoffeeService, List<Coffee>>((ref) {
  return CoffeeService.instance;
});
