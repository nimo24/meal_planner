import 'package:flutter/material.dart';

Drawer buildSidebar() {
  return Drawer(
    child: Column(
      children: const [
        DrawerHeader(child: Text("Menu")),
        ListTile(title: Text("All")),
        ListTile(title: Text("Entree")),
        ListTile(title: Text("Plat")),
        ListTile(title: Text("Dessert")),
      ],
    ),
  );
}
