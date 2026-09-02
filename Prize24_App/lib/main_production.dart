import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prize24_app/app/app.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/firebase_options_prod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: ProdFirebaseOptions.currentPlatform);

  await bootstrap(
    () => const App(),
    flavor: Flavor.production,
    enableSentry: true,
    sentryDsn:
        'https://3375252ebf32f60135ff8d737b8bd3bc@o4510764627591168.ingest.us.sentry.io/4510764730220544',
  );
}
