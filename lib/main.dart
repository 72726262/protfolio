import 'package:flutter/material.dart';
import 'package:protfolio/_homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'برتفوليو مبدع',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF6A5ACD),
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
      ),
      home: Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
