import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppb_proyek_akhir/firebase_options.dart';
import 'package:ppb_proyek_akhir/home_page.dart';
import 'package:ppb_proyek_akhir/login_page.dart';
import 'package:ppb_proyek_akhir/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.dark,
      title: 'Astral Express Ticket App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
      // home: const LoginPage(),
    );
  }
}
