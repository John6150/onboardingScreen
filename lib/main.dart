import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
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

List count = [];

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
                body: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.purpleAccent,
                            ),
                          ),
                          onPressed: () async {
                            Map<String, dynamic> prod = await result();
                            setState(() {
                              count = prod['data'];
                            });
                          },
                          child: Text(
                            'Click here',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,

                          child: ListView.builder(
                            itemCount: count.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageBuilder:
                                      (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.red,
                                              BlendMode.colorBurn,
                                            ),
                                          ),
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          Icon(Icons.error),
                                  imageUrl: '${count[index]['images'][0]}',
                                  // imageUrl: 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
                                  height: 30,
                                  width: 30,
                                  progressIndicatorBuilder: (
                                    context,
                                    url,
                                    progress,
                                  ) {
                                    return CircularProgressIndicator(
                                      value: progress.progress,
                                    );
                                  },
                                ),

                                // Image(image: CachedNetworkImageProvider(count[index]['images'][0],)),

                                //  Image.network(
                                //   count[index]['images'][0],
                                // ),
                                trailing: Icon(Icons.arrow_forward_ios_rounded),
                                title: Text(count[index]['title']),
                                subtitle: Text(count[index]['brand'] ?? ''),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}

// class Product {
//   final String name;
//   Product({required this.name});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(name: json['name']);
//   }
// }

Future<Map<String, dynamic>> result() async {
  http.Response response;
  response = await http.get(Uri.parse('https://dummyjson.com/products'));
  Map<String, dynamic> res = jsonDecode(response.body);
  for (var element in res['products']) {
    // setstate({});
    count.add(element);
  }
  print(count);
  print(res);
  return {'data': res['products']};
}
