import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20),
                  defaultFormField(
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Where\'s your name';
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.name,
                    prefix: Icons.person,
                    label: 'your name',
                    controller: nameController,
                  ),
                  SizedBox(height: 8),
                  defaultFormField(
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Your email is Null';
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.emailAddress,
                    prefix: Icons.mail_outline,
                    label: 'your email',
                    controller: emailController,
                  ),
                  SizedBox(height: 8),
                  defaultFormField(
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Your email is Null';
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.phone,
                    prefix: Icons.phone_android,
                    label: 'your phone',
                    controller: phoneController,
                  ),
                  SizedBox(height: 12),
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    child: defaultButton(
                      text: 'LOGOUT',
                      function: () {
                        signOut(context);
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    child: defaultButton(
                      text: 'UPDATE',
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
