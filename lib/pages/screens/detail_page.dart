import 'package:flutter/material.dart';
import 'package:mobile/pages/screens/checkout_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "hehe",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),

      //
      body: Column(
        children: [
          SizedBox(
            height: height / 1.7,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset("assets/images/kursikematian.png"),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Kursi RGB",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            MaterialButton(
                              minWidth: 10,
                              onPressed: () {},
                              child: const Text(
                                '+',
                              ),
                            ),
                            const Text(
                              '1',
                            ),
                            MaterialButton(
                              minWidth: 10,
                              onPressed: () {},
                              child: const Text(
                                '-',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Ini adalah produk hahahahahaha lmao banget xixixi uhuyyyy",
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: 'Total Price\n',
                        ),
                        TextSpan(
                          text: "Hahay",
                        ),
                      ]),
                    ),
                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow[500],
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckoutPage()));
                        },
                        child: const Center(
                          child: Text(
                            'Buy Now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
