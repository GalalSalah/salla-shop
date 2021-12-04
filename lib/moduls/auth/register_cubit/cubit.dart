import 'package:app_shop/models/login_model.dart';
import 'package:app_shop/moduls/auth/login_cubit/state.dart';
import 'package:app_shop/moduls/auth/register_cubit/state.dart';
import 'package:app_shop/shared/network/remote/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_shop/shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userRegister(
      {@required String email,
      @required String password,
      @required String name,
      @required String phone,

      }) {
    emit(ShopRegisterLoadingState());
    DioHelpers.postData(url: registerUrl, data: {
      'email': email,
      'password': password,
      'phone': phone,

      'name': name,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.message);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((onError) {
      print('hhh');
      print(onError);
      //
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
