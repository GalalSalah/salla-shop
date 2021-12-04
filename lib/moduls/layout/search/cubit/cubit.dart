import 'package:app_shop/models/search_model.dart';
import 'package:app_shop/moduls/layout/search/cubit/state.dart';
import 'package:app_shop/shared/component/constance.dart';
import 'package:app_shop/shared/network/end_points.dart';
import 'package:app_shop/shared/network/remote/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(InitialSearchState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel searchModel;
  void search(String text){
    emit(LoadingSearchStates());
    DioHelpers.postData(url: searchUrl, data: {
      'text':text,
    },
token: token,

    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SuccessSearchStates());


    }).catchError((error){
      print(error.toString());
      emit(ErrorSearchStates());
    });
  }
}