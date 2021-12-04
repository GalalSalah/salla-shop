import 'package:app_shop/models/change_carts.dart';
import 'package:app_shop/models/change_favourite.dart';
import 'package:app_shop/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomBavState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {
  String error;

  ShopErrorHomeState(this.error);
}

class ShopLoadingCategoryState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {
  String error;

  ShopErrorCategoryState(this.error);
}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}



class ShopGetCategoryDetailsSuccessState extends ShopStates {}

class ShopGetCategoryDetailsLoadingState extends ShopStates {}

class ShopGetCategoryDetailsErrorState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}


class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}


class ShopSuccessChangeCartsState extends ShopStates {
  final ChangeCartsModel model;

  ShopSuccessChangeCartsState(this.model);
}

class ShopErrorChangeCartsState extends ShopStates {}

class ShopChangeCartsState extends ShopStates {}

class ShopGetCartSuccessState extends ShopStates {}
class ShopGetCartLoadingState extends ShopStates {}
class ShopGetCartErrorState extends ShopStates {}

