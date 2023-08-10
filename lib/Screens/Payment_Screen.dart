import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement"),
        backgroundColor: Color(0xFFFD725A),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Écran de paiement",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ajoutez votre logique de traitement de paiement ici.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFD725A)),
              ),
              child: const Text(
                "Payer maintenant", // Texte du bouton "Pay Now"
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
