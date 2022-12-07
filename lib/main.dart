import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/router/app_router.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[50], // navigation bar color
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
    // statusBarBrightness: Brightness.dark,//status bar brigtness
    // statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
    // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
      ),
      BlocProvider<ProductBloc>(
        create: (_) => ProductBloc(),
      ),
      BlocProvider<WishlistBloc>(
        create: (_) => WishlistBloc(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // check di AppRouter() "/" -- itu initial routenya kemana
      onGenerateRoute: AppRouter().onGenerateRoute,
    ),
  ));
}
