import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/checkin_model.dart';
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

class SingleFnBCubit extends Cubit<InventorySingleResult> {
  SingleFnBCubit() : super(InventorySingleResult());

  void getData(inventoryCode) async {
    final response = await ApiService().getFnBSingle(inventoryCode);
    emit(response);
  }
}

class OrderFnBCubit extends Cubit<List<DataOrder>> {
  OrderFnBCubit() : super(<DataOrder>[]);

  void insertData(DataOrder data) {
    emit([...state, data]);
  }

  void insertAllData(List<DataOrder> data) {
    emit(data);
  }
}
