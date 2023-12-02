import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restest/app.dart';

void main() async {
  await init();
  runApp(const App());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  //setup initialize
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


