import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/screens/launch_screen.dart';
import 'package:quiz_app/screens/login_screen.dart';
import 'package:quiz_app/screens/history_screen.dart';
import 'package:quiz_app/screens/questions_screen.dart';
import 'package:quiz_app/screens/score_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: '/launch_screen',
            routes: {
              '/launch_screen': (context) => const LaunchScreen(),
              '/login_screen': (context) => const LoginScreen(),
            '/questions_screen': (context) =>  const  QuestionsScreen(),
            '/score_screen': (context) => const ScoreScreen(),
              '/history_screen': (context) => const HistoryScreen(),
            },
          );
        });
  }
}
