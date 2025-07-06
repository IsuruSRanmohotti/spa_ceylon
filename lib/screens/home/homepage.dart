import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/controllers/auth/auth_controller.dart';
import 'package:spa_ceylon/providers/user_provider.dart';
import 'package:spa_ceylon/utils/color_utils.dart';

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
          body: Column(
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
                                onLongPress: () {
                                  AuthController().signOutUser();
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
            ],
          ),
        );
      },
    );
  }
}
