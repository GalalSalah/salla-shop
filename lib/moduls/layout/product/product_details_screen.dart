import 'package:app_shop/cubit/cubit.dart';
import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/styles/colors.dart';

import 'package:buildcondition/buildcondition.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productDetailModel = ShopCubit.get(context).productDetailsModel;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeCartsState){
          if(!state.model.status){
            showToast(msg: state.model.message, state: ToastState.error);
          }
          showToast(msg:state.model.message , state: ToastState.success);
        }
      },
      builder: (context, state) {
        // var productModel=ShopCubit.get(context).productDetailsModel;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: BuildCondition(
                condition: productDetailModel.data != null,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          // onTap: (){navigateTo(context, ProductDetailsScreen(model.id));},
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image(
                                image: productDetailModel.data.images == null
                                    ? Image.asset(
                                        'assets/images/woocommerce-placeholder.png')
                                    : NetworkImage(
                                        productDetailModel.data.image),
                                width: double.infinity,
                                height: 200.0,
                              ),
                              if (productDetailModel.data.discount != 0)
                                Container(
                                  // height: 100,
                                  color: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  child: const Text(
                                    'DISCOUNT',
                                    style: TextStyle(
                                      fontSize: 8.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productDetailModel.data.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              // SizedBox(height: 25,),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  productDetailModel.data.description,
                                  maxLines: 6,
                                  overflow: TextOverflow.clip,
                                  // overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Price: ${productDetailModel.data.price.round()}',
                                    style: const TextStyle(
                                      fontSize: 19.0,
                                      color: defaultColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  if (productDetailModel.data.discount != 0)
                                    Text(
                                      '${productDetailModel.data.oldPrice.round()}',
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        ShopCubit.get(context).changeCarts(
                                            productDetailModel.data.id);
                                      },
                                      icon: ShopCubit.get(context)
                                              .carts[productDetailModel.data.id]
                                          ? const Icon(Icons.remove_shopping_cart)
                                          : const Icon(Icons
                                              .add_shopping_cart_outlined)),
                                  IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context).changeFavorites(
                                          productDetailModel.data.id);
                                      print(productDetailModel.data.id);
                                    },
                                    icon: CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor:
                                          ShopCubit.get(context).favourites[
                                                  productDetailModel.data.id]
                                              ? defaultColor
                                              : Colors.grey,
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
    );
  }
}
