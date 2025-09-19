import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'pages/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brawl Stars - Meta de Troféus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}
