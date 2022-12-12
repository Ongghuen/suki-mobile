import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionMenungguPembayaranPage extends StatefulWidget {
  const TransactionMenungguPembayaranPage({Key? key}) : super(key: key);

  @override
  State<TransactionMenungguPembayaranPage> createState() => _TransactionMenungguPembayaranPageState();
}

class _TransactionMenungguPembayaranPageState extends State<TransactionMenungguPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      "Menunggu Pembayaran",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),

                // transaction card
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // pertama
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.shopping_bag),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Belanja"),
                                      Text(
                                        "anggep-ini-tanggal",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text("Belum Bayar"),
                            ],
                          ),

                          // divider buat underline item
                          Divider(
                            color: Colors.black,
                          ),

                          // item yang dibeli
                          Row(
                            children: [
                              // image item
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.red,
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.inventory,
                                  ),
                                ),
                              ),

                              // spacing
                              SizedBox(
                                width: 10,
                              ),

                              // nama barang
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "We on something different",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("1 barang"),
                                ],
                              ),
                            ],
                          ),

                          // spacing
                          SizedBox(
                            height: 10,
                          ),

                          // kasi keterangan kalo ada barang lain
                          Text("+6 produk lainnya"),

                          // spacing
                          SizedBox(
                            height: 10,
                          ),

                          // kolom 3
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // total belanja
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Belanja:"),
                                  Text(
                                    "Rp mahaldahpokonya",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              // button detail
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Detail"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: outlineBasic(),
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
