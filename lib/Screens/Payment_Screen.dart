import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isOnlinePayment = false;
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Color(0xFFFD725A),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/paiement.webp'), // Replace with your image path
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Delivery Address",
              ),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Payment Method:"),
                SizedBox(width: 10),
                Column(
                  children:[
                    Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: isOnlinePayment,
                          onChanged: (newValue) {
                            setState(() {
                              isOnlinePayment = newValue as bool;
                            });
                          },
                        ),
                        Text("Pay on Delivery"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isOnlinePayment,
                          onChanged: (newValue) {
                            setState(() {
                              isOnlinePayment = newValue as bool;
                            });
                          },
                        ),
                        Text("Online Payment"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (isOnlinePayment)
              Column(
                children: [
                  Image.asset('images/cartes.webp'), // Replace with your image path
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Card Number",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add online payment processing logic here
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFd725A)),
                    ),
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            if (!isOnlinePayment && address.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // Add payment upon delivery processing logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFFFd725A)),
                ),
                child: Text(
                  "Pay on Delivery",
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
