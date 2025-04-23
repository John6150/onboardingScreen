import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:onboardingscreen/onboardingScreen.dart';
import 'package:onboardingscreen/routes.dart';
import 'package:onboardingscreen/variables.dart';
import 'package:onboardingscreen/variables.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     // title: 'Flutter Demo',
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//     ),
//     home: const MyHomePage(),
//   );
// }
// }

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final FlutterSecureStorage storage = const FlutterSecureStorage();
      // // await storage.delete(key: 'isFirstRun');
      // ref.read(isFirstRun.notifier).state = await storage.read(
      //   key: 'isFirstRun',
      // );

      // print(ref.watch(isFirstRun));
      ref.read(ifr.notifier).state = await IsFirstRun.isFirstRun();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text('Onboarding Screen'),
      // ),
      body:
          ref.watch(ifr)
              ? OnBoardingScreen()
              : Scaffold(
                appBar: AppBar(title: Text('HomePage'), centerTitle: true),
                body: Container(color: Colors.deepPurpleAccent),
              ),
    );
  }
}
