import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/Product_card.dart';
import '../controller/Cart_controller.dart';
import '../controller/home_ controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Contrôleur pour la gestion de la page d'accueil
  final HomeController homeController = Get.put(HomeController());
  // Contrôleur pour la gestion du panier
  final CartController cartController = Get.put(CartController());
  // Instance de Firebase Firestore pour interagir avec la base de données
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Catégorie actuellement sélectionnée
  String currentCategory = 'All';

  // Widget pour afficher les produits en fonction de la catégorie sélectionnée
  Widget buildCategoryWidget(String categoryId) {
    Stream<QuerySnapshot<Map<String, dynamic>>> productStream;
    // Vérifie si la catégorie sélectionnée est "All"
    if (categoryId == 'All') {
      // Récupère tous les produits depuis Firestore
      productStream = firestore.collection('products').snapshots();
    } else {
      // Récupère les produits en fonction de la catégorie sélectionnée depuis Firestore
      productStream =
          firestore.collection('products').where('id', isEqualTo: categoryId).snapshots();
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: productStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erreur lors du chargement des données'),
          );
        } else {
          // Données récupérées avec succès
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data!.docs;
          return GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width - 30 - 15) / (2 * 290).toDouble(),
              mainAxisSpacing: 45,
              crossAxisSpacing: 15,
            ),
            itemCount: documents.length,
            itemBuilder: (_, i) {
              final product = documents[i].data();
              return ProductCard(
                product['name'],
                product['price'].toDouble(),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image en haut de la page
            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "images/3.jpg",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Liste défilante de catégories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    // Affiche les catégories depuis Firestore
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: firestore.collection('Category').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Erreur lors du chargement des catégories'),
                          );
                        } else {
                          final List<QueryDocumentSnapshot<Map<String, dynamic>>> categories =
                              snapshot.data!.docs;
                          return Row(
                            children: [
                              for (final category in categories)
                                GestureDetector(
                                  onTap: () {
                                    // Met à jour la catégorie actuellement sélectionnée
                                    setState(() {
                                      currentCategory = category['id'];
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: category['id'] == currentCategory
                                          ? const Color(0xFFFD725A)
                                          : const Color(0xFFF7F8FA),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      category['name'], // Nom de la catégorie
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: category['id'] == currentCategory
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Grille de produits en fonction de la catégorie sélectionnée
            Expanded(
              child: buildCategoryWidget(currentCategory),
            ),
          ],
        ),
      ),
    );
  }
}
