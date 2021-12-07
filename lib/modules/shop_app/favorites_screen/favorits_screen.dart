import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/models/shop_app/favotire_data_model.dart';
import 'package:udemy_flutter/models/shop_app/home_data_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.favoriteDataModel.data.data.isNotEmpty,
            builder: (context) => ConditionalBuilder(
              condition: state is! ShopLoadingFavoriteDataState,
              builder: (BuildContext context) => ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    cubit.favoriteDataModel.data.data[index].product, context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.favoriteDataModel.data.data.length,
              ),
              fallback: (context) => CircularProgressIndicator(),
            ),
            fallback: (context) => Center(
                child: Text(
              'There\'s no Favorite Item',
              style: TextStyle(fontSize: 20.0),
            )),
          );
        },
      ),
    );
  }
}
