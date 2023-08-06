import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  String selectedCategory = 'All';
  String cartProductName = '';
  double cartProductPrice = 0.0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> filteredProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getCartProduct(String name, double price) {
    cartProductName = name;
    cartProductPrice = price;
    update();
  }

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}

