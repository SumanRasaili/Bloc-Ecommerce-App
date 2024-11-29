import 'package:flutter/material.dart';
import 'package:oriflamenepal/presentation/presentation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oriflame Nepal',
      theme: ThemeData(
        primaryColor: const Color(0xff6688bb),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductDetailPage(),
    );
  }
}
