
import 'package:app_shop/moduls/auth/register.dart';
import 'package:app_shop/moduls/layout/shop_layout/main_shop_layout.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/component/constance.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:app_shop/shared/styles/colors.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_cubit/cubit.dart';
import 'login_cubit/state.dart';

class LoginScreen extends StatelessWidget {
   TextEditingController emailEditingController = TextEditingController();
   TextEditingController passwordEditingController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CashHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value) {
                token=state.loginModel.data.token;
                navigateAndReplacement(context, ShopLayout());
              });
            // showToast(msg: state.loginModel.message, state: ToastState.success);
            } else {
              print(state.loginModel.message);
              showToast(msg: state.loginModel.message, state: ToastState.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailEditingController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                            // else{
                            //   return null;
                            // }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          controller: passwordEditingController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailEditingController.text,
                                password: passwordEditingController.text,
                              );
                            }
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuildCondition(
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailEditingController.text,
                                  password: passwordEditingController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                            radius: 5,
                            isUpperCase: true,
                            background: defaultColor,
                            width: double.infinity / 2,
                          ),
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                                fct: () =>
                                    navigateTo(context,  RegisterScreen()),
                                label: 'register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
