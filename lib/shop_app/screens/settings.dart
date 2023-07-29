// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_key_in_widget_constructors, must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:api_projects/shared/components/components.dart';
import 'package:api_projects/shared/components/constants.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var model =ShopCubit.get(context).userModel;
        nameController.text=model.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null, 
          builder:(context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.person,
                  label: 'name',
                ),
                SizedBox(height: 10,),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.email,
                  label: 'email',
                ),
                SizedBox(height: 10,),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  label: 'phone',
                ),
                SizedBox(height: 10,),
                defaultButton(
                  function: (){
                    if(formkey.currentState!.validate()){
                      ShopCubit.get(context).updateData
                    (
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    );
                    }  
                  }, 
                  text: 'Update',),
                SizedBox(height: 10,),
                defaultButton(
                  function: (){
                    signOut(context);
                  }, 
                  text: 'LogOut',),
              ],
            ),
          ),
        ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
      },
    );
  }
}
 