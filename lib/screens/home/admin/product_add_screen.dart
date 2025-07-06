import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/components/buttons/custom_buton.dart';
import 'package:spa_ceylon/components/text_fields/custom_textfield.dart';
import 'package:spa_ceylon/providers/add_product_provider.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Add New Product', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Consumer<ProductAddProvider>(
        builder: (context, productAddProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Product Name',
                        controller: productAddProvider.nameController,
                      ),
                      CustomTextField(
                        label: 'Price',
                        textInputType: TextInputType.number,
                        controller: productAddProvider.priceController,
                      ),
                      CustomTextField(
                        label: 'Description',
                        maxLines: 3,
                        controller: productAddProvider.descriptionController,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Select Category',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          productAddProvider.showCategoryPicker(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  productAddProvider.selectedCategory == null
                                      ? 'Select Category'
                                      : productAddProvider
                                          .selectedCategory!
                                          .category,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    productAddProvider.decrementQuantity();
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.grey.shade700,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    productAddProvider.quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productAddProvider.incrementQuantity();
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.grey.shade700,
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Add Product Images',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  productAddProvider.pickProductImage(
                                    isFromCamera: true,
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade700,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  productAddProvider.pickProductImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade700,
                                  child: Icon(Icons.photo, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Wrap(
                        children:
                            productAddProvider.images
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: FileImage(e),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: CustomButton(
                      onTap: () {
                        productAddProvider.startAddNewProduct(context);
                      },
                      text: 'Add Product',
                      bgColor: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
