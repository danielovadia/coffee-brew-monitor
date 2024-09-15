import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({super.key, required this.coffee});

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(
          coffee.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(coffee.brewery ?? ''),
        trailing: DeleteButton(coffee: coffee),
        tileColor: Colors.brown[50],
      ),
    );
  }
}

class DeleteButton extends ConsumerWidget {
  deleteCoffee(Coffee coffee, WidgetRef ref) {
    ref.read(coffeesProvider.notifier).removeByKey(coffee.id ?? -1);
  }

  const DeleteButton({
    super.key,
    required this.coffee,
  });

  final Coffee coffee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: const EdgeInsets.all(12),
        ),
        onPressed: () {
          deleteCoffee(coffee, ref);
        },
        child: const Icon(Icons.delete, color: Colors.red, size: 20));
  }
}
