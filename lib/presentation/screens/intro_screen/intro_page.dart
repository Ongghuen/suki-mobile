import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mobile/presentation/screens/auth_screen/login_page.dart';
import 'package:mobile/presentation/screens/intro_screen/pages/intro_one_page.dart';
import 'package:mobile/presentation/screens/intro_screen/pages/intro_three_page.dart';
import 'package:mobile/presentation/screens/intro_screen/pages/intro_two_page.dart';
import 'package:mobile/presentation/utils/default.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _page = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          scrollBehavior: NoGlow(),
          onPageChanged: (index) {
            setState(() {
              lastPage = (index == 2);
            });
          },
          controller: _page,
          children: [
            IntroOnePage(),
            IntroTwoPage(),
            IntroThreePage(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _page.jumpToPage(2);
                  },
                  child: Text(
                    "Lewati",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _page,
                  count: 3,
                  effect: SwapEffect(
                      type: SwapType.yRotation,
                      activeDotColor: Colors.black,
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.black12),
                ),
                GestureDetector(
                  onTap: () async {
                    if (lastPage) {
                      var box = await Hive.box('utils');
                      box.put("intro", true);

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      _page.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Text(
                    lastPage ? "Selesai" : "Lanjut",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
