import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction_custom/transaction_custom_bloc.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

class CustomRequestPage extends StatefulWidget {
  const CustomRequestPage({Key? key}) : super(key: key);

  @override
  State<CustomRequestPage> createState() => _CustomRequestPageState();
}

const List<String> jenisList = <String>[
  'Kursi',
  'Meja',
  'Pagar',
  'Pintu',
  'Rak'
];

const List<String> bahanList = <String>[
  'Kayu Jati',
  'Kayu Mahoni',
  'Besi',
  'Kaca',
  'Alumunium'
];

class _CustomRequestPageState extends State<CustomRequestPage> {
  String jenisValue = jenisList.first;
  String bahanValue = bahanList.first;

  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController _alamat = TextEditingController();

  bottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Form(
          child: SingleChildScrollView(
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        // ini input text atau form
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          controller: _alamat,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Alamat '
                                'Anda',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            var auth = context.read<AuthBloc>().state;
                            if (auth is AuthLoaded) {
                              var data = {
                                "alamat": _alamat.text,
                              };
                              if (_alamat.text == auth.userModel.user!.email) {
                                data.remove("alamat");
                              }
                              context.read<AuthBloc>().add(
                                  UserAuthUpdate(data, auth.userModel.token));
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'UPDATE ALAMAT',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize:
                                          getAdaptiveTextSize(context, 18),
                                      fontWeight: FontWeight.bold),
                                ),
                                // pay now
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void restartBlocs() {
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      context.read<AuthBloc>().add(UserAuthCheckToken(state.userModel.token));
      context
          .read<TransactionCustomBloc>()
          .add(GetTransactionCustomLists(state.userModel.token.toString()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    restartBlocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<TransactionCustomBloc, TransactionCustomState>(
      listener: (context, state) {
        if (state is TransactionCustomError) {
          showSnackbar(context, "${state.msg}");
          restartBlocs();
        } else if (state is TransactionCustomSuccess) {
          showSnackbar(context, "Berhasil! Check List Request Customs Anda!");
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Let's order fresh items for you
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_outlined)),
                      Container(
                        width: size.width * 0.7,
                        child: Text(
                          "Request Custom Form",
                          style: GoogleFonts.montserrat(
                            fontSize: getAdaptiveTextSize(context, 20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // judul request
                      TextField(
                        controller: judul,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          labelText: 'Judul Custom',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "* judul dari furnitur yang ingin anda ajukan sebagai "
                        "request",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // jenis custom
                      Container(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: jenisValue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                jenisValue = value!;
                              });
                            },
                            items: jenisList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(child: Text(value)),
                              );
                            }).toList(),
                          ),
                        ),
                        decoration: outlineBasic(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("* jenis furnitur yang anda inginkan",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w200,
                          )),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //

                      // bahan
                      Container(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: bahanValue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                bahanValue = value!;
                              });
                            },
                            items: bahanList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(child: Text(value)),
                              );
                            }).toList(),
                          ),
                        ),
                        decoration: outlineBasic(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("* bahan furnitur yang akan digunakan",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w200)),
                      const SizedBox(
                        height: 20,
                      ),

                      // deskripsi
                      TextField(
                        controller: deskripsi,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          labelText: 'Deskripsi',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "* isi deskripsi tambahan apa yang anda inginkan "
                          "dengan "
                          "furnitur custom"
                          " yang telah anda isi (contoh: ukuran, warna, dsb)",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w200,
                          )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                // button ajukan request
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<TransactionCustomBloc,
                            TransactionCustomState>(
                          builder: (context, state) {
                            if (state is TransactionCustomLoading) {
                              return CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            return BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoaded) {
                                  var auth = state.userModel.user!;
                                  return InkWell(
                                    onTap: () {
                                      if (auth.address == null) {
                                        bottomSheet(context);
                                      } else {
                                        var data = {
                                          "name": judul.text,
                                          "jenis_custom": jenisValue,
                                          "bahan": bahanValue,
                                          "desc": deskripsi.text
                                        };
                                        final state = context.read<AuthBloc>().state;
                                        if (state is AuthLoaded) {
                                          context.read<TransactionCustomBloc>().add(
                                              RequestTransactionCustom(
                                                  data, state.userModel.token));
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${auth.address == null ? "GANT"
                                                "I ALAMAT" : "AJUKAN "
                                                "PESANAN"}',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: getAdaptiveTextSize(
                                                    context, 18),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // pay now
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            );
                          },
                        ),
                        // pay now
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
