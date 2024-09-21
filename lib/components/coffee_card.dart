import 'package:coffee_monitor/common/widgets/app_icon_button.dart';
import 'package:coffee_monitor/components/coffee_page.dart';
import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeeCard extends ConsumerWidget {
  CoffeeCard({required this.coffee}) : super(key: ValueKey(coffee.id));

  final Coffee coffee;

  deleteCoffee(Coffee coffee, WidgetRef ref) {
    ref.read(coffeesProvider.notifier).removeByKey(coffee.id ?? -1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).colorScheme.primary)),
      leading: Icon(
        Icons.coffee,
        color: Theme.of(context).colorScheme.onPrimary,
        size: 36,
      ),
      key: coffee.id != null ? Key(coffee.id.toString()) : null,
      title: Hero(
        tag: coffee.id.toString(),
        child: Material(
          type: MaterialType.transparency,
          child: Text(coffee.name ?? '',
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
      subtitle: Text(coffee.brewery ?? '',
          style: Theme.of(context).textTheme.labelLarge),
      trailing: AppIconButton(
          icon: const Icon(Icons.close, size: 36),
          onPressed: () => deleteCoffee(coffee, ref)),
      tileColor: Theme.of(context).cardColor,
      onTap: () => openCoffeePage(context),
    );
  }

  void openCoffeePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CoffeePage(
                  coffee: coffee,
                )));
  }
}
