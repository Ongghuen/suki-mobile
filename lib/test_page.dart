import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/data/cubits/counter_cubit.dart';
import 'package:mobile/pages/screens/login_page.dart';

void main() {
  runApp(const TestPage());
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TestPageView(title: "Lmao pisan kang")
        // home: BlocProvider(
        //     create: (context) => CounterCubit(),
        //     child: const MyHomePage(title: "Lmao pisan kang")),
        );
  }
}

class TestPageView extends StatefulWidget {
  const TestPageView({super.key, required this.title});
  final String title;

  @override
  State<TestPageView> createState() => _TestPageViewState();
}

class _TestPageViewState extends State<TestPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              )),
        ),
      ),
      body: SafeArea(
          child: Center(
        //
        child: BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                  if (state.counterValue > 7) {
                    return Text(
                      "ITS OVER ${state.counterValue}!!!",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 24)),
                    );
                  }
                  if (state.counterValue <= 0) {
                    return Text(
                      "Hello World",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 24)),
                    );
                  }
                  return Text(
                    "uwaw ${state.counterValue}",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 24)),
                  );
                }),

                //
                const SizedBox(
                  height: 40,
                ),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87),
                        onPressed: () =>
                            BlocProvider.of<CounterCubit>(context).decrement(),
                        child: const Icon(Icons.remove)),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87),
                        onPressed: () =>
                            BlocProvider.of<CounterCubit>(context).increment(),
                        child: const Icon(Icons.add)),
                  ],
                )
              ],
            );
          }),
        ),
      )),
    );
  }
}
