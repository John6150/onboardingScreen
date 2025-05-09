import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
import 'package:is_first_run/is_first_run.dart';

import 'package:onboardingscreen/onboardingScreen.dart';
import 'package:onboardingscreen/routes.dart';
import 'package:onboardingscreen/variables.dart';
import 'package:onboardingscreen/variables.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: const MyApp()));
}

File? dpImg;
// File? compressedDpImg;
Uint8List? res;

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
                            // Map<String, dynamic> prod = await result();
                            // print('this is prod: $prod');
                            // if (prod != null) {
                            //   setState(() {
                            //     // count = prod['data'];
                            //   });
                            // }
                            ImagePicker picker = ImagePicker();
                            final XFile? img = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (img != null) {
                              // setState(() {
                              //   dpImg = File(img.path);
                              // });
                              
                              Uint8List ress = await testCompressFile(img);
                              setState(() {
                                res = ress;
                              });

                              final dir = await getTemporaryDirectory();

                              File finalImg =
                                  await File('${dir.path}/images.jpg').create();

                              await finalImg
                                  .writeAsString(img.path)
                                  .then(
                                    (re) => setState(() {
                                      dpImg = re;
                                    }),
                                  );

                              // print(finalImg);

                              // print;
                              // final Map<String, dynamic> result =
                              //     await postRequest(
                              //       'John',
                              //       '100',
                              //       'Flutter',
                              //       File(img.path),
                              //     );
                              // print(img.runtimeType);
                            }
                          },
                          child: Text(
                            'Click here',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 50),

                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.5,

                        //   child: ListView.builder(
                        //     itemCount: count.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         leading: CachedNetworkImage(
                        //           imageBuilder:
                        //               (context, imageProvider) => Container(
                        //                 decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                     image: imageProvider,
                        //                     fit: BoxFit.cover,
                        //                     colorFilter: ColorFilter.mode(
                        //                       Colors.red,
                        //                       BlendMode.colorBurn,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //           errorWidget:
                        //               (context, url, error) =>
                        //                   Icon(Icons.error),
                        //           imageUrl: '${count[index]['images'][0]}',
                        //           // imageUrl: 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
                        //           height: 30,
                        //           width: 30,
                        //           progressIndicatorBuilder: (
                        //             context,
                        //             url,
                        //             progress,
                        //           ) {
                        //             return CircularProgressIndicator(
                        //               value: progress.progress,
                        //             );
                        //           },
                        //         ),

                        //         // Image(image: CachedNetworkImageProvider(count[index]['images'][0],)),

                        //         //  Image.network(
                        //         //   count[index]['images'][0],
                        //         // ),
                        //         trailing: Icon(Icons.arrow_forward_ios_rounded),
                        //         title: Text(count[index]['title']),
                        //         subtitle: Text(count[index]['brand'] ?? ''),
                        //       );
                        //     },
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        dpImg == null
                            ? SizedBox()
                            : Image(image: FileImage(dpImg!)),
                        // Text(dpImg!.readAsBytes().toString()),
                        res == null ? SizedBox() : Image.memory(res!),
                        // Text('${res!.length.toString()} bytes '),
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
  final dio = Dio();
  final _axios = axios();

  // http.Response response;
  Response response;

  try {
    response = await _axios.get('/products');
    print(response);
    // Map<String, dynamic> res = {};
    Map<String, dynamic> res = jsonDecode(response.toString());
    print(res);
    //
    for (var element in res['products']) {
      count.add(element);
    }
    // print(count);
    return {'data': res['products']};
  } on DioException catch (e) {
    return {'status': 'failed', 'message': e};
  } catch (e) {
    return {'error': e};
  }
}

Dio axios([token]) {
  final dio = Dio();
  String _baseURL = dotenv.env['BASEURL'] ?? '';
  print(_baseURL);
  dio.options.baseUrl = _baseURL;
  // dio.options.baseUrl = 'https://dummyjson.com';
  dio.options.connectTimeout = (Duration(seconds: 5));
  dio.options.sendTimeout = Duration(seconds: 5);

  // dio.options.extra = {'id': ''};
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        dio.options.headers['accept'] = 'Application/Json';
        dio.options.headers['Authorization'] = 'Bearer $token';

        if (dio.options.extra['id'] != null) {
          return handler.next(options);
        } else {
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'Sorry the id you are sending is null',
              type: DioExceptionType.cancel,
            ),
          );
        }
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        Map<String, dynamic> res = {};

        switch (response.data['status']) {
          case 'success':
            res['statuscode'] = 200;
            res['data'] = response.data;
            break;
          case 'failed':
            res['statuscode'] = 400;
          default:
            return handler.next(response);
        }
        return handler.next(res as Response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        switch (error.type) {
          case DioExceptionType.badResponse:
            'sorry, there is a bad response';
            break;
          case DioExceptionType.connectionTimeout:
            'Sorry, slow network';
          case DioExceptionType.unknown:
            'Fatal error occurred';
          default:
        }
      },
    ),
  );

  return dio;
}

Future<Map<String, dynamic>> postRequest(
  name,
  age,
  studentsClass,
  File image,
) async {
  final dio = axios();
  try {
    FormData formData = FormData.fromMap({
      'post': '',
      'id': '',
      'description': '',
      'image': await MultipartFile.fromFile(image.path),
    });
    dio.post('', data: formData);
    return {};
  } catch (e) {
    return {};
  }
}

Future<Uint8List> testCompressFile(img) async {
  var result = await FlutterImageCompress.compressWithFile(
    img.path,
    minWidth: 500,
    minHeight: 500,
    quality: 100,
    // rotate: 90,
  );
  // print(file.lengthSync());
  print(result!.length);

  return result;
}
// 38957