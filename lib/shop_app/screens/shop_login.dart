// ignore_for_file: prefer_const_constructors, implementation_imports, unused_import, unnecessary_import, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, import_of_legacy_library_into_null_safe, avoid_print, duplicate_import, deprecated_member_use

import 'package:api_projects/shop_app/screens/register.dart';
import 'package:api_projects/shared/components/constants.dart';
import 'package:api_projects/shop_app/screens/shopLayout.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:api_projects/shared/components/components.dart';
import 'package:api_projects/shop_app/controllers/login_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/login_cubit/states.dart';
import 'package:api_projects/shop_app/screens/register.dart';
import 'package:api_projects/shared/network/local/cache_helper.dart';

class ShopLogin extends StatelessWidget {
  var loginemailcontroller = TextEditingController();
  var loginpasscontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status == true) {
            print(state.loginModel.data.token);
            print(state.loginModel.message);
            showToast(
              state: ToastStates.SUCCESS,
              text: state.loginModel.message.toString(),
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.data.token,
            ).then((value) {
              token = state.loginModel.data.token;
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            print(state.loginModel.message);
            showToast(
              state: ToastStates.ERROR,
              text: state.loginModel.message.toString(),
            );
          }
        }
      },
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
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30,
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
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixpressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        label: 'password',
                        ispassword: ShopLoginCubit.get(context).isPassword,
                        onSubmit: (value) {
                          if (formkey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              email: loginemailcontroller.text,
                              password: loginpasscontroller.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: loginemailcontroller.text,
                                password: loginpasscontroller.text,
                              );
                            }
                          },
                          text: 'Login',
                          isUpperCase: true,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(context, Register());
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
