import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/components/buttons/custom_buton.dart';
import 'package:spa_ceylon/data/categories.dart';
import 'package:spa_ceylon/models/cart_model.dart';
import 'package:spa_ceylon/providers/cart_provider.dart';
import 'package:spa_ceylon/providers/product_provider.dart';
import 'package:spa_ceylon/screens/home/cart/cart_screen.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer2<ProductProvider, CartProvider>(
      builder: (context, productProvider, cartProvider, child) {
        final product = productProvider.selectedProduct!;
        return Scaffold(
          backgroundColor: Colors.grey.shade900,
          bottomNavigationBar: Container(
            color: Colors.grey.shade900,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text:
                      cartProvider.isProductQuantityChanged(
                            product.id,
                            productProvider.selectedProductQuantity,
                          )
                          ? 'Update Cart'
                          : cartProvider.isProductInCart(product.id)
                          ? 'View Cart'
                          : 'Add To Cart',
                  onTap: () {
                    if (cartProvider.isProductQuantityChanged(
                      product.id,
                      productProvider.selectedProductQuantity,
                    )) {
                      cartProvider.updateCart(
                        product.id,
                        productProvider.selectedProductQuantity,
                      );
                    } else if (cartProvider.isProductInCart(product.id)) {
                      NavigationManager.goTo(context, CartScreen());
                    } else {
                      cartProvider.addToCart(
                        CartModel(
                          product: product,
                          quantity: productProvider.selectedProductQuantity,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                      selectedImage == null
                          ? product.images.first
                          : selectedImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SafeArea(
                        child: BackButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black.withAlpha(80),
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              product.images.map((url) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImage = url;
                                      });
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                        ),
                                        border: Border.all(
                                          color:
                                              selectedImage == url
                                                  ? Colors.blue
                                                  : Colors.grey,
                                          width: selectedImage == url ? 3 : 1,
                                        ),
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                    if (cartProvider.cartItems.isNotEmpty)
                      Align(
                        alignment: Alignment.topRight,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                NavigationManager.goTo(context, CartScreen());
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withAlpha(70),
                                child: Badge.count(
                                  count: cartProvider.totalItemsInCart(),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            Categories.findCategoryById(
                              product.category,
                            ).category,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          'LKR ${product.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 16,
                              ),
                            ),
                            if (product.quantity <= 5)
                              Text(
                                'Only ${product.quantity} Items Left',
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                productProvider
                                    .decrementSelectedProductQuantity();
                              },
                              child: CircleAvatar(
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
                                productProvider.selectedProductQuantity
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                productProvider
                                    .incrementSelectedProductQuantity();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
