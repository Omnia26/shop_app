// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_const_constructors, import_of_legacy_library_into_null_safe
import 'package:api_projects/shop_app/models/categoriesModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:api_projects/shared/components/components.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder:(context, index) =>  brievItems(ShopCubit.get(context).category.data.lOCData[index]), 
          separatorBuilder: (context, index) => SizedBox(width: 10,), 
          itemCount: ShopCubit.get(context).category.data.lOCData.length,
        );
      },
      listener: (context, state) {},
    );
    }
  }
  
  Widget brievItems(CategoriesData category)=>Padding(padding: EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(image: NetworkImage(category.image,),
      width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,),
      SizedBox(width: 10,),
      Text(category.name,
      style: TextStyle(fontSize: 20,
      fontWeight: FontWeight.bold),),
      Spacer(),
      Icon(Icons.arrow_forward_ios,),
    ],
  ),
  );

  