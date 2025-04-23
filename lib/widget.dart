import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:onboardingscreen/variables.dart';

class OnboardScreen extends ConsumerStatefulWidget {
  String? title;
  OnboardScreen({super.key, required this.title});

  @override
  ConsumerState<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/non-binary person shows victory.png',
                width: 150,
              ),
              SizedBox(height: 30),
              Text(
                widget.title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 0,
          child: TextButton(
            onPressed: () {
              onboardController.jumpToPage(3);
            },
            child: Text('Skip', style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          bottom: 30,

          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // width: ,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // ref.read(counterProvider.notifier).state -= 1;
                      onboardController.previousPage(
                        duration: Duration(milliseconds: 3),
                        curve: Curves.bounceIn,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text('Provious'),
                  ),
                  TextButton(
                    onPressed: () {
                      onboardController.nextPage(
                        duration: Duration(milliseconds: 3),
                        curve: Curves.bounceIn,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardScreenTwo extends ConsumerStatefulWidget {
  String? title;
  OnboardScreenTwo({super.key, required this.title});

  @override
  ConsumerState<OnboardScreenTwo> createState() => _OnboardScreenTwoState();
}

class _OnboardScreenTwoState extends ConsumerState<OnboardScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/non-binary person shows victory.png',
                width: 150,
              ),
              SizedBox(height: 30),
              Text(
                widget.title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 0,
          child: TextButton(
            onPressed: () {
              onboardController.jumpToPage(3);
            },
            child: Text('Skip', style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          bottom: 30,

          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // width: ,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // ref.read(counterProvider.notifier).state -= 1;
                      onboardController.previousPage(
                        duration: Duration(milliseconds: 3),
                        curve: Curves.bounceIn,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text('Previous'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await storage.write(key: 'isFirstRun', value: 'false');

                      context.go('/dashboard');
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: Text('Finish'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
