import 'package:get/get.dart';

class CartController extends GetxController {
  final selectedProducts = <Map<String, dynamic>>[].obs;
  RxBool selectAll = false.obs;
  RxDouble deliveryCost = 6.0.obs;
  RxDouble totalPayment = 0.0.obs;
  RxBool select = false.obs;


  void addToSellings(String name, double price) {
    selectedProducts.add({'name': name, 'price': price, 'selected': true});
    calculateTotalPayment();
    update();
  }


  void removeFromSellings(String name, double price) {
    selectedProducts.removeWhere(
          (item) => item['name'] == name && item['price'] == price,
    );
    calculateTotalPayment();
    update();
  }

  void updateProductSelection(String name, bool selected) {
    for (Map<String, dynamic> product in selectedProducts) {
      if (product['name'] == name) {
        product['selected'] = selected;
        break;
      }
    }
    bool allSelected = selectedProducts.every((product) => product['selected']);
    selectAll.value = allSelected;
    calculateTotalPayment();
    updateProductSelectAll(selected);
    update();
  }

  void updateProductSelectAll( bool selected) {

    for (Map<String, dynamic> product in selectedProducts) {
      product['selected'] = selected;
    }
    calculateTotalPayment();
    update();
  }

  bool isProductInSellings(String name, double price) {
    return selectedProducts.any((item) =>
    item['name'] == name && item['price'] == price);
  }
  bool isSelected(String name, double price) {
    return selectedProducts.any((item) =>
    item['name'] == name && item['price'] == price && item['selected']==true);
  }
  void calculateTotalPayment() {
    double sum = 0.0;
    bool allSelected = true;

    for (Map<String, dynamic> product in selectedProducts) {
      bool isSelected = product['selected'] ?? false;

      if (!isSelected) {
        allSelected = false;
      } else {
        double productPrice = product['price'];
        sum += productPrice;
      }
    }
    selectAll.value = allSelected;
    double totalPaymentValue = sum + deliveryCost.value;
    totalPayment.value = selectedProducts.isEmpty ? 0.0 : totalPaymentValue;
  }
}