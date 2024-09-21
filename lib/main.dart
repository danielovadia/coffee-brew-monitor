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
  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainApp(),
    theme: ThemeData(
      fontFamily: GoogleFonts.lato().fontFamily,
      scaffoldBackgroundColor: const Color.fromARGB(255, 59, 59, 71),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 59, 59, 71),
        secondary: Color.fromARGB(255, 238, 236, 233),
        onPrimary: Color.fromARGB(255, 238, 236, 233),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white70, letterSpacing: 1.5),
          labelLarge: TextStyle(color: Colors.white70, letterSpacing: 1.2)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 59, 59, 71),
      ),
      cardColor: const Color.fromARGB(255, 59, 59, 71),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.orange[300]),
    ),
  )));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Coffee> coffees = ref.watch(coffeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coffee Monitor",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: CoffeeCardsListView(coffees: coffees),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const AddCoffeeDialog());
        },
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
