import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/controllers/database/product_controller.dart';
import 'package:spa_ceylon/controllers/storage/storage_controller.dart';
import 'package:spa_ceylon/data/categories.dart';
import 'package:spa_ceylon/models/category_model.dart';
import 'package:spa_ceylon/models/product_model.dart';
import 'package:spa_ceylon/providers/product_provider.dart';
import 'package:spa_ceylon/utils/custom_dialogs.dart';

class ProductAddProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  int _quantity = 1;
  int get quantity => _quantity;

  CategoryModel? _selectedCategory;
  CategoryModel? get selectedCategory => _selectedCategory;

  final List<File> _images = [];
  List<File> get images => _images;

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade900,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Category',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 35,
                  onSelectedItemChanged: (index) {
                    _selectedCategory = Categories.list[index];
                    notifyListeners();
                  },
                  children:
                      Categories.list
                          .map(
                            (e) => Text(
                              e.category,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 25,
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickProductImage({bool isFromCamera = false}) async {
    final pickedImage = await ImagePicker().pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      _images.add(File(pickedImage.path));
      notifyListeners();
    }
  }

  Future<void> startAddNewProduct(BuildContext context) async {
    if (_nameController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please add product name',
      );
    } else if (_priceController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please add product price',
      );
    } else if (_descriptionController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please add product description',
      );
    } else if (_selectedCategory == null) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please select product category',
      );
    } else if (_images.isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please add product images',
      );
    } else {
      List<String> imageUrls = [];
      EasyLoading.show();
      for (var file in _images) {
        final url = await StorageController().uploadImage(
          file,
          path: 'Product Images',
        );
        if (url != null) {
          imageUrls.add(url);
        }
      }
      String productId = DateTime.now().millisecondsSinceEpoch.toString();

      ProductModel product = ProductModel(
        name: _nameController.text.trim(),
        images: imageUrls,
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        quantity: _quantity,
        category: _selectedCategory!.id,
        id: productId,
      );
      final isSuccess = await ProductController().addNewProduct(product);
      EasyLoading.dismiss();
      if (isSuccess) {
        if (context.mounted) {
          Provider.of<ProductProvider>(
            context,
            listen: false,
          ).addNewProduct(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product Added'),
              backgroundColor: Colors.green,
            ),
          );
          clear();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          SnackBar(
            content: Text('Product Add Failed'),
            backgroundColor: Colors.red,
          );
        }
      }
      Logger().e(product.toJson());
    }
  }

  void clear() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _selectedCategory = null;
    _quantity = 1;
    _images.clear();
  }
}
