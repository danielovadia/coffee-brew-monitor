import 'package:coffee_monitor/components/add_coffee_dialog.dart';
import 'package:coffee_monitor/components/coffee_cards_list_view.dart';
import 'package:coffee_monitor/providers/coffees_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_monitor/models/coffee.dart';
import 'package:coffee_monitor/services/local_storage.dart';
import 'package:coffee_monitor/services/coffee_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.instance.init();

  await CoffeeService.instance.init();
  runApp(const ProviderScope(
      child: MaterialApp(
    home: MainApp(),
  )));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Coffee> coffees = ref.watch(coffeesProvider);

    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Coffee Monitor",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: CoffeeCardsListView(coffees: coffees),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => const AddCoffeeDialog());
          },
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
