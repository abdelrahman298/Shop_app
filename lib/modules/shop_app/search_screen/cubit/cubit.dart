import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/search_data_model.dart';
import 'package:udemy_flutter/modules/shop_app/search_screen/cubit/states.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/endPoint.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchDataModel searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: PRODUCTS_SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      print(value.data);

      searchModel = SearchDataModel.fromJson(value.data);
      print(searchModel.data.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(SearchErrorState());
    });
  }
}
