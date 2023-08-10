import 'package:e_shop/Widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DataBase/auth_controller.dart';
import 'controller/Cart_controller.dart';
import 'controller/Favorite_controller.dart';
import 'controller/home_ controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DataBase/firebase_options.dart';


// Fonction principale asynchrone pour lancer l'application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // Lance l'application en créant une instance de MyApp
}

// Classe représentant l'application
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        // Initialisation des contrôleurs et mise en place des dépendances
        Get.put(FavoritesController());
        Get.put(HomeController());
        Get.put(CartController());
        Get.put(AuthController());
      }),
      debugShowCheckedModeBanner: false, // Désactive la bannière de débogage
      theme: ThemeData(scaffoldBackgroundColor: Colors.white), // Thème global de l'application
      home: Dashboard(), // Affiche le tableau de bord de l'application
    );
  }
}