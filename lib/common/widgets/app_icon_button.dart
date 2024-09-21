import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({required this.icon, required this.onPressed, super.key});

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            iconColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.onPrimary,
        )),
        onPressed: () => onPressed(),
        icon: const Icon(Icons.close, size: 36));
  }
}
