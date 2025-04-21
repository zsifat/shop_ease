import 'package:ecommerce_app/core/bindings/app_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/home/presentation/views/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      initialBinding: AppBindings(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0
        )
      ),
      home: HomeScreen(),
    );
  }
}
