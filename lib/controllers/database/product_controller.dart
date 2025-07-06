import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:spa_ceylon/models/product_model.dart';

class ProductController {
  final productCollection = FirebaseFirestore.instance.collection('Products');

  Future<bool> addNewProduct(ProductModel product) async {
    try {
      await productCollection.doc(product.id).set(product.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final data = await productCollection.get();
      final docs = data.docs;
      List<ProductModel> products =
          docs
              .map((document) => ProductModel.fromJson(document.data()))
              .toList();
      Logger().e(products.length);
      return products;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
