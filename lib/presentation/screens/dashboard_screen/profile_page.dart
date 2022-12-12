import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/presentation/utils/default.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController names = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Menu",
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: 75,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/12584890?v=4"),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Raihan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text("0821210921"),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/detail-profile');
                        },
                        icon: Icon(Icons.settings_outlined))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chair_outlined,
                                size: 32,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Request Custom Furniture",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Anda dapat meminta furnitur custom "
                                        "sesuai keinginan anda."),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    decoration: outlineBasic(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/transaction');
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Row(
                              children: [
                                Text("Daftar Transaksi",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          decoration: outlineBasic(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/cart");
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Ke Keranjang",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          decoration: outlineBasic(),
                        ),
                      ),
                    ],
                  ),
                ),

                // aktivitas saya
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text("Aktivitas Saya",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),

                // transaksi
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Transaksi",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),

                // wishlist
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Wishlist",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),

                // customs
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.chair_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Customs",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),

                // semua kategori
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text("Kategori Umum",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),

                // kursi
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.chair_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Kursi",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),

                // Meja
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.table_bar_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Meja",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),

                // pusat bantuan
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text("Pusat Bantuan",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),

                // Idk
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.support_agent_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Whatsapp Admin",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
