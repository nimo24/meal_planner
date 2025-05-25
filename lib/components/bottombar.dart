import 'package:flutter/material.dart';

BottomNavigationBar buildBottomBar() {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
    ],
  );
}
