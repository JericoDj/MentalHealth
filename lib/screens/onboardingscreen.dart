import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/screens/loginscreen.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/IMG_8289.JPG',
      'title': 'Welcome to Light Level App',
      'description': 'Your journey to better mental health starts here. Find support, track progress, and build resilience.'
    },
    {
      'image': 'assets/images/IMG_8246.JPG',
      'title': 'You Are Not Alone',
      'description': 'Find support through guided exercises, self-care tools, and a compassionate community.'
    },
    {
      'image': 'assets/images/IMG_8310.JPG',
      'title': 'We’re Here for You',
      'description': 'Whenever you need help, our resources and experts are just a tap away.'
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
                image: onboardingData[index]['image']!,
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
          GestureDetector(
            onTap: () {
              if (currentPage == onboardingData.length - 1) {
                Get.to(() => LoginScreen());
              } else {
                nextPage();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: MyColors.color2, // Background color
                borderRadius: BorderRadius.circular(8), // Optional rounded corners
              ),
              child: Text(
                currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        color: currentPage == index ? MyColors.color2 : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    Key? key,
    required this.image,
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
          // Image with Border
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.color2, width: 3), // Border around image
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Same as the container for consistency
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),

          // Centered Title
          Text(
            title,
            textAlign: TextAlign.center, // Center text
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),

          // Description
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
