import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  const MenuItemWidget({
    required this.text,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(color: Color(0xFF4F4F4F), fontSize: 18),
      ),
    );
  }
}
