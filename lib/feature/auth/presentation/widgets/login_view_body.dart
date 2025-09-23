import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper.dart';

import 'package:shopping_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:shopping_app/core/dialogs/app_toasts.dart';
import 'package:shopping_app/core/utils/validator_functions.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/app_section/app_section.dart';
import 'package:shopping_app/feature/auth/presentation/manager/login-cubit/login_cubit.dart';
import 'package:shopping_app/feature/auth/presentation/manager/login-cubit/login_state.dart';
import 'package:toastification/toastification.dart';




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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SuccessLogin) {
          AppToast.showToast(
            context: context,
            title: "Success",
            description: "Login Success",
            type: ToastificationType.success,
          );

          CacheHelper().saveData(key: 'Login', value: true);
          Navigator.of(context).pushReplacementNamed(AppSection.routeName);
        } else if (state is FauilreLogin) {
          AppToast.showToast(
            context: context,
            title: "Error",
            description: "Login Failed",
            type: ToastificationType.error,
          );
        }
      },
      child: SingleChildScrollView(
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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomButton(
                    title: state is LoadingLogin ? "Login..." : "Login",
                    isLoading: state is LoadingLogin,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await BlocProvider.of<LoginCubit>(
                          context,
                        ).login(emailController.text, passwordController.text);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
