import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboardingscreen/variables.dart';
import 'package:onboardingscreen/widget.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('OnBoarding User')),
      body: PageView(
        controller: onboardController,
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {},
        children: [
          OnboardScreen(title: 'Welcome to this App'),
          OnboardScreen(title: '1'),
          OnboardScreen(title: '2'),
          OnboardScreen(title: '3'),
          OnboardScreenTwo(title: 'Finish'),
        ],
      ),
    );
  }
}
