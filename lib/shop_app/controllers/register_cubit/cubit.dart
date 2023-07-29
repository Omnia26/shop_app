// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print

import 'package:api_projects/shop_app/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shared/network/endpoints.dart';
import 'package:api_projects/shared/network/remote/dio_helper.dart';
import 'package:api_projects/shop_app/controllers/register_cubit/states.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? RegisterModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    dioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
       RegisterModel= ShopLoginModel.fromJson(value.data);
       print(RegisterModel!.status);
       print(RegisterModel!.message);
       print(RegisterModel!.data.token);
      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((Error) {
      emit(ShopRegisterErrorState(Error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState()); 
  }
}
