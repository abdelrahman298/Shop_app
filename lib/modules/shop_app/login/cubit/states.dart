import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginInitialState {}

class ShopLoginSuccessState extends ShopLoginInitialState {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginInitialState {
  final String error;
  ShopLoginErrorState(this.error);
}

// class ShopPostLoadingState extends ShopLoginInitialState {}
//
// class ShopPostSuccessState extends ShopLoginInitialState {}
//
// class ShopPostErrorState extends ShopLoginInitialState {
//   final String error;
//   ShopPostErrorState(this.error);
// }

class ShopChangePasswordVisibilityState extends ShopLoginInitialState {}
