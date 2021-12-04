import 'package:app_shop/cubit/cubit.dart';
import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/models/category_model.dart';
import 'package:app_shop/moduls/auth/login_screen.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategories(
                ShopCubit.get(context).categoryModel.data.data[index]),
            separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
            itemCount: ShopCubit.get(context).categoryModel.data.data.length);
      },
    );
  }

  Widget buildCategories(DataModel model) => Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
