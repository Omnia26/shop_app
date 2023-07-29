// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/cubit.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:api_projects/shop_app/screens/shopsearch.dart';
import 'package:api_projects/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, ShopSearch());
              }, icon: Icon(Icons.search),)
            ],
          ),
          body: cubit.bottomscreens[cubit.currentindex],
          // TextButton(
          //   child: Text('Sign Out'),
          //   onPressed: () {},
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ,),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'categories',),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded),label: 'favourites',),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings',),
          ],
          onTap: (index) {
            cubit.changeBottom(index);
          },
          ),
        );
      }),
    );
  }
}
