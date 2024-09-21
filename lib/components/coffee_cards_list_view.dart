import 'package:coffee_monitor/components/coffee_card.dart';
import 'package:coffee_monitor/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeCardsListView extends StatelessWidget {
  final List<Coffee> coffees;

  const CoffeeCardsListView({
    super.key,
    required this.coffees,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coffees.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return CoffeeCard(coffee: coffees[index]);
      },
    );
  }
}