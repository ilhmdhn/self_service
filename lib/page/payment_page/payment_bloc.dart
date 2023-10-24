import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/list_payment.dart';

class PaymentListCubit extends Cubit<ListPaymentResult> {
  PaymentListCubit() : super(ListPaymentResult());

  void getData() async {
    final response = await ApiTest().getPaymentMethod();
    emit(response);
  }
}
