
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


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  int currentIndex = 0;
  final AuthController authController = Get.find<AuthController>();
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8FA),
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
                    labelText: "Find your product",
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
        child:Obx(() {
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
            homeController.changeSelectedIndex(index);
            currentIndex = index;
            pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
        currentIndex: currentIndex < 4 ? currentIndex: 3,
        backgroundColor: Colors.white,
        iconSize: 30,
        selectedItemColor: const Color(0xFFFD725A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
