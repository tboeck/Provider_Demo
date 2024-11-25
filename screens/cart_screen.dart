import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warenkorb (${cart.items.length})',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cart.items.isEmpty
                  ? const Center(
                child: Text(
                  'Der Warenkorb ist leer!',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              )
                  : ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        item.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 28, color: Colors.red),
                        onPressed: () {
                          context.read<CartProvider>().removeItem(item); // read value
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item.name} wurde entfernt!',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Gesamtkosten: €${cart.totalPrice}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
