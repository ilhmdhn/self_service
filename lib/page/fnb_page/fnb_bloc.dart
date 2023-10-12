import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class FnBCategoryCubit extends Cubit<FnBCategoryResult> {
  FnBCategoryCubit() : super(FnBCategoryResult());

  void setData() async {
    final isTestMode = await PreferencesData.getTestMode();
    FnBCategoryResult response;
    if (isTestMode) {
      response = await ApiTest().fnbCategory();
    } else {
      response = await ApiService().getFnBCategory();
    }
    emit(response);
  }
}

class FnBCubit extends Cubit<FnBResultModel> {
  FnBCubit() : super(FnBResultModel());

  void setData(int page, String category, String search) async {
    final isTestMode = await PreferencesData.getTestMode();
    FnBResultModel response = FnBResultModel();
    if (isTestMode) {
      response = await ApiTest().getFnB(category, page);
    } else {
      response = await ApiService().getInventory(page, category, search);
    }
    emit(response);
  }
}

class FnBListCubit extends Cubit<List<FnB>> {
  FnBListCubit() : super(List.empty());

  void setData(List<FnB> data) {
    emit(data);
  }
}
