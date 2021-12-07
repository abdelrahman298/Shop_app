import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterInitialState {}

class ShopRegisterSuccessState extends ShopRegisterInitialState {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterInitialState {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopPostLoadingState extends ShopRegisterInitialState {}

class ShopPostSuccessState extends ShopRegisterInitialState {}

class ShopPostErrorState extends ShopRegisterInitialState {
  final String error;
  ShopPostErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState
    extends ShopRegisterInitialState {}
