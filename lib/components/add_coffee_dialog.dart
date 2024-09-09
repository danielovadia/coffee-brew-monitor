import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCoffeeDialog extends ConsumerStatefulWidget {
  const AddCoffeeDialog({super.key});

  @override
  AddCoffeeDialogState createState() => AddCoffeeDialogState();
}

class AddCoffeeDialogState extends ConsumerState<AddCoffeeDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breweryController = TextEditingController();

  void onSaved() {
    addCoffee(ref, nameController.text, breweryController.text);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  void addCoffee(WidgetRef ref, String name, String brewery) {
    ref
        .read(coffeesProvider.notifier)
        .saveCoffee(Coffee(name: name, brewery: brewery));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 200,
          child: Form(
              child: Column(
            children: [
              const Text("Add new coffee"),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: breweryController,
                decoration: const InputDecoration(labelText: 'Brewery'),
              ),
              // spacing
              const Expanded(child: SizedBox(height: 16)),
              ElevatedButton(
                onPressed: () {
                  onSaved();
                },
                child: const Text('Add'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
