import 'package:coffee_monitor/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({required Coffee coffee, super.key}) : _coffee = coffee;

  final Coffee _coffee;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Coffee Page', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                  transitionOnUserGestures: true,
                  tag: _coffee.id.toString(),
                  child: Text(_coffee.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 36))),
              Text(
                'Brewery: ${_coffee.brewery}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
