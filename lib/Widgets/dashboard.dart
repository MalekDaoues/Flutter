
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../DataBase/auth_controller.dart';
import '../Screens/Favoris_screen.dart';
import '../Screens/Profile_page.dart';
import '../Screens/home_screen.dart';
import '../Screens/cart_screen.dart';
import '../Screens/login_screen.dart';
import '../controller/Cart_controller.dart';
import '../controller/home_ controller.dart';


// Classe représentant le tableau de bord de l'application
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HomeController homeController = Get.put(HomeController()); // Contrôleur de la page d'accueil via Get.put
  final CartController cartController = Get.put(CartController()); // Contrôleur du panier via Get.put
  int currentIndex = 0; // Index de l'onglet actuellement sélectionné
  final AuthController authController = Get.find<AuthController>(); // Contrôleur d'authentification via Get.find
  final PageController pageController = PageController(initialPage: 0); // Contrôleur de page pour la navigation

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8FA), // Couleur de fond de la barre d'applications
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Trouver votre produit",
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Color(0xFFFD725A),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: Color(0xFFFD725A),
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: KeyboardDismisser(
        child: Obx(() {
          return PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              HomePage(),
              CartScreen(
                homeController.cartProductName,
                homeController.cartProductPrice,
              ),
              FavoritesScreen(),
              authController.isLoggedIn.value ? ProfilePage() : LoginScreen(),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            homeController.changeSelectedIndex(index); // Mise à jour de l'index sélectionné
            currentIndex = index;
            // Animation de la transition vers la page sélectionnée
            pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
        currentIndex: currentIndex < 4 ? currentIndex : 3, // Index de l'onglet actuellement sélectionné
        backgroundColor: Colors.white, // Couleur de fond de la barre de navigation
        iconSize: 30, // Taille des icônes
        selectedItemColor: const Color(0xFFFD725A), // Couleur de l'icône sélectionnée
        unselectedItemColor: Colors.grey, // Couleur de l'icône non sélectionnée
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), // Onglet Accueil
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''), // Onglet Panier
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''), // Onglet Favoris
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''), // Onglet Profil
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked, // Position du bouton d'action flottant
    );
  }
}