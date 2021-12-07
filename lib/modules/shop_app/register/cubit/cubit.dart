import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter/shared/network/endPoint.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  //هعمل function عشان تجيبلى تعملى post للداتا بتاعة الUser من postman
  //كنت عملت post method فى  Dio Helper و كان محتاج end point و هى ال Login و ال password
  //و بعد كدة هيجيبلى ال value بتاعة ال post و هى عبارة عن ال data الخاصة بال user
  //
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
      lang: 'ar',
    ).then((value) {
      // ال data دى عبارة عن
      //status - message - data
      //هعمل Class model عشان اترجم ال data دى على هيئة values اقدر اخزنهم فيها
      // و ده من خلال انى هبعت ال value.data فى ال Class Model Constructor
      //ShopLoginModel.fromJson(value.data);
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      //بعد ما خلصت و بعت ال value.data هستخدم ال Constructor ده
      // و هبعته مع  SuccessState عشان اقدر استخدمه
      // فى حتة تانية لما ال Success يسمع
      //هسمع ال data دى فى ال provider و ال consumer اللى فى SHopLoginScreen
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordIconVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_rounded;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
