import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/models/user.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  // controllers
  final _nameController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void uploadImage() async {
    var auth = AuthBloc().state;
    if (auth is AuthLoaded) {
      ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        try {
          await CallApi().multiPartData('/api/user/upload',
              data: image.path, token: auth.userModel.token);
          context
              .read<AuthBloc>()
              .add(UserAuthUpdate("", auth.userModel.token));
        } catch (ex) {
          print("$ex");
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    var state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      var user = state.userModel.user!;
      _nameController.text = user.name!;
      _noTelpController.text = user.phone!;
      _emailController.text = user.email!;
      user.address == null
          ? _alamatController.text = ""
          : _alamatController.text = user.address!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthError) {
                showSnackbar(context, "${state.msg}");
              }
            }, builder: (context, state) {
              if (state is AuthLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(UserAuthLogout(state.userModel.token));
                      },
                    ),
                  ],
                );
              }
              return IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_left));
            }),
          ],
          backgroundColor: const Color(0xFFF8F9FA),
          elevation: 0),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoaded) {
                var user = state.userModel.user;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            uploadImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: Colors.grey,
                              height: 150,
                              width: 150,
                              child: user?.image == null
                                  ? Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : Image.network(
                                      "${apiUrlStorage}/${user?.image}",
                                      fit: BoxFit.fill,
                                      height: 80,
                                      width: 80,
                                      // Better way to load images from network flutter
                                      // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),

                        // sized box cuma buat margin, idk any alternatives
                        const SizedBox(
                          height: 20,
                        ),

                        // ini input text atau form
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nama Anda',
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // ini input text atau form
                        TextField(
                          controller: _noTelpController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nomer Telepon',
                          ),
                        ),
                        //
                        const SizedBox(
                          height: 10,
                        ),
                        //

                        // ini input text atau form
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // ini input text atau form
                        TextField(
                          controller: _alamatController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Alamat',
                          ),
                        ),

                        //
                        const SizedBox(
                          height: 10,
                        ),
                        //

                        //
                        const SizedBox(
                          height: 30,
                        ),

                        //
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: GestureDetector(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor: const Color(0xFF151515)),
                              child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (_, state) {
                                if (state is AuthRegistered) {
                                  Navigator.pop(context);
                                }
                              }, builder: (_, state) {
                                if (state is AuthLoading) {
                                  return const CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                    color: Colors.white,
                                  );
                                }
                                return const Text("UPDATE INFO AKUN",
                                    style: TextStyle(fontSize: 18));
                              }),
                              onPressed: () async {
                                var data = {
                                  "name": _nameController.text,
                                  "phone": "${_noTelpController.text.trim()}",
                                  "alamat": "${_alamatController.text}",
                                  "email": "${_emailController.text}",
                                };
                                if (_emailController.text == user!.email) {
                                  data.remove("email");
                                }
                                if (_noTelpController.text == user!.phone) {
                                  data.remove("phone");
                                }
                                context.read<AuthBloc>().add(UserAuthUpdate(
                                    data, state.userModel.token));
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return loading();
            },
          ),
        ),
      ),
    );
  }
}
