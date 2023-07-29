// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:api_projects/shop_app/models/categoriesModel.dart';
import 'package:api_projects/shop_app/models/changeFavouritesModel.dart';
import 'package:api_projects/shop_app/models/favouriteModel.dart';
import 'package:api_projects/shop_app/models/homeModel.dart';
import 'package:api_projects/shop_app/models/login_model.dart';
import 'package:api_projects/shop_app/screens/categories.dart';
import 'package:api_projects/shop_app/screens/favourites.dart';
import 'package:api_projects/shop_app/screens/products.dart';
import 'package:api_projects/shop_app/screens/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_projects/shop_app/controllers/general_cubit/states.dart';
import 'package:api_projects/shared/components/constants.dart';
import 'package:api_projects/shared/network/endpoints.dart';
import 'package:api_projects/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<Widget> bottomscreens = [
    const ProductsPage(),
    const Categories(),
    const Favourites(),
    Settings(),
  ];
  void changeBottom(int index) {
    currentindex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel homemodel =HomeModel(
    status: false, data: BPModel(banners: [], products: []));
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    dioHelper
        .getData(
      url: HOME,
      token: token, //
    )
        .then((value) {
      homemodel = HomeModel.fromJson(value.data);
      homemodel.data.products.forEach((element) {///neeeeeeew
        favourites.addAll({///
          element.id: element.inFavourite,///
        });
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel category = CategoriesModel(
      status: false, data: ListCategoriesData(lOCData: [], currentPage: 1)); //
  void getcategoryData() {
    dioHelper
        .getData(
      url: GET_CATEGORIES,
      token: token, //
    )
        .then((value) {
      category = CategoriesModel.fromJson(value.data);
      print(category.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouritesModel changeFavouritesModel =ChangeFavouritesModel(
    message: '', status: false, data: Dataa(id: 1,
       product:Products(id: 1,name: " ",discount: 2,oldPrice: 5,price: 4,image: '',
      inFavourite: false,incard: true) ));
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopFavouritesState());
    dioHelper
        .postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,//
    )
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavouritesModel.status) {//يعني لو قيمتها ب فولس رجعها لحالتها تاني غير كده اعرض الفيفوريتس بقا
        favourites[productId] = !favourites[productId]!;
      }
      else {
        getFavouriteData();
      }
      emit(ShopSuccessFavouritesState(changeFavouritesModel));///
    }).catchError((error) {
      emit(ShopErrorFavouritesState());
    });
  }

  FavouriteModel favoriteModel =FavouriteModel(
    status: false,data: Data(currentPage: 1,data: []));///alsooooooo ///
  void getFavouriteData() {
    emit(ShopLoadingGetFavState());///
    dioHelper
        .getData(
      url: FAVOURITES,
      token: token, //
    ).then((value) {
      favoriteModel =FavouriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  ShopLoginModel userModel =ShopLoginModel(
    status:true,message:'',data:UserData(
    id :1,
    name :'',
    email :'',
    phone :'1',
    image :'',
    points :1,
    credit :2,
    token :'',
  ));
  void getProfileData() {
    emit(ShopLoadingGetProfileState());
    dioHelper
        .getData(
      url: PROFILE,
      token: token, //
    ).then((value) {
      userModel =ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetProfileState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }

  void updateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    dioHelper
        .putData(
      url: UPDATE_PROFILE,
      token: token,
       data: {
        'name':name,
        'email':email,
        'phone':phone,
       }, //
    ).then((value) {
      userModel =ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}
