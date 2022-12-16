import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/fnb_category_model.dart';

class RoomCategoryCubit extends Cubit<FnBCategoryResult> {
  RoomCategoryCubit() : super(FnBCategoryResult());

  void getData() async {
    final response = await ApiService().getFnBCategory();
    emit(response);
  }
}
