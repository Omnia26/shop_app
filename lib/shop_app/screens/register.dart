// ignore_for_file: implementation_imports, prefer_const_constructors, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, must_be_immutable, avoid_print, deprecated_member_use

import 'package:api_projects/shared/components/components.dart';
import 'package:api_projects/shared/components/constants.dart';
import 'package:api_projects/shared/network/local/cache_helper.dart';
import 'package:api_projects/shop_app/controllers/register_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/register_cubit/states.dart';
import 'package:api_projects/shop_app/screens/shopLayout.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  
  var loginemailcontroller = TextEditingController();
  var loginpasscontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ShopRegisterCubit() ,
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(),
          body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'REGISTER now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: namecontroller,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'impossible to be empty';
                              }
                            },
                            prefix: Icons.person,
                            label: 'Name',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: loginemailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'impossible to be empty';
                              }
                            },
                            prefix: Icons.email,
                            label: 'Email',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: loginpasscontroller,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'impossible to be empty';
                              }
                            },
                            prefix: Icons.password,
                            suffix: ShopRegisterCubit .get(context).suffix,
                            suffixpressed: () {
                              ShopRegisterCubit .get(context)
                                  .changePasswordVisibility();
                            },
                            label: 'password',
                            ispassword: ShopRegisterCubit .get(context).isPassword,
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                ShopRegisterCubit .get(context).userRegister(
                                  email: loginemailcontroller.text,
                                  password: loginpasscontroller.text,
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,

                                );
                              }
                            },
                          ),
                        
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: phonecontroller,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'impossible to be empty';
                              }
                            },
                            prefix: Icons.phone,
                            label: 'Phone',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopRegisterCubit .get(context).userRegister(
                                  email: loginemailcontroller.text,
                                  password: loginpasscontroller.text,
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                );
                                }
                              },
                              text: 'Register',
                              isUpperCase: true,
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        );
        },
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status) {
            // print(state.RegisterModel.data.token);
            // print(state.RegisterModel.message);
            showToast(
              state: ToastStates.SUCCESS,
              text: state.registerModel.message.toString(),
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.registerModel.data.token,
            ).then((value) {
              token=state.registerModel.data.token;
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            print(state.registerModel.message);
            showToast(
              state: ToastStates.ERROR,
              text: state.registerModel.message.toString(),
            );
          }
        }
        },
        ),
    );
  }
}