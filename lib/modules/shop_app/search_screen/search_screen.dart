import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/search_data_model.dart';
import 'package:udemy_flutter/modules/shop_app/search_screen/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/search_screen/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                          type: TextInputType.text,
                          controller: searchController,
                          validate: (value) {
                            if (value.isEmpity) {
                              return 'please Search for what you want';
                            }
                            {
                              return null;
                            }
                          },
                          label: 'Search',
                          prefix: Icons.search_rounded,
                          onSubmit: (String text) {
                            SearchCubit.get(context).search(text);
                          }),
                    ),
                    SizedBox(height: 10),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(height: 20),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data[index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

// Widget buildSearchItem(Product model, BuildContext context) => Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           Image(
//             image: NetworkImage(
//               model.image,
//             ),
//             fit: BoxFit.cover,
//             height: 80,
//             width: 80,
//           ),
//           SizedBox(width: 20.0),
//           Expanded(
//             child: Text(
//               '${model.name}',
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//           Spacer(),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.arrow_forward_ios_rounded,
//             ),
//           )
//         ],
//       ),
//     );
