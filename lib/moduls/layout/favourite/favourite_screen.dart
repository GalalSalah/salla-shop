import 'package:app_shop/cubit/cubit.dart';
import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/models/get_favorite.dart';
import 'package:app_shop/moduls/auth/login_screen.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:app_shop/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context).favoriteModel;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopLoadingCategoryState
            ? ShopCubit.get(context).favoriteModel.data.data.isEmpty
            ?  const Center(
            child: Text(
              'No favorite products are found',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
            ))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context).favoriteModel.data.data[index].product,
                    context),
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                itemCount:
                    ShopCubit.get(context).favoriteModel.data.data.length)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }


}
