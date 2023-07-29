// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, unused_import, avoid_print

import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:api_projects/shared/components/components.dart';
import 'package:api_projects/shop_app/models/categoriesModel.dart';
import 'package:api_projects/shop_app/models/homeModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/cubit.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homemodel != null &&
              ShopCubit.get(context).category != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homemodel,
              ShopCubit.get(context).category,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {
        if (state is ShopSuccessFavouritesState) {
          if(!state.model.status)
          {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }          
        }
      },
    );
  }
}

Widget builderWidget(HomeModel model, CategoriesModel category,context) =>SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(seconds: 3),
              height: 200,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(category.data.lOCData[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: category.data.lOCData.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.75,
              children: List.generate(
                model.data.products.length,
                (index) => buildGridProduct(model.data.products[index],context),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(Products model,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(///
            alignment: AlignmentDirectional.bottomStart, 
            children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ]
        ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(model.id);//عشان المودل هنا هو البرودكت علطول مش محتاجه ادخل جوا كلاس قبله
                        print(ShopCubit.get(context).favourites[model.id]);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                             ShopCubit.get(context).favourites[model.id] !
                                ? Colors.blue
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildCategoryItem(CategoriesData cat) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            cat.image,
          ),
          width: 100.0,
          height: 100.0,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(
            .8,
          ),
          child: Text(
            cat.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
