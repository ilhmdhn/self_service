import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class BaseUrlCubit extends Cubit<String> {
  BaseUrlCubit() : super('');

  void setData(url) async {
    await PreferencesData.setBaseUrl(url);
  }

  void getData() async {
    emit(await PreferencesData.getBaseUrl());
  }
}

class TestModeCubit extends Cubit<bool> {
  TestModeCubit() : super(false);

  void setData() async {
    await PreferencesData.setTestMode();
    getData();
  }

  void getData() async {
    emit(await PreferencesData.getTestMode());
  }
}
