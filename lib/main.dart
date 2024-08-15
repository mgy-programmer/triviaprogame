import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triviapro/view/pages/splash_screen.dart';
import 'package:triviapro/model_view/provider/question_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuestionProvider>(create: (context) => QuestionProvider()),
      ],
      child: MaterialApp(
        title: 'Trivia_Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
