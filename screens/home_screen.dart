import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      Item('Kaffee', 3),
      Item('Red Bull', 4),
      Item('Flaming Hot Cheetos', 2),
      Item('Glühwein', 5),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Einkaufsliste',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  item.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  '€${item.price}',
                  style: const TextStyle(fontSize: 18, color: Colors.teal),
                ),
                onTap: () {
                  context.read<CartProvider>().addItem(item); // read value
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${item.name} wurde hinzugefügt!',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
