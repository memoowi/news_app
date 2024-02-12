import 'package:flutter/material.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeadlinesProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          // '/news': (context) => MainScreen(),
        },
      ),
    );
  }
}
