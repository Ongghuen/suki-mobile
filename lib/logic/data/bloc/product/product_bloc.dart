import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductList>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(ProductLoading());

        String apiUrl = "/api/products";
        var res = await CallApi().getData(apiUrl);
        var body = json.decode(res.body);
        final product = ProductModel.fromJson(body);

        if (res.statusCode == 200) {
          emit(ProductLoaded(product));
        }else{
          emit(ProductError("LOLOLOL ERROR"));
        }
      } catch (ex, trace) {
        print("$ex $trace");
      }
    });

    on<GetDetailedProductList>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(ProductLoading());

        String apiUrl = "/api/products";
        var res = await CallApi().getData(apiUrl);
        var body = json.decode(res.body);
        final product = ProductModel.fromJson(body);

        emit(ProductLoaded(product));
      } catch (ex, trace) {
        print("$ex $trace");
      }
    });
  }
}
