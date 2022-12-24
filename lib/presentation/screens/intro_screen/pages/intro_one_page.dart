import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/presentation/utils/default.dart';
import 'package:lottie/lottie.dart';

class IntroOnePage extends StatelessWidget {
  const IntroOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.2),
      child: Column(
        children: [
          Expanded(child: Lottie.asset('assets/lottie/online_shopping.json')),

          // text column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Column(
              children: [
                Text(
                  "Lihat dan Beli Perabotan secara Online",
                  style: GoogleFonts.montserrat(
                      fontSize: getAdaptiveTextSize(context, 20),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.03,),
                Text(
                  "Anda dapat melihat beberapa produk-produk dari kami, "
                  "jika anda tertarik silahkan beli secara online",
                  style: GoogleFonts.montserrat(
                      fontSize: getAdaptiveTextSize(context, 14),
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
