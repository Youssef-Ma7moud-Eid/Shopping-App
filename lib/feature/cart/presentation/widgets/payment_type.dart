import 'package:flutter/material.dart';

class PaymentType extends StatelessWidget {
  const PaymentType({super.key, required this.image, this.isActive = false});
  final String image;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 70,
      width: 115,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: isActive == true ? Color(0xff34A853) : Color(0xff000000),
        ),
      ),
      child: Image.asset(image, fit: BoxFit.scaleDown),
    );
  }
}
