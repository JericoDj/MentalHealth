import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to App',
      'description': 'Discover features that help you grow and connect.'
    },
    {
      'title': 'Easy to Use',
      'description': 'Our intuitive design makes it easy for everyone.'
    },
    {
      'title': 'Get Started Now',
      'description': 'Let’s dive right in and get you onboard!'
    },
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]['title']!,
                description: onboardingData[index]['description']!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => buildDot(index: index),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (currentPage == onboardingData.length - 1) {
                Get.to(() => const LoginScreen());
              } else {
                nextPage();
              }
            },
            child: Text(currentPage == onboardingData.length - 1 ? "Get Started" : "Next"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8),
      height: 12,
      width: currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, description;

  const OnboardingContent({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty Container or Placeholder Box (no images)
          SizedBox(
            height: 250,
            child: Center(
              child: Text(
                'No Image',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
