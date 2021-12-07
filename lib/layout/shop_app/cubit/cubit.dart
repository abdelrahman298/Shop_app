import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/models/shop_app/change_favorite_model.dart';
import 'package:udemy_flutter/models/shop_app/favotire_data_model.dart';
import 'package:udemy_flutter/models/shop_app/home_data_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/categories_screen/categories_screen.dart';
import 'package:udemy_flutter/modules/shop_app/favorites_screen/favorits_screen.dart';
import 'package:udemy_flutter/modules/shop_app/products_screen/products_screen.dart';
import 'package:udemy_flutter/modules/shop_app/setting_screen/setting_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/endPoint.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/models/shop_app/categories_data.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<dynamic> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeCurrentIndex(index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      // print(value.data.toString());

      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorite.addAll(
          {
            element.id: element.inFavorites,
          },
        );
      });
      // print(favorite.toString());

      // print(homeModel.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      url: GET_CATEGORY,
      token: token,
    ).then((value) {
      // print(value.data.toString());

      categoriesModel = CategoriesModel.fromJson(value.data);

      // print(categoriesModel.status);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoriteModel changeFavoriteModel;
  void changeFavorite(int productId) {
    favorite[productId] = !favorite[productId];

    emit(ShopChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITE,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      // print(value.data.toString());
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      // print(changeFavoriteModel.message);
      if (!changeFavoriteModel.status) {
        favorite[productId] = !favorite[productId];
      } else {
        getFavoriteData();
      }

      emit(ShopSuccessChangeFavoriteState(changeFavoriteModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorChangeFavoriteState());
    });
  }

  FavoriteDataModel favoriteDataModel;
  void getFavoriteData() {
    emit(ShopLoadingFavoriteDataState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      // print(value.data);
      favoriteDataModel = FavoriteDataModel.fromJson(value.data);
      // print(favoriteDataModel.data);
      emit(ShopSuccessFavoriteDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoriteDataState());
    });
  }

  ShopLoginModel userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      // print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String phone,
    @required String email,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      // print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
