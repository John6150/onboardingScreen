import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// String? isFirstRun;
final counterProvider = StateProvider((ref) => 0);
StateProvider<bool> ifr = StateProvider((ref) => false);
PageController onboardController = PageController();
bool isInit = false;
final FlutterSecureStorage storage = const FlutterSecureStorage();
