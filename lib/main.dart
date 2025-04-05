import 'package:flutter/material.dart';
import 'package:food_ordering/pages/food/popular_food_detail.dart';
import 'package:get/get.dart';
import 'package:food_ordering/pages/home/main_food_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Food App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: PopularFoodDetail(),
    );
  }
}
