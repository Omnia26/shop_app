// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print

import 'package:api_projects/shop_app/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shared/network/endpoints.dart';
import 'package:api_projects/shared/network/remote/dio_helper.dart';
import 'package:api_projects/shop_app/controllers/login_cubit/states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    dioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
       loginModel= ShopLoginModel.fromJson(value.data);
       print(loginModel!.status);
       print(loginModel!.message);
       print(loginModel!.data.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((Error) {
      emit(ShopLoginErrorState(Error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState()); 
  }
}
