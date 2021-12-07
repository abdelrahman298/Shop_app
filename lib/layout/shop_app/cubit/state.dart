import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopChangeFavoriteState extends ShopStates {}

class ShopErrorChangeFavoriteState extends ShopStates {}

class ShopLoadingFavoriteDataState extends ShopStates {}

class ShopSuccessFavoriteDataState extends ShopStates {}

class ShopErrorFavoriteDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel userData;
  ShopSuccessUserDataState(this.userData);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel userData;
  ShopSuccessUpdateUserDataState(this.userData);
}

class ShopErrorUpdateUserDataState extends ShopStates {}
