import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:prize24_app/app/app.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/firebase_options_dev.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DevFirebaseOptions.currentPlatform,
  );

  await bootstrap(() => const App(), flavor: Flavor.staging);
}
