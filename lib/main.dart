import 'package:e_shop/Widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DataBase/auth_controller.dart';
import 'controller/Cart_controller.dart';
import 'controller/Favorite_controller.dart';
import 'controller/home_ controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DataBase/firebase_options.dart';


  Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(FavoritesController());
        Get.put(HomeController());
        Get.put(CartController());
        Get.put(AuthController());


      }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,),
      home: Dashboard(),


    );
  }
}