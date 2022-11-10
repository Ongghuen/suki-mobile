import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/pages/screens/login_page.dart';
import 'package:mobile/pages/utils/components/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212529),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            showSnackbar(context, "INFO: cek logout");
            },
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --

            // container
            SizedBox(
              height: size.height * 0.2,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.2 - 27,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xFF212529),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hi, Vinda",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24),
                                    )),
                                Text("Welcome to Suki",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              ]),

                          // kanan
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // text field buat search
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(16)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              hintText: 'Cari Barang atau Perabotan',
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              fillColor: const Color(0xFFF8F9FA),
                              filled: true),
                        ),
                      ))
                ],
              ),
            ),

          SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Kategori",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),
            // --
          ]),
    );
  }
}
