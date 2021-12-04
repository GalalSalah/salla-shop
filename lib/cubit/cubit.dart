import 'package:app_shop/cubit/status.dart';
import 'package:app_shop/models/change_carts.dart';
import 'package:app_shop/models/product_details_model.dart';
import 'package:app_shop/models/category_model.dart';
import 'package:app_shop/models/change_favourite.dart';
import 'package:app_shop/models/get_favorite.dart';
import 'package:app_shop/models/home_model.dart';
import 'package:app_shop/models/login_model.dart';
import 'package:app_shop/moduls/layout/categories/category_screen.dart';
import 'package:app_shop/moduls/layout/favourite/favourite_screen.dart';
import 'package:app_shop/moduls/layout/product/product_details_screen.dart';
import 'package:app_shop/moduls/layout/product/product_screen.dart';
import 'package:app_shop/moduls/layout/setting/setting_screen.dart';
import 'package:app_shop/shared/component/components.dart';
import 'package:app_shop/shared/component/constance.dart';
import 'package:app_shop/shared/network/end_points.dart';
import 'package:app_shop/shared/network/remote/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopInitialState());
  }

  HomeModel homeModel;
  Map<int, bool> favourites = {};

  void getDataHome() {
    emit(ShopLoadingHomeState());
    DioHelpers.getData(
      url: homeUrl,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel.data.products) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      }
      for (var element in homeModel.data.products) {
        carts.addAll({
          element.id: element.inCart,
        });
      }
      print(favourites.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeState(error));
    });
  }

  CategoriesModel categoryModel;

  void getCategory() {
    emit(ShopLoadingCategoryState());

    DioHelpers.getData(
      url: get_gategory,
    ).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);
      // printFullText(homeModel.status.toString());
      // printFullText(homeModel.data.banners[0].id.toString());
      emit(ShopSuccessCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryState(error.toString()));
    });
  }

  ChangeFavouritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId];

    emit(ShopChangeFavoritesState());

    DioHelpers.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavouritesModel.fromJson(value.data);

      print(value.data);

      if (!changeFavoritesModel.status) {
        favourites[productId] = !favourites[productId];
      } else {
        getFavorite();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoriteModel favoriteModel;

  void getFavorite() {
    emit(ShopLoadingGetFavoriteState());
    DioHelpers.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      printFullText(value.data.toString());
      // printFullText(homeModel.status.toString());
      // printFullText(homeModel.data.banners[0].id.toString());
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }

  ShopLoginModel userModel;

  void getUserDataModel() {
    emit(ShopLoadingUserDataState());
    DioHelpers.getData(
      url: userProfile,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      // printFullText(homeModel.status.toString());
      // printFullText(homeModel.data.banners[0].id.toString());
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserDataModel(context,
      {@required String name,
      @required String phone,
      @required String email,
      @required String image}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelpers.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'image': image,
        'email': email,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // pickedImageFromGallery(context);
      // pickedImageFromCamera(context);
      print(userModel.data.name);
      // printFullText(homeModel.status.toString());
      // printFullText(homeModel.data.banners[0].id.toString());
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }

  // File imageFile;

  // void pickedImageFromCamera(context) async {
  //   emit(CameraInitial());
  //   PickedFile pickedImage = await ImagePicker()
  //       .getImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
  //   emit(CameraReady());
  //   imageFile = File(pickedImage.path);
  //
  //   Navigator.pop(context);
  // }

  // void pickedImageFromGallery(context) async {
  //   emit(GalleryInitial());
  //   PickedFile pickedImage = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080)
  //       .then((value) {
  //     imageFile = File(value.path);
  //
  //     emit(GalleryReady());
  //   });
  //   imageFile = File(pickedImage.path);
  //   Navigator.pop(context);
  // }
// Future<File> getImage() async {
// File image = await ImagePicker.pickImage(
// source: ImageSource.gallery, maxWidth: 150.0, maxHeight: 150.0);
// return image;
// }
//
// Future<File> takeImage() async {
// var image = await ImagePicker.platform.pickImage(
// source: ImageSource.camera, maxWidth: 150.0, maxHeight: 150.0);
// return image;
// }

// void showImageDialog(context) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text(
//         'Please choose an option',
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           InkWell(
//             onTap: () {
//               _pickedImageFromCamera(context);
//             },
//             child: Row(
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.all(4.0),
//                   child: Icon(
//                     Icons.camera,
//                     color: Colors.purple,
//                   ),
//                 ),
//                 Text(
//                   'Camera',
//                   style: TextStyle(color: Colors.purple),
//                 ),
//               ],
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               _pickedImageFromGallery(context);
//             },
//             child: Row(
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.all(4.0),
//                   child: Icon(
//                     Icons.photo,
//                     color: Colors.purple,
//                   ),
//                 ),
//                 Text(
//                   'Gallery',
//                   style: TextStyle(color: Colors.purple),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
  ProductDetailsModel productDetailsModel;

  void getCategoryDetails(int id,context) {
    emit(ShopGetCategoryDetailsLoadingState());
    DioHelpers.getData(url: 'products/$id',
    //     query: {
    //   'productId':productId,
    // }
    )
        .then((value) {
      productDetailsModel=ProductDetailsModel.fromJson(value.data);
          print(value.data.toString());
          navigateTo(context, ProductDetailsScreen());
          emit(ShopGetCategoryDetailsSuccessState());
    })
        .catchError((error) {
      emit(ShopGetCategoryDetailsErrorState());
    });
  }
  Map<int, bool> carts = {};
  ChangeCartsModel changeCartsModel;

  void changeCarts(int productId) {
    carts[productId] = !carts[productId];

    emit(ShopChangeCartsState());

    DioHelpers.postData(
      url: cartsUrl,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);

      print(value.data);

      if (!changeCartsModel.status) {
        carts[productId] = !carts[productId];
      } else {
        getFavorite();
      }

      emit(ShopSuccessChangeCartsState(changeCartsModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId];

      emit(ShopErrorChangeCartsState());
    });
  }
}
