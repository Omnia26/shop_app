import 'package:api_projects/shop_app/models/searchModel.dart';
import 'package:api_projects/shop_app/controllers/search_cubit/states.dart';
import 'package:api_projects/shared/components/constants.dart';
import 'package:api_projects/shared/network/endpoints.dart';
import 'package:api_projects/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel model=SearchModel(datae:Dataa(currentPage: 1,datas: []) ,status: true);
  void search(String text) {
    emit(SearchLoadingState());
    dioHelper
        .postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    )
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      emit(SearchErrorState());
    });
  }
}
