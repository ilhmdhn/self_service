import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/fnb_category_model.dart';
import 'package:self_service/data/model/inventory_model.dart';

class FnBCategoryCubit extends Cubit<FnBCategoryResult> {
  FnBCategoryCubit() : super(FnBCategoryResult());

  void getData() async {
    final response = await ApiService().getFnBCategory();
    emit(response);
  }
}

class InventoryCubit extends Cubit<InventoryResult> {
  InventoryCubit() : super(InventoryResult());
  void getData(int page, int size, String category, String search) async {
    final response =
        await ApiService().getInventory(page, size, category, search);
    emit(response);
  }
}

class CategoryInventoryNameCubit extends Cubit<String> {
  CategoryInventoryNameCubit() : super('ALL');
  void getData(categoryName) async {
    return emit(categoryName);
  }
}
