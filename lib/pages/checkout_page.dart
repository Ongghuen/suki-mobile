import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          padding: const EdgeInsets.all(4),
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Image.asset("assets/images/kursikematian.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Kursi Hantu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.grey[600],
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
                    )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              color: Colors.grey[400],
              child: const Center(child: Text('Item ini')),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              color: Colors.grey[500],
              child: const Center(child: Text('Item itu')),
            ),
          ],
        ),
      ),
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
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[500],
                foregroundColor: Colors.black),
            child: const Text(
              "Checkout hahay",
            ),
          ),
        ),
      ),
    );
  }
}
