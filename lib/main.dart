import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_firebase/Pages/DemoPage.dart';
import 'package:music_firebase/Pages/SplaceScreen.dart';
import 'package:music_firebase/config/Theme.dart';
import 'package:music_firebase/firebase_options.dart';
import 'package:music_firebase/providers/cancionesList_provider.dart';
import 'package:music_firebase/providers/cantantes_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: darkTheme,
      home: SplaceScreen(),
    );
  }
}
*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CantantesProvider>(
          create: (context) => CantantesProvider(),
        ),
        ChangeNotifierProvider<CancionesListProvider>(
          create: (context) => CancionesListProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Music Player',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const SplaceScreen(),
      ),
    );
  }
}
