import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:shopping_app/core/dialogs/app_toasts.dart';
import 'package:shopping_app/core/utils/validator_functions.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/auth/presentation/manager/register-cubit/register_cubit.dart';
import 'package:shopping_app/feature/auth/presentation/manager/register-cubit/register_state.dart';
import 'package:shopping_app/feature/auth/presentation/views/login_screen.dart';
import 'package:toastification/toastification.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessRegister) {
          AppToast.showToast(
            context: context,
            title: "Success",
            description: "Register Success",
            type: ToastificationType.success,
          );
        } else if (state is FauilreRegister) {
          AppToast.showToast(
            context: context,
            title: "Erorr",
            description: "Register Failed",
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
              Text(
                "Name",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                controller: nameController,
                validator: Validator.validateName,
                hintText: "Enter your name",
                keyboardType: TextInputType.name,
                action: TextInputAction.next,
              ),
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
              SizedBox(height: 30),
              Text(
                "Confirm Password",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                controller: confirmPasswordController,
                validator: (value) => Validator.validateConfirmPassword(
                  value,
                  passwordController.text,
                ),
                hintText: "Enter your confirm password",
                isPassword: true,
                keyboardType: TextInputType.emailAddress,
                action: TextInputAction.done,
              ),
              SizedBox(height: 30),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return CustomButton(
                    title: state is LoadingRegister ? "Sign Up..." : "Sign Up",
                    isLoading: state is LoadingRegister,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await BlocProvider.of<RegisterCubit>(context).register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
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
 