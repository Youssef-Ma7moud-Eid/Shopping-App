import 'package:flutter/material.dart';

import 'package:shopping_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:shopping_app/core/utils/validator_functions.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "Email",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            CustomTextFormField(
              controller: emailController,
              validator: Validator.validateEmail,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            SizedBox(height: 30),
            Text(
              "Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            CustomTextFormField(
              controller: passwordController,
              validator: Validator.validatePassword,
              hintText: "Enter your password",
              isPassword: true,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            SizedBox(height: 50),
            CustomButton(
              title: "Login",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
