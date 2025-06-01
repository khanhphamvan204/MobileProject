import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/controllers/popular_product_controller.dart';
import 'package:food_ordering/controllers/product_controller.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<ProductController>().getProductList();
  }

  @override
  void initState() {
    super.initState();
    // _loadResources();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
    Timer(
      Duration(seconds: 3),
      () => Get.offAllNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: Dimensions.splashImg,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height20),
          Text(
            "Best choice for you!",
            style: TextStyle(
              fontFamily: 'GreatVibes',
              fontSize: Dimensions.font40,
              fontWeight:
                  FontWeight
                      .w300, // Matches the weight specified in pubspec.yaml
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
