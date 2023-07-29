
import 'package:api_projects/shop_app/models/changeFavouritesModel.dart';
import 'package:api_projects/shop_app/models/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavBarState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopFavouritesState extends ShopStates{}
class ShopSuccessFavouritesState extends ShopStates{
  final ChangeFavouritesModel model;
  ShopSuccessFavouritesState(this.model);
}
class ShopErrorFavouritesState extends ShopStates{}

class ShopSuccessGetFavState extends ShopStates{}
class ShopErrorGetFavState extends ShopStates{}
class ShopLoadingGetFavState extends ShopStates{}

class ShopSuccessGetProfileState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetProfileState(this.loginModel);
}
class ShopErrorGetProfileState extends ShopStates{}
class ShopLoadingGetProfileState extends ShopStates{}


class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}
