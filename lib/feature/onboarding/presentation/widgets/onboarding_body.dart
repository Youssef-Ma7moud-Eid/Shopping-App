import 'package:flutter/material.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/onboarding/presentation/widgets/onboarding_title_section.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopping_app/feature/auth/presentation/views/login_screen.dart';
import 'package:shopping_app/feature/onboarding/data/onboarding_model.dart';
import 'package:shopping_app/feature/onboarding/presentation/widgets/custom_animation.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  late List<OnboardingData> onboardingList;

  late PageController controller;
  late int index;

  @override
  void initState() {
    index = 0;
    controller = PageController();
    onboardingList = dataOnboarding();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemBuilder: (context, index) => CustomAnimatedWidget(
                  delay: index,
                  index: index,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      onboardingList[index].image,
                      width: 343,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                itemCount: onboardingList.length,
              ),
            ),
            const SizedBox(height: 35),
            SmoothPageIndicator(
              controller: controller,
              count: onboardingList.length,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                dotColor: const Color(0xffAFAFAF),
                activeDotColor: const Color(0xff212121),
              ),
            ),
            const SizedBox(height: 50),
            CustomAnimatedWidget(
              delay: (index + 1) * 100,
              index: index,
              child: OnboardingTitleSection(
                onboardingList: onboardingList,
                index: index,
              ),
            ),
            const SizedBox(height: 100),
            CustomButton(
              title: onboardingList[index].title,

              onPressed: () async {
                if (index < onboardingList.length - 1) {
                  controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                } else {
                    await CacheHelper().saveData(key: 'NewUser', value: true) ;
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(LoginScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


