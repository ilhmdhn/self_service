import 'package:flutter/material.dart';
import 'package:self_service/data/model/fnb_category_model.dart';
import '../bloc/fnb_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FnBPage extends StatelessWidget {
  FnBPage({super.key});

  final FnBCategoryCubit fnbCategoryCubit = FnBCategoryCubit();

  @override
  Widget build(BuildContext context) {
    fnbCategoryCubit.getData();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 130,
            child: BlocBuilder<FnBCategoryCubit, FnBCategoryResult>(
              bloc: fnbCategoryCubit,
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.category?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54, width: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    'http://192.168.1.248:3001/image-fnb-category?name_file=${state.category?[index].fnbCategoryImage}'),
                              ),
                              Text(state.category?[index].fnbCategoryName
                                      .toString() ??
                                  ""),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
