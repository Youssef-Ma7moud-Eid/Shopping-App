import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-product-by-catagory/get_product_by_catgory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/prouct_of_category_view.dart';
import 'package:shopping_app/feature/home/presentation/widgets/tab_item_widget.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({super.key, required this.categories});
  final List<GetCategoryEntity> categories;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.zero,
            onTap: (int index) {
              log('Selected tab: ${widget.categories[index].id}');
            },
            tabs: widget.categories
                .map(
                  (source) => GestureDetector(
                    onTap: () async {
                      log("testttttt");
                      log(source.id.toString());
                      await BlocProvider.of<GetProductByCatgoryCubit>(
                        context,
                      ).getProductsByCategory(source.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProuctOfCategoryView(id: source.id!),
                        ),
                      );
                    },

                    child: TabItemWidget(category: source),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
