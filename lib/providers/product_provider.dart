import 'package:flutter/material.dart';
import 'package:spa_ceylon/controllers/database/product_controller.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel>? _products;
  List<ProductModel>? get products => _products;

  Future<void> getProducts() async {
    _products = await ProductController().getProducts();
  }
}
