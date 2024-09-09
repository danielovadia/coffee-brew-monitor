import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_monitor/components/coffee_card.dart';
import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/services/local_storage.dart';
import 'package:coffee_monitor/services/coffee_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.instance.init();

  CoffeeService coffeeService = CoffeeService.instance;
  await coffeeService.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  Future<List<Widget>> createCoffeeWidgets(coffees) async {
    List<Widget> coffeeWidgets = [];
    for (Coffee coffee in coffees) {
      coffeeWidgets.add(CoffeeCard(coffee: coffee));
    }
    return coffeeWidgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Coffee> coffees = ref.watch(coffeesProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            CoffeeService.instance.coffees.map((e) => e.name).toString(),
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: FutureBuilder(
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
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(coffeesProvider.notifier)
                .saveCoffee(Coffee(name: 'Mocha', brewery: 'Cafe Coffee Day'));
          },
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
