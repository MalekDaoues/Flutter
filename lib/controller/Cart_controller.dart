import 'package:get/get.dart';

class CartController extends GetxController {
  final selectedProducts = <Map<String, dynamic>>[].obs; // Liste observée des produits sélectionnés
  RxBool selectAll = false.obs; // Variable observable pour savoir si tous les produits sont sélectionnés
  RxDouble deliveryCost = 6.0.obs; // Coût de livraison observé
  RxDouble totalPayment = 0.0.obs; // Montant total du paiement observé
  RxBool select = false.obs; // Variable observable pour la sélection de produits individuels

  // Méthode pour ajouter un produit à la liste des produits sélectionnés
  void addToSellings(String name, double price) {
    selectedProducts.add({'name': name, 'price': price, 'selected': true});
    calculateTotalPayment();
    update();
  }

  // Méthode pour supprimer un produit de la liste des produits sélectionnés
  void removeFromSellings(String name, double price) {
    selectedProducts.removeWhere(
          (item) => item['name'] == name && item['price'] == price,
    );
    calculateTotalPayment();
    update();
  }

  // Méthode pour mettre à jour la sélection d'un produit spécifique
  void updateProductSelection(String name, bool selected) {
    for (Map<String, dynamic> product in selectedProducts) {
      if (product['name'] == name) {
        product['selected'] = selected;
        break;
      }
    }
    calculateTotalPayment();
    update();
  }

  // Méthode pour mettre à jour la sélection de tous les produits
  void updateProductSelectAll(bool selected) {
    for (Map<String, dynamic> product in selectedProducts) {
      product['selected'] = selected;
    }
    calculateTotalPayment();
    update();
  }

  // Vérifier si un produit spécifique est dans le panier
  bool isProductInSellings(String name, double price) {
    return selectedProducts.any((item) =>
    item['name'] == name && item['price'] == price);
  }

  // Vérifier si un produit spécifique est sélectionné dans le panier
  bool isSelected(String name, double price) {
    return selectedProducts.any((item) =>
    item['name'] == name && item['price'] == price && item['selected'] == true);
  }

  // Méthode pour calculer le montant total du paiement
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
      selectAll.value = allSelected;
    }

    double totalPaymentValue = sum + deliveryCost.value;
    totalPayment.value = selectedProducts.isEmpty ? 0.0 : totalPaymentValue;
    update();
  }

}
