import 'package:app_shop/models/get_favorite.dart';
import 'package:app_shop/moduls/auth/login_screen.dart';
import 'package:app_shop/moduls/layout/search/cubit/cubit.dart';
import 'package:app_shop/moduls/layout/search/cubit/state.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Search in Salla'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search),
                    const SizedBox(
                      height: 15,
                    ),

                    if (state is LoadingSearchStates)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SuccessSearchStates)
                       Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildListProduct(
                                          SearchCubit.get(context)
                                              .searchModel
                                              .data
                                              .data[index],
                                          context,
                                          isOldPrice: false),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                  itemCount: SearchCubit.get(context)
                                      .searchModel
                                      .data
                                      .data
                                      .length),
                            ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
