import 'dart:io';

import 'package:app_shop/cubit/cubit.dart';
import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/component/constance.dart';
import 'package:app_shop/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String imageUrl;
File imageFile;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ShopCubit.get(context).userModel;
        nameController.text = userModel.data.name;
        phoneController.text = userModel.data.phone;
        emailController.text = userModel.data.email;
        imageUrl = userModel.data.image ;
        return ShopCubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(9),
                              child: Container(
                                width: size.width * 0.24,
                                height: size.width * 0.24,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: imageFile == null
                                      ? Image.network(
                                          userModel.data.image,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          imageFile,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  showImageDialog(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: defaultColor,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      imageFile == null
                                          ? Icons.add_a_photo
                                          : Icons.edit_off_outlined,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                            // CircleAvatar(
                            //   radius: 50,
                            //   backgroundImage: NetworkImage(userModel.data.image),
                            // ),
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'name is required';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'name is required';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'phone is required';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.call),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  ShopCubit.get(context).updateUserDataModel(
                                    context,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,);
                                }
                              },
                              text: 'Update'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: defaultButton(
                              function: () {
                                signOut(context);
                              },
                              text: 'SignOut'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  void showImageDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Please choose an option',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                // ShopCubit.get(context).pickedImageFromCamera(context);
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // ShopCubit.get(context).pickedImageFromGallery(context);
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.photo,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
