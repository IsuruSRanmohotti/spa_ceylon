import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/models/cart_model.dart';
import 'package:spa_ceylon/models/product_model.dart';
import 'package:spa_ceylon/providers/product_provider.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  void addToCart(CartModel cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

  int totalItemsInCart() {
    return _cartItems.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementItemQuantity(int index, BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    if (_cartItems[index].product.quantity > _cartItems[index].quantity) {
      _cartItems[index].quantity++;
    }

    if (productProvider.selectedProduct != null &&
        (_cartItems[index].product.id == productProvider.selectedProduct!.id)) {
      productProvider.setSelectedProductQuantity(_cartItems[index].quantity);
    }

    notifyListeners();
  }

  void decrementItemQuantity(int index, BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    if (_cartItems[index].quantity != 1) {
      _cartItems[index].quantity--;
    }

    if (productProvider.selectedProduct != null &&
        (_cartItems[index].product.id == productProvider.selectedProduct!.id)) {
      productProvider.setSelectedProductQuantity(_cartItems[index].quantity);
    }

    notifyListeners();
  }

  bool isProductInCart(String productId) {
    return _cartItems.any((element) => element.product.id == productId);
  }

  bool isProductQuantityChanged(String productId, int currentQuantity) {
    final cartModel = _cartItems.firstWhere(
      (element) => element.product.id == productId,
      orElse:
          () => CartModel(
            product: ProductModel(
              name: '',
              images: [],
              description: '',
              price: 0,
              quantity: 0,
              category: '',
              id: '',
            ),
            quantity: 0,
          ),
    );

    return cartModel.product.id == productId &&
        cartModel.quantity != currentQuantity;
  }

  void updateCart(String productId, int updatedQuantity) {
    int index = _cartItems.indexWhere(
      (element) => element.product.id == productId,
    );

    _cartItems[index].quantity = updatedQuantity;
    notifyListeners();
  }
}
