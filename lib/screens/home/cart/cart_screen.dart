import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            title: Text('My Cart'),
            backgroundColor: Colors.black.withAlpha(100),
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(cartItem.product.images.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cartItem.product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade200,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartProvider.removeFromCart(index);
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.decrementItemQuantity(
                                          index,
                                          context,
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey.shade800,
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.grey.shade100,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Text(
                                        cartItem.quantity.toString(),
                                        style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.incrementItemQuantity(
                                          index,
                                          context,
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey.shade800,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey.shade100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  'LKR ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
