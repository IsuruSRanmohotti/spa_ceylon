import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/controllers/auth/auth_controller.dart';
import 'package:spa_ceylon/providers/product_provider.dart';
import 'package:spa_ceylon/providers/user_provider.dart';
import 'package:spa_ceylon/screens/home/admin/product_add_screen.dart';
import 'package:spa_ceylon/screens/home/product_view/product_view.dart';
import 'package:spa_ceylon/utils/color_utils.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          backgroundColor: ColorUtils.scaffoldColor,
          body: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        image: DecorationImage(
                          image: AssetImage('assets/images/home_bg.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withAlpha(80),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withAlpha(100),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey.shade800,
                                      child: Icon(
                                        Icons.menu_rounded,
                                        color: Colors.white,
                                      ),
                                    ),

                                    Spacer(),
                                    Text(
                                      'Spa Ceylon',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        NavigationManager.goTo(
                                          context,
                                          ProductAddScreen(),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        child: Icon(
                                          Icons.admin_panel_settings,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    GestureDetector(
                                      onLongPress: () {
                                        AuthController().signOutUser(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello,',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                    Text(
                                      userProvider.currentUser!.name,
                                      style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future:
                                productProvider.products == null
                                    ? productProvider.getProducts()
                                    : Future.value(productProvider.products),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 0.7,
                                      ),
                                  itemCount: productProvider.products!.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        productProvider.products![index];
                                    return GestureDetector(
                                      onTap: () {
                                        productProvider.setSelectedProduct(
                                          product,
                                          context,
                                        );
                                        NavigationManager.goTo(
                                          context,
                                          ProductView(),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: (size.width / 2) - 40,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    product.images.first,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                  ),
                                              child: Text(
                                                product.name,
                                                style: TextStyle(
                                                  color: Colors.grey.shade200,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              'LKR ${product.price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Colors.amber.shade700,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
