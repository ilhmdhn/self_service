import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class ImageUrlCubit extends Cubit<String> {
  ImageUrlCubit() : super('');

  Future<String> baseUrl() async {
    final url = await PreferencesData.getBaseUrl();
    return "http://$url:3099";
  }

  void getFnBCategoryImage() async {
    final serverUrl = await baseUrl();
    emit('$serverUrl/image-fnb-category?name_file=');
  }

  void getImageFnB() async {
    final serverUrl = await baseUrl();
    emit('$serverUrl/image-fnb?name_file=');
  }

  void getImageRoomCategory() async {
    final serverUrl = await baseUrl();
    emit('$serverUrl/image-room-category?name_file=');
  }

  void getImageRoom() async {
    final serverUrl = await baseUrl();
    emit('$serverUrl/image-room?name_file=');
  }
}
