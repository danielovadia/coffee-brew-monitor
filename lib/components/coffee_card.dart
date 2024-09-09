import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeeCard extends ConsumerWidget {
  const CoffeeCard({super.key, required this.coffee});

  final Coffee coffee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.brown[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(coffee.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: () {
                          ref
                              .read(coffeesProvider.notifier)
                              .removeByKey(coffee.id ?? -1);
                        },
                        child: const Icon(Icons.delete,
                            color: Colors.red, size: 20))
                  ]),
              Text(
                coffee.brewery ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

FutureBuilder<List<Widget>> coffeeCardsBuilder(List<Coffee> coffees) {
  return FutureBuilder(
      future: createCoffeeWidgets(coffees),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: snapshot.data as List<Widget>,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                'Error loading data: \n${snapshot.error} \n ${snapshot.stackTrace}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

Future<List<Widget>> createCoffeeWidgets(coffees) async {
  List<Widget> coffeeWidgets = [];
  for (Coffee coffee in coffees) {
    coffeeWidgets.add(CoffeeCard(coffee: coffee));
  }
  return coffeeWidgets;
}
