import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/controllers/database/product_controller.dart';
import 'package:spa_ceylon/providers/cart_provider.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel>? _products;
  List<ProductModel>? get products => _products;

  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;

  Future<void> getProducts() async {
    _products = await ProductController().getProducts();
  }

  int _selectedProductQuantity = 1;
  int get selectedProductQuantity => _selectedProductQuantity;

  void incrementSelectedProductQuantity() {
    if (_selectedProductQuantity < _selectedProduct!.quantity) {
      _selectedProductQuantity++;
      notifyListeners();
    }
  }

  void decrementSelectedProductQuantity() {
    if (_selectedProductQuantity != 1) {
      _selectedProductQuantity--;
      notifyListeners();
    }
  }

  void setSelectedProductQuantity(int quantity) {
    _selectedProductQuantity = quantity;
    notifyListeners();
  }

  void addNewProduct(ProductModel product) {
    _products ?? [];
    _products!.add(product);
    notifyListeners();
  }

  void setSelectedProduct(ProductModel product, BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    _selectedProduct = product;
    _selectedProductQuantity = 1;

    if (cartProvider.isProductInCart(product.id)) {
      final cartItem = cartProvider.cartItems.firstWhere(
        (element) => element.product.id == product.id,
      );
      _selectedProductQuantity = cartItem.quantity;
    }

    notifyListeners();
  }
}
