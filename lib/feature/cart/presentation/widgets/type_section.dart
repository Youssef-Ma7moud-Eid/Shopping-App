import 'package:flutter/material.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/payment_type.dart';

class PaymentTypeSection extends StatefulWidget {
  const PaymentTypeSection({super.key});

  @override
  State<PaymentTypeSection> createState() => _PaymentTypeSectionState();
}

class _PaymentTypeSectionState extends State<PaymentTypeSection> {
  int isActive = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                isActive != 1
                    ? setState(() {
                        isActive = 1;
                      })
                    : null;
              },
              child: PaymentType(
                image: "assets/image/type1.png",
                isActive: isActive == 1,
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                isActive != 2
                    ? setState(() {
                        isActive = 2;
                      })
                    : null;
              },
              child: PaymentType(
                image: "assets/image/type2.png",
                isActive: isActive == 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
