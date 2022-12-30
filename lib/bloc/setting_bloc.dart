import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class BaseUrlCubit extends Cubit<String> {
  BaseUrlCubit() : super('');

  void setData(url) async {
    PreferencesData.setBaseUrl(url);
  }

  Future<String> getData() async {
    return await PreferencesData.getBaseUrl();
  }
}
