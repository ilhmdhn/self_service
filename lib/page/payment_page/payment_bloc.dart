import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/list_payment.dart';
import 'package:self_service/data/model/payment_qris.dart';
import 'package:self_service/data/model/payment_va.dart';

class PaymentListCubit extends Cubit<ListPaymentResult> {
  PaymentListCubit() : super(ListPaymentResult());

  void getData() async {
    final response = await ApiTest().getPaymentMethod();
    emit(response);
  }

  void updateData(ListPaymentResult data) {
    emit(data);
  }
}

class PaymentQrisCubit extends Cubit<QrisPaymentResult> {
  PaymentQrisCubit() : super(QrisPaymentResult());

  void getData(String paymentMethod, String paymentChannel, num amount,
      String customer, String phone, String email) async {
    final response = await ApiService().getQrisPayment(
        paymentMethod, paymentChannel, amount, customer, phone, email);
    emit(response);
  }
}

class PaymentVaCubit extends Cubit<PaymentVaResult> {
  PaymentVaCubit() : super(PaymentVaResult());

  void getData(String paymentMethod, String paymentChannel, num amount,
      String customer, String phone, String email) async {
    final response = await ApiService().getVaPayment(
        paymentMethod, paymentChannel, amount, customer, phone, email);
    emit(response);
  }
}
