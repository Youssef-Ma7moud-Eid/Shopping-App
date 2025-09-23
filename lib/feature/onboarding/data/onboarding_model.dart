class OnboardingData {
  final String title;
  final String description;
  final String image;
  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}
List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      title: 'Next',
      description: 'Now we are here to provide variety of the best fashion',
      image: 'assets/image/onboarding-1-screen.png',
    ),
    OnboardingData(
      title: 'Get started',
      description: 'Express your self through the art of the fashionism',
      image: 'assets/image/onboarding-2-screen.png',
    ),
  ];
}