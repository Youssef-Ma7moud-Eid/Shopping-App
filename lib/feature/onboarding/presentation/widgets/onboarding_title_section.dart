import 'package:flutter/material.dart';
import 'package:shopping_app/feature/onboarding/data/onboarding_model.dart';

class OnboardingTitleSection extends StatelessWidget {
  const OnboardingTitleSection({
    super.key,
    required this.onboardingList,
    required this.index,
  });

  final List<OnboardingData> onboardingList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            onboardingList[index].title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff24252C),
            ),
          ),
          SizedBox(height: 20),
          Text(
            onboardingList[index].description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff6E6A7C),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}