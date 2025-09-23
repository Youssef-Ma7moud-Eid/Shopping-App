
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:shopping_app/core/utils/local_notification_services.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/cart/data/model/transaction_model.dart';
import 'package:shopping_app/feature/cart/presentation/manager/add-card-cubit/add_cart_cubit.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/type_section.dart';

class PaymentMethodsButtonSheet extends StatelessWidget {
  const PaymentMethodsButtonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 30,
        mainAxisSize: MainAxisSize.min,
        children: [
          PaymentTypeSection(),

          CustomButton(
            title: 'Pay Now',
            onPressed: () async {
              var transactionData = getTransaction();

              navigatePaypal(context, transactionData);
            },
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  void navigatePaypal(
    BuildContext context,
    ({Amount amount, ItemList list}) transactionData,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId:
              "AbMGi65FUrOOVHs4WuTiFqvxz9gL5fNNJXBqrWwRqVGwHc-4A1i_AtMZP1aw3CbIN5ElNmfK9N-VEsUs",
          secretKey:
              "EM3ChcKbX4QfikBYIUGBG8Gbtt7_B31PukBTgFI9R6wM-oMSSFkF2Os6K4EX8xul-lYs1FT0sqiy33po",
          transactions: [
            {
              "amount": transactionData.amount.toJson(),
              "description": "The payment transaction description.",

              "item_list": transactionData.list.toJson(),
            },
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            log("onSuccess: $params");
            AddCartCubit.totalAmoun.value = 0;
            AddCartCubit.list.clear();
            BlocProvider.of<AddCartCubit>(context).getProductsCart();
            Navigator.pop(context);
            LoalNotificationServices.showBasicNotification();
            Navigator.pop(context);
          
          },

          onError: (error) {
            log("onError: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  ({Amount amount, ItemList list}) getTransaction() {
    final subtotal = AddCartCubit.totalAmoun.value;

    var amount = Amount(
      total: subtotal.toStringAsFixed(2),
      currency: 'USD',
      details: Details(
        subtotal: subtotal.toStringAsFixed(2),
        shipping: '0',
        shippingDiscount: 0,
      ),
    );

    ItemList list = ItemList(items: []);

    return (amount: amount, list: list);
  }
}

