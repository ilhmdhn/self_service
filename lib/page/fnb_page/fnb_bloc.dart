import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class FnBCategoryCubit extends Cubit<FnBCategoryResult> {
  FnBCategoryCubit() : super(FnBCategoryResult());

  void setData() async {
    final isTestMode = await PreferencesData.getTestMode();
    if (isTestMode) {
      final response = await ApiTest().fnbCategory();
      emit(response);
    }
  }
}

class FnBCubit extends Cubit<FnBResultModel> {
  FnBCubit() : super(FnBResultModel());

  void setData(String category) async {
    final isTestMode = await PreferencesData.getTestMode();
    if (isTestMode) {
      final response = await ApiTest().getFnB(category);
      emit(response);
    }
  }
}
