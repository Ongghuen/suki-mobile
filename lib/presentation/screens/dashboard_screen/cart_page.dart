import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(CartPage());
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Let's order fresh items for you
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Keranjang",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // list view of cart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        // leading: Image.asset(
                        //   // value.cartItems[index][2],
                        //   "coba",
                        //   height: 36,
                        // ),
                        title: Text(
                          // value.cartItems[index][0],
                          "coba",
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "coba",
                          // '\$' + value.cartItems[index][1],
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () => print("lol")
                            // Provider.of<CartModel>(context, listen: false)
                            // .removeItemFromCart(index),
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // total amount + pay now

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Harga',
                        style: TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 8),
                      // total price
                      Text(
                        // '\Rp.${value.calculateTotal()}',
                        'Rp.10.000 hahahay',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // pay now
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Text(
                          'Bayar',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
