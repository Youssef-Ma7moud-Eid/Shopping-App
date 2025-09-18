import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final isLoading;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: onPressed,
      color: Color(0xff212121),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : SizedBox.shrink(),
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}
