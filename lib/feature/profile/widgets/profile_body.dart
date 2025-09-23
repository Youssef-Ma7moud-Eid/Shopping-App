import 'package:flutter/material.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper_keys.dart';
import 'package:shopping_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:shopping_app/core/dialogs/app_toasts.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/core/utils/validator_functions.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/auth/data/api/auth_api.dart';
import 'package:shopping_app/feature/profile/data/model/profile_model.dart';
import 'package:shopping_app/feature/profile/widgets/image_setion.dart';
import 'package:toastification/toastification.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  String token = CacheHelper().getData(key: CasheKeys.token);

  ProfileModel? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final result = await AuthApi.instance.getProfile(token);
    if (result is NetworkSuccess<ProfileModel>) {
      setState(() {
        profile = result.data;
        nameController.text = profile?.name ?? "";
        emailController.text = profile?.email ?? "";

        passwordController.text = profile?.password ?? "";
        isLoading = false;
      });
    } else if (result is NetworkFailure) {
      setState(() {
        isLoading = false;
      });
      AppToast.showToast(
        context: context,
        title: "Error",
        description: result.toString(),
        type: ToastificationType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: ImageSection()),
              const SizedBox(height: 50),

              const Text(
                "Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: nameController,
                validator: Validator.validateName,
                hintText: "Enter your name",
                keyboardType: TextInputType.name,
                action: TextInputAction.next,
              ),

              const SizedBox(height: 30),
              const Text(
                "Email",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: emailController,
                validator: Validator.validateEmail,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),

              const SizedBox(height: 30),
              const Text(
                "Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: passwordController,
                validator: Validator.validatePassword,
                hintText: "Enter your password",
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                action: TextInputAction.done,
              ),

              const SizedBox(height: 30),
              CustomButton(
                title: "Submit",
                onPressed: () {
                  if (key.currentState!.validate()) {
                    AppToast.showToast(
                      context: context,
                      title: "Success",
                      description: "Success Update Profile",
                      type: ToastificationType.success,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
