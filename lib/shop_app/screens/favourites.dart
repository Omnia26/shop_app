// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, import_of_legacy_library_into_null_safe, unused_import

import 'package:api_projects/shop_app/controllers/general_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:api_projects/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavState, 
          builder:(context)=> ListView.separated(
            itemBuilder:(context, index) =>  buildListProduct(ShopCubit.get(context).favoriteModel.data!.data![index].product,context), //
            separatorBuilder: (context, index) => SizedBox(width: 10,), 
            itemCount: ShopCubit.get(context).favoriteModel.data!.data!.length,
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator()) ,
        );
      },
      listener: (context, state) {},
    );
    }
}
