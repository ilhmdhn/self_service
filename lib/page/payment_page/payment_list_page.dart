import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/list_payment.dart';
import 'package:self_service/page/payment_page/payment_bloc.dart';

class PaymentMethodListPage extends StatefulWidget {
  const PaymentMethodListPage({super.key});
  static const nameRoute = '/list-payment';
  @override
  State<PaymentMethodListPage> createState() => _PaymentMethodListPageState();
}

class _PaymentMethodListPageState extends State<PaymentMethodListPage> {
  PaymentListCubit listPaymentCubit = PaymentListCubit();

  @override
  void initState() {
    listPaymentCubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<PaymentListCubit, ListPaymentResult>(
              bloc: listPaymentCubit,
              builder: (context, stateListPayment) {
                List<PaymentMethod> listPayment = stateListPayment.data ?? [];
                print('CEK JUMLAH DATA' + stateListPayment.state.toString());
                print('CEK JUMLAH DATA' + stateListPayment.message.toString());
                print('CEK JUMLAH DATA' + listPayment.length.toString());
                return ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        listPayment[index].isExpanded = !isExpanded;
                      });
                    },
                    children:
                        listPayment.map<ExpansionPanel>((PaymentMethod item) {
                      return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(item.name ?? ''),
                            );
                          },
                          body: ListTile(
                              title: Text(item.name ?? ''),
                              subtitle: const Text(
                                  'To delete this panel, tap the trash can icon'),
                              trailing: const Icon(Icons.delete),
                              onTap: () {
                                setState(() {
                                  listPayment.removeWhere(
                                      (PaymentMethod currentItem) =>
                                          item == currentItem);
                                });
                              }),
                          isExpanded: item.isExpanded);
                    }).toList());
              }),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
