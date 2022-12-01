import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(SearchPage());
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(16)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Cari Barang atau Perabotan',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {
                    // search disini
                  },
                ),
                fillColor: const Color(0xFFF8F9FA),
                filled: true),
          ),
        ),
      ),
    );
  }
}
