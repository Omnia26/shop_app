// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:api_projects/shop_app/controllers/search_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/search_cubit/states.dart';
import 'package:api_projects/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearch extends StatelessWidget {
  var formkey =GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController, 
                    type: TextInputType.text, 
                    validate: (String value){
                      if(value.isEmpty)
                      {
                        return 'enter text to search';
                      }
                      return null;
                    }, 
                    prefix: Icons.search, 
                    label: 'search',
                    onSubmit: (String text){
                      SearchCubit.get(context).search(text);
                    }, 
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                              itemBuilder:(context, index) =>  buildListProduct(SearchCubit.get(context).model.datae.datas![index],context,isOldPrice: false), //
                              separatorBuilder: (context, index) => myDivider(), 
                              itemCount: SearchCubit.get(context).model.datae.datas!.length,
                            ),
                  ),
                ],
              ),
            ),
          )
        );
        },
      ),
    );
  }
}
