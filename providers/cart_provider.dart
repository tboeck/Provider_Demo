import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.fold(0, (total, item) => total + item.price);

  void addItem(Item item) {
    _items.add(item);
    notifyListeners(); // forward state changes
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
